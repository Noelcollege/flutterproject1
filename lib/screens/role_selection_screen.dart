import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import '../widgets/page_transition.dart';
import '../services/school_service.dart';
import 'teacher_verification_screen.dart';
import 'home_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  static const String routeName = '/role-selection';

  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _schoolSearchController = TextEditingController();

  String? _selectedRole;
  String? _selectedClass;
  String? _selectedSchool;
  List<String> _filteredSchools = [];
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _filteredSchools = SchoolService.getAllSchools();
    _schoolSearchController.addListener(_filterSchools);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _schoolSearchController.dispose();
    super.dispose();
  }

  void _filterSchools() {
    setState(() {
      _filteredSchools = SchoolService.searchSchools(
        _schoolSearchController.text,
      );
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    if (_selectedRole == 'student') {
      // Redirect to student homepage
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else if (_selectedRole == 'teacher') {
      // Redirect to teacher verification
      Navigator.pushReplacement(
        context,
        FadeSlidePageRoute(
          page: TeacherVerificationScreen(
            fullName: _fullNameController.text.trim(),
            schoolName: _selectedSchool!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                20 + MediaQuery.of(context).viewInsets.bottom,
              ),
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
                    child: Form(
                      key: _formKey,
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
                                'Complete Your Profile',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Full Name Field
                          TextFormField(
                            controller: _fullNameController,
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              prefixIcon: Icon(Icons.person_outline),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                            ),
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                ? 'Enter your full name'
                                : null,
                          ),
                          const SizedBox(height: 16),

                          // Role Selection
                          const Text(
                            'Select Your Role',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text('Student'),
                                  value: 'student',
                                  groupValue: _selectedRole,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedRole = value;
                                      _selectedClass = null;
                                    });
                                  },
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  title: const Text('Teacher'),
                                  value: 'teacher',
                                  groupValue: _selectedRole,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedRole = value;
                                      _selectedClass = null;
                                    });
                                  },
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),

                          // Class Selection for Students
                          if (_selectedRole == 'student') ...[
                            const SizedBox(height: 16),
                            const Text(
                              'Select Your Class',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: const Text('11th'),
                                    value: '11th',
                                    groupValue: _selectedClass,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedClass = value;
                                      });
                                    },
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: const Text('12th'),
                                    value: '12th',
                                    groupValue: _selectedClass,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedClass = value;
                                      });
                                    },
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ],
                            ),
                          ],

                          // School Selection
                          const SizedBox(height: 16),
                          const Text(
                            'Select Your School',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _schoolSearchController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Search and select school',
                              prefixIcon: Icon(Icons.school_outlined),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => _SchoolSearchDialog(
                                  schools: _filteredSchools,
                                  onSchoolSelected: (school) {
                                    setState(() {
                                      _selectedSchool = school;
                                      _schoolSearchController.text = school;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                            validator: (_) =>
                                (_selectedSchool == null ||
                                    _selectedSchool!.isEmpty)
                                ? 'Select your school'
                                : null,
                          ),

                          const SizedBox(height: 24),

                          // Submit Button
                          SizedBox(
                            height: 50,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF2753DB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: _isSubmitting ? null : _submit,
                              child: _isSubmitting
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text('Continue'),
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _SchoolSearchDialog extends StatefulWidget {
  final List<String> schools;
  final Function(String) onSchoolSelected;

  const _SchoolSearchDialog({
    required this.schools,
    required this.onSchoolSelected,
  });

  @override
  State<_SchoolSearchDialog> createState() => _SchoolSearchDialogState();
}

class _SchoolSearchDialogState extends State<_SchoolSearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredSchools = [];

  @override
  void initState() {
    super.initState();
    _filteredSchools = widget.schools;
    _searchController.addListener(_filterSchools);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSchools() {
    setState(() {
      _filteredSchools = widget.schools
          .where(
            (school) => school.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: screenSize.height * 0.85,
          maxWidth: 500,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search schools',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredSchools.length,
                    itemBuilder: (context, index) {
                      final school = _filteredSchools[index];
                      return ListTile(
                        title: Text(school),
                        onTap: () => widget.onSchoolSelected(school),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
