import 'package:flutter/material.dart';
import '../services/google_auth_service.dart';
import '../widgets/scroll_notification_wrapper.dart';
import '../screens/home_tab_screen.dart';
import '../screens/class_tab_screen.dart';
import '../screens/course_tab_screen.dart';
import '../screens/menu_tab_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/notification_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final GoogleAuthService _authService = GoogleAuthService();
  final ScrollController _scrollController = ScrollController();
  bool _showShadow = false;
  int _unreadNotificationCount = 2; // This can be fetched from a service later

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final showShadow = _scrollController.offset > 0;
    if (showShadow != _showShadow) {
      setState(() {
        _showShadow = showShadow;
      });
    }
  }

  final List<Widget> _screens = [
    const HomeTabScreen(),
    const ClassTabScreen(),
    const CourseTabScreen(),
    const SizedBox(), // Placeholder for menu tab since it will navigate
  ];

  void _onTabTapped(int index) {
    if (index == 3) { // Menu tab
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const MenuTabScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _navigateToProfile() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const ProfileScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToNotifications() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const NotificationScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    ).then((_) {
      // Update notification count when returning from notification screen
      // In a real app, this would be managed by a state management solution
      setState(() {
        _unreadNotificationCount = 0; // Mark all as read after viewing
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('PrepinBengali', style: TextStyle(fontSize: 30)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 4.0,
        shadowColor: Theme.of(context).colorScheme.shadow,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: _navigateToNotifications,
                icon: const Icon(Icons.notifications_outlined, size: 34,),
              ),
              // Notification badge (dynamic count)
              if (_unreadNotificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      _unreadNotificationCount > 99 ? '99+' : '$_unreadNotificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            onPressed: _navigateToProfile,
            icon: CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).colorScheme.primary,
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : null,
              child: user?.photoURL == null
                  ? Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 20,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ScrollNotificationWrapper(
        onScrollChanged: (isScrolled) {
          if (isScrolled != _showShadow) {
            setState(() {
              _showShadow = isScrolled;
            });
          }
        },
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, -2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: NavigationBar(
          indicatorColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
          selectedIndex: _currentIndex,
          onDestinationSelected: _onTabTapped,
          backgroundColor: Theme.of(context).colorScheme.surface,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: Colors.white),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.school_outlined),
              selectedIcon: Icon(Icons.school, color: Colors.white),
              label: 'Class',
            ),
            NavigationDestination(
              icon: Icon(Icons.book_outlined),
              selectedIcon: Icon(Icons.book, color: Colors.white),
              label: 'Course',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_outlined),
              selectedIcon: Icon(Icons.menu, color: Colors.white),
              label: 'Menu',
            ),
          ],
        ),
      ),
    );
  }
}
