import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import 'class_chapters_screen.dart';

class ClassSelectionScreen extends StatelessWidget {
  static const String routeName = '/classes';

  const ClassSelectionScreen({super.key});

  void _goToChapters(BuildContext context, String className) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClassChaptersScreen(className: className),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Class'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.school, size: 32, color: Colors.green),
                          const SizedBox(width: 12),
                          const Text(
                            'Choose Your Class',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Punjab Board - Environmental Education',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      _ClassButton(
                        title: 'Class 11th',
                        subtitle: 'Environmental Studies',
                        icon: Icons.eco,
                        onPressed: () => _goToChapters(context, 'Class 11'),
                      ),
                      const SizedBox(height: 16),
                      _ClassButton(
                        title: 'Class 12th',
                        subtitle: 'Environmental Studies',
                        icon: Icons.eco,
                        onPressed: () => _goToChapters(context, 'Class 12'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ClassButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onPressed;

  const _ClassButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 24, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withOpacity(0.8),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
