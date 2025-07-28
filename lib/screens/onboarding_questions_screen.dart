import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

class OnboardingQuestionsScreen extends StatefulWidget {
  const OnboardingQuestionsScreen({super.key});

  @override
  State<OnboardingQuestionsScreen> createState() => _OnboardingQuestionsScreenState();
}

class _OnboardingQuestionsScreenState extends State<OnboardingQuestionsScreen> {
  late PageController _pageController;
  late TextEditingController _parentNameController;
  late TextEditingController _whatsappController;
  late TextEditingController _addressController;
  
  int _currentQuestionIndex = 0;
  bool _isAnimating = false;

  // User responses
  DateTime? _dateOfBirth;
  String? _selectedClass;

  final List<String> _availableClasses = ['9', '10', '11', '12'];

  final List<OnboardingQuestion> _questions = [
    OnboardingQuestion(
      title: 'Date of Birth',
      subtitle: 'When were you born?',
      isOptional: true,
      questionType: QuestionType.datePicker,
    ),
    OnboardingQuestion(
      title: 'Class',
      subtitle: 'Which class are you currently in?',
      isOptional: false,
      questionType: QuestionType.singleChoice,
    ),
    OnboardingQuestion(
      title: 'Parent/Guardian Name',
      subtitle: 'Who is your parent or guardian?',
      isOptional: false,
      questionType: QuestionType.textInput,
    ),
    OnboardingQuestion(
      title: 'WhatsApp Number',
      subtitle: 'Your WhatsApp number for updates',
      isOptional: false,
      questionType: QuestionType.phoneInput,
    ),
    OnboardingQuestion(
      title: 'Address',
      subtitle: 'Where do you live?',
      isOptional: true,
      questionType: QuestionType.textInput,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _parentNameController = TextEditingController();
    _whatsappController = TextEditingController();
    _addressController = TextEditingController();
    _loadExistingData();
  }
  
  Future<void> _loadExistingData() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load existing data if available (for editing)
    final dobString = prefs.getString('date_of_birth');
    if (dobString != null) {
      _dateOfBirth = DateTime.tryParse(dobString);
    }
    
    _selectedClass = prefs.getString('selected_class');
    _parentNameController.text = prefs.getString('parent_name') ?? '';
    _whatsappController.text = prefs.getString('whatsapp_number') ?? '';
    _addressController.text = prefs.getString('address') ?? '';
    
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    _parentNameController.dispose();
    _whatsappController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _nextQuestion() async {
    if (_isAnimating) return;

    // Validate current question if not optional
    if (!_questions[_currentQuestionIndex].isOptional && !_isCurrentQuestionAnswered()) {
      _showValidationError();
      return;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _isAnimating = true;
      });

      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      
      setState(() {
        _currentQuestionIndex++;
        _isAnimating = false;
      });
    } else {
      _completeOnboarding();
    }
  }

  void _skipQuestion() {
    if (_questions[_currentQuestionIndex].isOptional) {
      _nextQuestion();
    }
  }

  void _previousQuestion() async {
    if (_currentQuestionIndex > 0 && !_isAnimating) {
      setState(() {
        _isAnimating = true;
      });

      await _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      
      setState(() {
        _currentQuestionIndex--;
        _isAnimating = false;
      });
    }
  }

  bool _isCurrentQuestionAnswered() {
    switch (_currentQuestionIndex) {
      case 0: // Date of Birth (optional)
        return true;
      case 1: // Class
        return _selectedClass != null;
      case 2: // Parent Name
        return _parentNameController.text.trim().isNotEmpty;
      case 3: // WhatsApp Number
        return _whatsappController.text.trim().isNotEmpty;
      case 4: // Address (optional)
        return true;
      default:
        return false;
    }
  }

  void _showValidationError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please answer this question before continuing'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _completeOnboarding() async {
    // Save onboarding completion status
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    
    // Save user responses to SharedPreferences
    if (_dateOfBirth != null) {
      await prefs.setString('date_of_birth', _dateOfBirth!.toIso8601String());
    }
    if (_selectedClass != null) {
      await prefs.setString('selected_class', _selectedClass!);
    }
    if (_parentNameController.text.trim().isNotEmpty) {
      await prefs.setString('parent_name', _parentNameController.text.trim());
    }
    if (_whatsappController.text.trim().isNotEmpty) {
      await prefs.setString('whatsapp_number', _whatsappController.text.trim());
    }
    if (_addressController.text.trim().isNotEmpty) {
      await prefs.setString('address', _addressController.text.trim());
    }
    
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Setup Profile',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        '${_currentQuestionIndex + 1}/${_questions.length}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: (_currentQuestionIndex + 1) / _questions.length,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            
            // Question Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: _buildQuestionCard(_questions[index], index),
                  );
                },
              ),
            ),
            
            // Navigation Buttons
            Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (_currentQuestionIndex > 0)
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: _previousQuestion,
                            child: const Text('Back'),
                          ),
                        ),
                      if (_currentQuestionIndex > 0) const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _nextQuestion,
                          child: Text(
                            _currentQuestionIndex == _questions.length - 1
                                ? 'Complete'
                                : 'Next',
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_questions[_currentQuestionIndex].isOptional)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: TextButton(
                        onPressed: _skipQuestion,
                        child: const Text('Skip this question'),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(OnboardingQuestion question, int index) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.getCardShadow(context),
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                question.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              if (question.isOptional)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Optional',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            question.subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: _buildQuestionInput(question, index),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionInput(OnboardingQuestion question, int index) {
    switch (question.questionType) {
      case QuestionType.datePicker:
        return _buildDatePicker();
      case QuestionType.singleChoice:
        return _buildClassSelector();
      case QuestionType.textInput:
        return _buildTextInput(index);
      case QuestionType.phoneInput:
        return _buildPhoneInput();
    }
  }

  Widget _buildDatePicker() {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: _dateOfBirth ?? DateTime(2005),
              firstDate: DateTime(1990),
              lastDate: DateTime(2015),
            );
            if (picked != null) {
              setState(() {
                _dateOfBirth = picked;
              });
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  _dateOfBirth != null
                      ? '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}'
                      : 'Select your date of birth',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClassSelector() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.5,
      ),
      itemCount: _availableClasses.length,
      itemBuilder: (context, index) {
        final classItem = _availableClasses[index];
        final isSelected = _selectedClass == classItem;
        
        return InkWell(
          onTap: () {
            setState(() {
              _selectedClass = classItem;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline,
              ),
            ),
            child: Center(
              child: Text(
                'Class $classItem',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextInput(int questionIndex) {
    TextEditingController controller;
    String hint;
    IconData icon;
    
    if (questionIndex == 2) { // Parent Name
      controller = _parentNameController;
      hint = 'Enter parent/guardian name';
      icon = Icons.person;
    } else { // Address
      controller = _addressController;
      hint = 'Enter your address';
      icon = Icons.location_on;
    }
    
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildPhoneInput() {
    return TextField(
      controller: _whatsappController,
      decoration: InputDecoration(
        hintText: 'Enter WhatsApp number',
        prefixIcon: Icon(
          Icons.phone,
          color: Theme.of(context).colorScheme.primary,
        ),
        prefixText: '+91 ',
      ),
      keyboardType: TextInputType.phone,
    );
  }
}

class OnboardingQuestion {
  final String title;
  final String subtitle;
  final bool isOptional;
  final QuestionType questionType;

  OnboardingQuestion({
    required this.title,
    required this.subtitle,
    required this.isOptional,
    required this.questionType,
  });
}

enum QuestionType {
  datePicker,
  singleChoice,
  textInput,
  phoneInput,
}
