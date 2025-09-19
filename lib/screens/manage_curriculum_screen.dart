import 'package:flutter/material.dart';
import '../widgets/app_background.dart';

class ManageCurriculumScreen extends StatefulWidget {
  static const String routeName = '/manage-curriculum';

  const ManageCurriculumScreen({super.key});

  @override
  State<ManageCurriculumScreen> createState() => _ManageCurriculumScreenState();
}

class _ManageCurriculumScreenState extends State<ManageCurriculumScreen> {
  String _selectedClass = '11th';
  String _selectedSubject = 'All';
  String _selectedChapter = 'All';

  // Mock curriculum data - Environment Studies Only
  final Map<String, Map<String, List<String>>> _curriculumData = {
    '11th': {
      'Environment Studies': [
        'Environment',
        'Population and Environment',
        'Impact of Human Activities on Environment',
        'Economic and Social Development',
        'Impact of Liberalisation and Globalization',
        'Role of Society in Development and Environment',
        'Environmental Pollution',
        'Pollution and Diseases',
        'Global Issues and Improvement of Environment',
        'Disasters',
        'Energy Consumption',
        'Conventional Sources of Energy',
        'Non-Conventional Sources of Energy',
        'Conservation of Energy',
        'Safe Work Environment',
        'Safety Laws, Accidents and First Aid',
        'Drugs – Ill Effects',
      ],
    },
    '12th': {
      'Environment Studies': [
        'Environment',
        'Population and Environment',
        'Impact of Human Activities on Environment',
        'Economic and Social Development',
        'Impact of Liberalisation and Globalization',
        'Role of Society in Development and Environment',
        'Environmental Pollution',
        'Pollution and Diseases',
        'Global Issues and Improvement of Environment',
        'Disasters',
        'Energy Consumption',
        'Conventional Sources of Energy',
        'Non-Conventional Sources of Energy',
        'Conservation of Energy',
        'Safe Work Environment',
        'Safety Laws, Accidents and First Aid',
        'Drugs – Ill Effects',
      ],
    },
  };

  List<String> get _subjects {
    if (_selectedClass == 'All') return ['All'];
    return ['All', ..._curriculumData[_selectedClass]!.keys];
  }

