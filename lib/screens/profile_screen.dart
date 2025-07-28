import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/google_auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/auth_wrapper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GoogleAuthService _authService = GoogleAuthService();
  bool _isEditing = false;
  
  // Controllers for editable fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  
  // Onboarding data
  DateTime? _dateOfBirth;
  String? _selectedClass;
  String _parentName = '';
  String _whatsappNumber = '';
  String _address = '';

  @override
  void initState() {
    super.initState();
    final user = _authService.currentUser;
    _nameController.text = user?.displayName ?? '';
    _bioController.text = 'Bengali language enthusiast'; // Default bio
    _loadOnboardingData();
  }
  
  Future<void> _loadOnboardingData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load date of birth
    final dobString = prefs.getString('date_of_birth');
    if (dobString != null) {
      _dateOfBirth = DateTime.tryParse(dobString);
    }
    
    // Load other onboarding data
    _selectedClass = prefs.getString('selected_class');
    _parentName = prefs.getString('parent_name') ?? '';
    _whatsappNumber = prefs.getString('whatsapp_number') ?? '';
    _address = prefs.getString('address') ?? '';
    
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('PrepInBengali'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 4.0,
        shadowColor: Theme.of(context).colorScheme.shadow,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
              if (!_isEditing) {
                // Save changes logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture Section
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : null,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: user?.photoURL == null
                        ? Icon(
                            Icons.person,
                            size: 60,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        : null,
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 20,
                          ),
                          onPressed: () {
                            // TODO: Implement image picker
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Image picker coming soon!'),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Profile Information Card
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppTheme.getCardShadow(context),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile Information',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Name Field
                    _buildProfileField(
                      context,
                      label: 'Name',
                      controller: _nameController,
                      icon: Icons.person_rounded,
                      isEditable: _isEditing,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Email Field (Read-only)
                    _buildProfileField(
                      context,
                      label: 'Email',
                      value: user?.email ?? 'No email',
                      icon: Icons.email_rounded,
                      isEditable: false,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Bio Field
                    _buildProfileField(
                      context,
                      label: 'Bio',
                      controller: _bioController,
                      icon: Icons.info_rounded,
                      isEditable: _isEditing,
                      maxLines: 3,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Join Date (Read-only)
                    _buildProfileField(
                      context,
                      label: 'Member since',
                      value: user?.metadata.creationTime?.toString().split(' ')[0] ?? 'Unknown',
                      icon: Icons.calendar_today_rounded,
                      isEditable: false,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Personal Information Card (from onboarding)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppTheme.getCardShadow(context),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Personal Information',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        // Edit Personal Info Button
                        TextButton.icon(
                          onPressed: () {
                            // Navigate to onboarding to update information
                            Navigator.of(context).pushNamed('/onboarding').then((_) {
                              // Reload data when returning from onboarding
                              _loadOnboardingData();
                            });
                          },
                          icon: const Icon(Icons.edit_rounded, size: 16),
                          label: const Text('Update'),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Date of Birth
                    _buildProfileField(
                      context,
                      label: 'Date of Birth',
                      value: _dateOfBirth != null 
                          ? '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}'
                          : 'Not provided',
                      icon: Icons.cake_rounded,
                      isEditable: false,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Class
                    _buildProfileField(
                      context,
                      label: 'Class',
                      value: _selectedClass != null ? 'Class $_selectedClass' : 'Not selected',
                      icon: Icons.school_rounded,
                      isEditable: false,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Parent/Guardian Name
                    _buildProfileField(
                      context,
                      label: 'Parent/Guardian',
                      value: _parentName.isNotEmpty ? _parentName : 'Not provided',
                      icon: Icons.family_restroom_rounded,
                      isEditable: false,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // WhatsApp Number
                    _buildProfileField(
                      context,
                      label: 'WhatsApp',
                      value: _whatsappNumber.isNotEmpty ? '+91 $_whatsappNumber' : 'Not provided',
                      icon: Icons.phone_rounded,
                      isEditable: false,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Address
                    _buildProfileField(
                      context,
                      label: 'Address',
                      value: _address.isNotEmpty ? _address : 'Not provided',
                      icon: Icons.location_on_rounded,
                      isEditable: false,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Statistics Card
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppTheme.getCardShadow(context),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Learning Statistics',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatItem(
                            context,
                            icon: Icons.book_rounded,
                            title: 'Courses',
                            value: '3',
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatItem(
                            context,
                            icon: Icons.quiz_rounded,
                            title: 'Tests',
                            value: '15',
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatItem(
                            context,
                            icon: Icons.timer_rounded,
                            title: 'Hours',
                            value: '24',
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatItem(
                            context,
                            icon: Icons.trending_up_rounded,
                            title: 'Streak',
                            value: '7 days',
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Account Actions
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppTheme.getCardShadow(context),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.security_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: const Text('Privacy Settings'),
                    subtitle: const Text('Manage your privacy preferences'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    onTap: () {
                      // TODO: Navigate to privacy settings
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Privacy settings coming soon!')),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.notifications_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: const Text('Notification Settings'),
                    subtitle: const Text('Configure your notifications'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    onTap: () {
                      // TODO: Navigate to notification settings
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Notification settings coming soon!')),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout_rounded,
                      color: Colors.red,
                    ),
                    title: const Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.red),
                    ),
                    subtitle: const Text('Sign out of your account'),
                    onTap: () => _showSignOutDialog(),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProfileField(
    BuildContext context, {
    required String label,
    TextEditingController? controller,
    String? value,
    required IconData icon,
    required bool isEditable,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: isEditable && controller != null
                  ? TextField(
                      controller: controller,
                      maxLines: maxLines,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        controller?.text ?? value ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog
                
                try {
                  await _authService.signOut();
                  
                  if (mounted) {
                    // Navigate back to the root and replace with AuthWrapper
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const AuthWrapper(),
                      ),
                      (route) => false,
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error signing out: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
