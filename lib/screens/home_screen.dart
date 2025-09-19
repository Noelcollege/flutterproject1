import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _confirmLogout() async {
    final bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
    if (shouldLogout == true && mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('My Profile'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/student-profile');
                },
              ),
              ListTile(
                leading: const Icon(Icons.leaderboard_outlined),
                title: const Text('Leaderboard'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/leaderboard');
                },
              ),
              ListTile(
                leading: const Icon(Icons.school_outlined),
                title: const Text('Class'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/classes');
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log out'),
                onTap: _confirmLogout,
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
            const Text('Student Dashboard'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Log out',
            onPressed: _confirmLogout,
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: ListView(
                  controller: _scrollController,
                  children: [
                    // Dashboard Card
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
                                Icon(
                                  Icons.dashboard_customize_outlined,
                                  size: 28,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Student Dashboard',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 80,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: const [
                                    _CompactStatTile(
                                      title: 'Level',
                                      value: '12',
                                      icon: Icons.stacked_bar_chart,
                                    ),
                                    SizedBox(width: 12),
                                    _CompactStatTile(
                                      title: 'XP',
                                      value: '8,420',
                                      icon: Icons.bolt_outlined,
                                    ),
                                    SizedBox(width: 12),
                                    _CompactStatTile(
                                      title: 'Wins',
                                      value: '27',
                                      icon: Icons.emoji_events_outlined,
                                    ),
                                    SizedBox(width: 12),
                                    _CompactStatTile(
                                      title: 'Streak',
                                      value: '5🔥',
                                      icon:
                                          Icons.local_fire_department_outlined,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: FilledButton.icon(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/classes');
                                    },
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      size: 20,
                                    ),
                                    label: const Text('Start Learning'),
                                    style: FilledButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/leaderboard',
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.leaderboard,
                                      size: 20,
                                    ),
                                    label: const Text('Leaderboard'),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Environment Studies Section
                    const SizedBox(height: 16),
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
                                Icon(Icons.eco, color: Colors.green, size: 28),
                                SizedBox(width: 8),
                                Text(
                                  'Environment Studies',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Explore 17 comprehensive chapters covering environment, energy, safety, and more.',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/chapters');
                                },
                                icon: const Icon(Icons.menu_book, size: 20),
                                label: const Text('View All Chapters'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                              ),
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

// Removed old _StatTile in favor of compact horizontal tiles

class _CompactStatTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _CompactStatTile({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: Colors.indigo),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Leaderboard list now lives in LeaderboardScreen

// Removed _LeaderboardEntry; leaderboard now in LeaderboardScreen
