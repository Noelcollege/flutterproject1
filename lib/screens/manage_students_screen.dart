import 'package:flutter/material.dart';
import '../widgets/app_background.dart';

class ManageStudentsScreen extends StatefulWidget {
  static const String routeName = '/manage-students';

  const ManageStudentsScreen({super.key});

  @override
  State<ManageStudentsScreen> createState() => _ManageStudentsScreenState();
}

class _ManageStudentsScreenState extends State<ManageStudentsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedClass = 'All';
  final List<String> _selectedStudents = [];
  bool _isSelectMode = false;

  // Mock student data
  final List<Map<String, dynamic>> _students = [
    {
      'id': '1',
      'name': 'Aarav Sharma',
      'class': '11th',
      'rollNumber': '001',
      'email': 'aarav.sharma@school.edu',
      'isSelected': false,
    },
    {
      'id': '2',
      'name': 'Ananya Singh',
      'class': '11th',
      'rollNumber': '002',
      'email': 'ananya.singh@school.edu',
      'isSelected': false,
    },
    {
      'id': '3',
      'name': 'Arjun Patel',
      'class': '12th',
      'rollNumber': '003',
      'email': 'arjun.patel@school.edu',
      'isSelected': false,
    },
    {
      'id': '4',
      'name': 'Bhavya Gupta',
      'class': '11th',
      'rollNumber': '004',
      'email': 'bhavya.gupta@school.edu',
      'isSelected': false,
    },
    {
      'id': '5',
      'name': 'Chetan Kumar',
      'class': '12th',
      'rollNumber': '005',
      'email': 'chetan.kumar@school.edu',
      'isSelected': false,
    },
    {
      'id': '6',
      'name': 'Deepika Verma',
      'class': '11th',
      'rollNumber': '006',
      'email': 'deepika.verma@school.edu',
      'isSelected': false,
    },
    {
      'id': '7',
      'name': 'Esha Joshi',
      'class': '12th',
      'rollNumber': '007',
      'email': 'esha.joshi@school.edu',
      'isSelected': false,
    },
    {
      'id': '8',
      'name': 'Faisal Khan',
      'class': '11th',
      'rollNumber': '008',
      'email': 'faisal.khan@school.edu',
      'isSelected': false,
    },
  ];

  List<Map<String, dynamic>> get _filteredStudents {
    var filtered = _students.where((student) {
      final matchesSearch = student['name'].toLowerCase().contains(
        _searchController.text.toLowerCase(),
      );
      final matchesClass =
          _selectedClass == 'All' || student['class'] == _selectedClass;
      return matchesSearch && matchesClass;
    }).toList();

    // Sort alphabetically
    filtered.sort((a, b) => a['name'].compareTo(b['name']));
    return filtered;
  }

  void _toggleSelectMode() {
    setState(() {
      _isSelectMode = !_isSelectMode;
      if (!_isSelectMode) {
        _selectedStudents.clear();
        for (var student in _students) {
          student['isSelected'] = false;
        }
      }
    });
  }

  void _toggleStudentSelection(String studentId) {
    setState(() {
      final student = _students.firstWhere((s) => s['id'] == studentId);
      student['isSelected'] = !student['isSelected'];

      if (student['isSelected']) {
        _selectedStudents.add(studentId);
      } else {
        _selectedStudents.remove(studentId);
      }
    });
  }

  void _createGroup() {
    if (_selectedStudents.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select students to create a group'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => _CreateGroupDialog(
        selectedStudentIds: _selectedStudents,
        students: _students,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Students'),
        actions: [
          IconButton(
            icon: Icon(_isSelectMode ? Icons.close : Icons.checklist),
            onPressed: _toggleSelectMode,
            tooltip: _isSelectMode ? 'Cancel Selection' : 'Select Students',
          ),
          if (_isSelectMode && _selectedStudents.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.group_add),
              onPressed: _createGroup,
              tooltip: 'Create Group',
            ),
        ],
      ),
      body: AppBackground(
        imageAsset: 'assets/logo/app_icon.jpg',
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search and Filter Bar
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            labelText: 'Search students',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) => setState(() {}),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text('Filter by class: '),
                            const SizedBox(width: 8),
                            DropdownButton<String>(
                              value: _selectedClass,
                              items: ['All', '11th', '12th'].map((
                                String value,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedClass = newValue!;
                                });
                              },
                            ),
                            const Spacer(),
                            Text(
                              '${_filteredStudents.length} students',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Students List
                Expanded(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.builder(
                      itemCount: _filteredStudents.length,
                      itemBuilder: (context, index) {
                        final student = _filteredStudents[index];
                        final isSelected = student['isSelected'] as bool;

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isSelected
                                ? const Color(0xFF2753DB)
                                : Colors.grey.shade300,
                            child: isSelected
                                ? const Icon(Icons.check, color: Colors.white)
                                : Text(
                                    student['name'][0],
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey.shade700,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                          title: Text(
                            student['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xFF2753DB)
                                  : null,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Class: ${student['class']} | Roll: ${student['rollNumber']}',
                              ),
                              Text(
                                student['email'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          trailing: _isSelectMode
                              ? Checkbox(
                                  value: isSelected,
                                  onChanged: (_) =>
                                      _toggleStudentSelection(student['id']),
                                )
                              : IconButton(
                                  icon: const Icon(Icons.more_vert),
                                  onPressed: () => _showStudentOptions(student),
                                ),
                          onTap: _isSelectMode
                              ? () => _toggleStudentSelection(student['id'])
                              : null,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showStudentOptions(Map<String, dynamic> student) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Profile'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to student profile
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('View Assignments'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to student assignments
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('View Progress'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to student progress
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateGroupDialog extends StatefulWidget {
  final List<String> selectedStudentIds;
  final List<Map<String, dynamic>> students;

  const _CreateGroupDialog({
    required this.selectedStudentIds,
    required this.students,
  });

  @override
  State<_CreateGroupDialog> createState() => _CreateGroupDialogState();
}

class _CreateGroupDialogState extends State<_CreateGroupDialog> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _groupDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final selectedStudents = widget.students
        .where((s) => widget.selectedStudentIds.contains(s['id']))
        .toList();

    return AlertDialog(
      title: const Text('Create Group'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _groupNameController,
              decoration: const InputDecoration(
                labelText: 'Group Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _groupDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            const Text(
              'Selected Students:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                itemCount: selectedStudents.length,
                itemBuilder: (context, index) {
                  final student = selectedStudents[index];
                  return ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      radius: 16,
                      child: Text(student['name'][0]),
                    ),
                    title: Text(student['name']),
                    subtitle: Text('Class: ${student['class']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (_groupNameController.text.isNotEmpty) {
              // Create group logic here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Group "${_groupNameController.text}" created successfully!',
                  ),
                ),
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Create Group'),
        ),
      ],
    );
  }
}
