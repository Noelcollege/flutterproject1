import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/role_selection_screen.dart';
import 'screens/teacher_verification_screen.dart';
import 'screens/teacher_dashboard_screen.dart';
import 'screens/manage_students_screen.dart';
import 'screens/manage_curriculum_screen.dart';
import 'screens/home_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/class_selection_screen.dart';
import 'screens/student_profile_screen.dart';
import 'screens/teacher_profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeedUp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        RoleSelectionScreen.routeName: (context) => const RoleSelectionScreen(),
        TeacherVerificationScreen.routeName: (context) =>
            const TeacherVerificationScreen(fullName: '', schoolName: ''),
        TeacherDashboardScreen.routeName: (context) =>
            const TeacherDashboardScreen(),
        ManageStudentsScreen.routeName: (context) =>
            const ManageStudentsScreen(),
        ManageCurriculumScreen.routeName: (context) =>
            const ManageCurriculumScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        LeaderboardScreen.routeName: (context) => const LeaderboardScreen(),
        ClassSelectionScreen.routeName: (context) =>
            const ClassSelectionScreen(),
        StudentProfileScreen.routeName: (context) =>
            const StudentProfileScreen(),
        TeacherProfileScreen.routeName: (context) =>
            const TeacherProfileScreen(),
      },
    );
  }
}