  List<String> get _chapters {
    if (_selectedClass == 'All' || _selectedSubject == 'All') return ['All'];
    return ['All', ..._curriculumData[_selectedClass]![_selectedSubject]!];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Environment Studies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddContentDialog,
            tooltip: 'Add New Content',
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
                // Filter Controls
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                initialValue: _selectedClass,
                                decoration: const InputDecoration(
                                  labelText: 'Class',
                                  border: OutlineInputBorder(),
                                ),
                                items: ['11th', '12th'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedClass = newValue!;
                                    _selectedSubject = 'All';
                                    _selectedChapter = 'All';
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                initialValue: _selectedSubject,
                                decoration: const InputDecoration(
                                  labelText: 'Subject',
                                  border: OutlineInputBorder(),
                                ),
                                items: _subjects.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedSubject = newValue!;
                                    _selectedChapter = 'All';
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                initialValue: _selectedChapter,
                                decoration: const InputDecoration(
                                  labelText: 'Chapter',
                                  border: OutlineInputBorder(),
                                ),
                                items: _chapters.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedChapter = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Curriculum Content
                Expanded(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _buildCurriculumContent(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurriculumContent() {
    if (_selectedClass == 'All') {
      return _buildClassOverview();
    } else if (_selectedSubject == 'All') {
      return _buildSubjectOverview();
    } else if (_selectedChapter == 'All') {
      return _buildChapterOverview();
    } else {
      return _buildChapterDetails();
    }
  }

  Widget _buildClassOverview() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Environment Studies - Class Overview',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _curriculumData.keys.length,
              itemBuilder: (context, index) {
                final className = _curriculumData.keys.elementAt(index);
                final subjects = _curriculumData[className]!;
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.eco, color: Colors.green),
                    title: Text('Class $className - Environment Studies'),
                    subtitle: Text(
                      '${subjects['Environment Studies']!.length} chapters',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      setState(() {
                        _selectedClass = className;
                        _selectedSubject = 'Environment Studies';
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectOverview() {
    final subjects = _curriculumData[_selectedClass]!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Class $_selectedClass - Environment Studies',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects.keys.elementAt(index);
                final chapters = subjects[subject]!;
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.eco, color: Colors.green),
                    title: Text(subject),
                    subtitle: Text('${chapters.length} chapters'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      setState(() {
                        _selectedSubject = subject;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterOverview() {
    final chapters = _curriculumData[_selectedClass]![_selectedSubject]!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$_selectedClass - $_selectedSubject',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final chapter = chapters[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(chapter),
                    subtitle: const Text('Click to view details'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      setState(() {
                        _selectedChapter = chapter;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterDetails() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '$_selectedClass - $_selectedSubject - $_selectedChapter',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: _showEditChapterDialog,
                tooltip: 'Edit Chapter',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_selectedSubject == 'Environment Studies')
                    _buildEnvironmentStudiesContent()
                  else
                    _buildRegularSubjectContent(),
                  const SizedBox(height: 16),
                  _buildContentSection('Assignments', [
                    'Assignment 1: Basic Problems',
                    'Assignment 2: Advanced Problems',
                    'Assignment 3: Practical Applications',
                  ]),
                  const SizedBox(height: 16),
                  _buildContentSection('Resources', [
                    'Textbook Chapter',
                    'Video Lectures',
                    'Practice Questions',
                    'Previous Year Papers',
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnvironmentStudiesContent() {
    final Map<String, List<String>> environmentTopics = {
      'Environment': [
        'Physical environment',
        'Biological environment',
        'Social environment',
        'Indian traditions, customs, culture & environment',
      ],
      'Population and Environment': [
        'Demography',
        'Causes of population growth',
        'Effects of overpopulation',
        'Urbanization',
      ],
      'Impact of Human Activities on Environment': [
        'Environmental problems in villages & cities',
        'Natural resource depletion',
        'Shortage of water, electricity, waste disposal',
        'Transport & health issues',
        'Vehicular emissions',
        'Migration & housing problems',
      ],
      'Economic and Social Development': [
        'Economic & social needs',
        'Agriculture & industry',
        'Poverty & affluence',
        'Education & employment',
        'Child marriage & child labour',
        'Health issues (e.g. HIV/AIDS)',
        'Cultural & ethical values',
      ],
      'Impact of Liberalisation and Globalization': [
        'Impact on agriculture',
        'Impact on industries',
        'Displacement of workers',
        'Unemployment & social issues',
      ],
      'Role of Society in Development and Environment': [
        'Public awareness (education, eco clubs, campaigns)',
        'Public participation in decision making',
      ],
      'Environmental Pollution': [
        'Air pollution',
        'Water pollution (fresh & marine)',
        'Soil pollution',
        'Noise pollution',
        'Radiation pollution',
        'Solid waste pollution',
        'Liquid waste pollution',
        'Gaseous pollution',
      ],
      'Pollution and Diseases': [
        'Hazardous materials & waste',
        'Diseases due to pollution',
        'Strategies to reduce pollution',
      ],
      'Global Issues and Improvement of Environment': [
        'Ozone layer depletion',
        'Greenhouse effect',
        'Global warming',
        'Climate change & its effects',
      ],
      'Disasters': [
        'Natural Disasters',
        'Earthquakes',
        'Floods',
        'Droughts',
        'Cyclones',
        'Landslides',
        'Man-made (Human-induced) Disasters',
        'Industrial accidents',
        'Chemical leaks',
        'Explosions',
        'Nuclear accidents',
        'Fire accidents',
      ],
      'Energy Consumption': [
        'Ancient Energy Use',
        'Modern Energy Use',
        'Energy & Quality of Life',
        'Rising Energy Demand',
        'Demand–Supply Gap',
      ],
      'Conventional Sources of Energy': [
        'Fossil Fuels',
        'Firewood',
        'Hydropower',
        'Limitations',
      ],
      'Non-Conventional Sources of Energy': [
        'Solar Energy',
        'Wind Energy',
        'Biomass Energy',
        'Ocean Energy',
        'Geothermal Energy',
        'Nuclear Energy',
      ],
      'Conservation of Energy': [
        'Efficient Use of Energy',
        'Energy Saving Methods',
        'Future Fuels',
      ],
      'Safe Work Environment': [
        'Light & Ventilation',
        'Cleanliness',
        'Housekeeping',
      ],
      'Safety Laws, Accidents and First Aid': [
        'Safety Awareness',
        'Occupational Hazards',
        'Industrial Accidents',
        'First Aid',
        'Safety Laws',
      ],
      'Drugs – Ill Effects': [
        'Drug Addiction',
        'Drugs of Abuse',
        'Health Effects',
        'Educational & Social Effects',
        'Legal Issues',
        'Prevention',
      ],
    };

    final topics =
        environmentTopics[_selectedChapter] ??
        [
          'Introduction to $_selectedChapter',
          'Key Concepts',
          'Important Topics',
          'Real-world Applications',
        ];

    return _buildContentSection('Topics', topics);
  }

  Widget _buildRegularSubjectContent() {
    return _buildContentSection('Topics', [
      'Introduction to $_selectedChapter',
      'Key Concepts',
      'Important Formulas',
      'Problem Solving Techniques',
      'Real-world Applications',
    ]);
  }

  Widget _buildContentSection(String title, List<String> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.circle, size: 8, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(child: Text(item)),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 16),
                      onPressed: () => _showEditItemDialog(title, item),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => _showAddItemDialog(title),
              icon: const Icon(Icons.add, size: 16),
              label: Text('Add $title'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddContentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Content'),
        content: const Text(
          'This feature will allow you to add new curriculum content.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Add content feature coming soon!'),
                ),
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditChapterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Chapter'),
        content: const Text(
          'This feature will allow you to edit chapter details.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Edit chapter feature coming soon!'),
                ),
              );
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  void _showEditItemDialog(String section, String item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $section Item'),
        content: Text('Edit: $item'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit item feature coming soon!')),
              );
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  void _showAddItemDialog(String section) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add $section Item'),
        content: const Text('This feature will allow you to add new items.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add item feature coming soon!')),
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
