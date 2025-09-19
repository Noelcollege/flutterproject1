import 'package:flutter/material.dart';
import '../widgets/app_background.dart';
import 'manage_students_screen.dart';
import 'manage_curriculum_screen.dart';

class TeacherDashboardScreen extends StatefulWidget {
  static const String routeName = '/teacher-dashboard';

  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF2753DB)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: Color(0xFF2753DB),
                        size: 30,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Teacher Dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dashboard_outlined),
                title: const Text('Dashboard'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('My Profile'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/teacher-profile');
                },
              ),
              ListTile(
                leading: const Icon(Icons.people_outline),
                title: const Text('Manage Students'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ManageStudentsScreen.routeName);
                },
              ),
              ListTile(
                leading: const Icon(Icons.menu_book_outlined),
                title: const Text('Manage Curriculum'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    ManageCurriculumScreen.routeName,
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log out'),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/logo/app_icon.jpg',
                width: 28,
                height: 28,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            const Text('Teacher Dashboard'),
          ],
        ),
      ),
      body: AppBackground(
        imageAsset: 'assets/logo/app_icon.jpg',
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: ListView(
                  children: [
                    // Welcome Card
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.school_outlined),
                                SizedBox(width: 8),
                                Text(
                                  'Welcome to Teacher Dashboard',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Manage your students, curriculum, and track their progress all in one place.',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Quick Actions Grid
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Quick Actions',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 16),
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.3,
                              children: [
                                _QuickActionCard(
                                  icon: Icons.people_outline,
                                  title: 'Manage Students',
                                  subtitle: 'View and organize students',
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    ManageStudentsScreen.routeName,
                                  ),
                                ),
                                _QuickActionCard(
                                  icon: Icons.menu_book_outlined,
                                  title: 'Manage Curriculum',
                                  subtitle: 'Create and modify content',
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    ManageCurriculumScreen.routeName,
                                  ),
                                ),
                                _QuickActionCard(
                                  icon: Icons.analytics_outlined,
                                  title: 'Analytics',
                                  subtitle: 'Track student progress',
                                  onTap: () {},
                                ),
                                _QuickActionCard(
                                  icon: Icons.assignment_outlined,
                                  title: 'Assignments',
                                  subtitle: 'Create and grade tasks',
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Recent Activity
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Recent Activity',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const _ActivityItem(
                              icon: Icons.person_add,
                              title: 'New student registered',
                              subtitle: 'John Doe joined your class',
                              time: '2 hours ago',
                            ),
                            const _ActivityItem(
                              icon: Icons.assignment_turned_in,
                              title: 'Assignment submitted',
                              subtitle: 'Math Quiz - 15 students completed',
                              time: '4 hours ago',
                            ),
                            const _ActivityItem(
                              icon: Icons.quiz,
                              title: 'Quiz created',
                              subtitle: 'Science Chapter 5 Quiz',
                              time: '1 day ago',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  State<_QuickActionCard> createState() => _QuickActionCardState();
}

class _QuickActionCardState extends State<_QuickActionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
        _animationController.forward();
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Card(
              elevation: _isHovered ? 8 : 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.icon,
                        size: _isHovered ? 36 : 32,
                        color: _isHovered
                            ? Colors.green
                            : const Color(0xFF2753DB),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _isHovered ? Colors.green.shade700 : null,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;

  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF2753DB).withOpacity(0.1),
            child: Icon(icon, size: 20, color: const Color(0xFF2753DB)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
