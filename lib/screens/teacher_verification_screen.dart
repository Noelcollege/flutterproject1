import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import '../widgets/page_transition.dart';
import 'teacher_dashboard_screen.dart';

class TeacherVerificationScreen extends StatefulWidget {
  static const String routeName = '/teacher-verification';
  final String fullName;
  final String schoolName;

  const TeacherVerificationScreen({
    super.key,
    required this.fullName,
    required this.schoolName,
  });

  @override
  State<TeacherVerificationScreen> createState() => _TeacherVerificationScreenState();
}

class _TeacherVerificationScreenState extends State<TeacherVerificationScreen> {
  bool _isEmailSent = false;
  bool _isVerifying = false;

  Future<void> _sendVerificationEmail() async {
    setState(() => _isVerifying = true);
    
    // Simulate sending verification email
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isEmailSent = true;
      _isVerifying = false;
    });
  }

  Future<void> _checkVerification() async {
    setState(() => _isVerifying = true);
    
    // Simulate checking verification status
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() => _isVerifying = false);
    
    // For demo purposes, assume verification is successful
    if (mounted) {
      Navigator.pushReplacement(
        context,
        FadeSlidePageRoute(
          page: const TeacherDashboardScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Card(
                color: Colors.white.withOpacity(0.9),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/logo/app_icon.jpg',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Teacher Verification',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      Icon(
                        Icons.verified_user_outlined,
                        size: 80,
                        color: Colors.blue.shade300,
                      ),
                      const SizedBox(height: 16),
                      
                      Text(
                        'Welcome, ${widget.fullName}!',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      
                      Text(
                        'School: ${widget.schoolName}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      
                      if (!_isEmailSent) ...[
                        const Text(
                          'To complete your teacher registration, we need to verify your association with your school.',
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        
                        const Text(
                          'We will send a verification email to your school\'s administration. They will need to confirm your teacher status.',
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        
                        SizedBox(
                          height: 50,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF2753DB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: _isVerifying ? null : _sendVerificationEmail,
                            child: _isVerifying
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Send Verification Email'),
                          ),
                        ),
                      ] else ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green.shade200),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                color: Colors.green.shade600,
                                size: 32,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Verification email sent!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Please check with your school administration to confirm your teacher status.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        const Text(
                          'Once your school administration confirms your teacher status, you can proceed to your dashboard.',
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        
                        SizedBox(
                          height: 50,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF2753DB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: _isVerifying ? null : _checkVerification,
                            child: _isVerifying
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Check Verification Status'),
                          ),
                        ),
                      ],
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
