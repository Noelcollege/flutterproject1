import 'package:flutter/material.dart';
import '../widgets/app_background.dart';

class ChaptersScreen extends StatefulWidget {
  static const String routeName = '/chapters';

  const ChaptersScreen({super.key});

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  int? _selectedChapter;

  final List<Map<String, dynamic>> _chapters = [
    {
      'title': 'Environment',
      'subtopics': [
        'Physical environment',
        'Biological environment',
        'Social environment',
        'Indian traditions, customs, culture & environment',
      ],
    },
    {
      'title': 'Population and Environment',
      'subtopics': [
        'Demography',
        'Causes of population growth',
        'Effects of overpopulation',
        'Urbanization',
      ],
    },
    {
      'title': 'Impact of Human Activities on Environment',
      'subtopics': [
        'Environmental problems in villages & cities',
        'Natural resource depletion',
        'Shortage of water, electricity, waste disposal',
        'Transport & health issues',
        'Vehicular emissions',
        'Migration & housing problems',
      ],
    },
    {
      'title': 'Economic and Social Development',
      'subtopics': [
        'Economic & social needs',
        'Agriculture & industry',
        'Poverty & affluence',
        'Education & employment',
        'Child marriage & child labour',
        'Health issues (e.g. HIV/AIDS)',
        'Cultural & ethical values',
      ],
    },
    {
      'title': 'Impact of Liberalisation and Globalization',
      'subtopics': [
        'Impact on agriculture',
        'Impact on industries',
        'Displacement of workers',
        'Unemployment & social issues',
      ],
    },
    {
      'title': 'Role of Society in Development and Environment',
      'subtopics': [
        'Public awareness (education, eco clubs, campaigns)',
        'Public participation in decision making',
      ],
    },
    {
      'title': 'Environmental Pollution',
      'subtopics': [
        'Air pollution',
        'Water pollution (fresh & marine)',
        'Soil pollution',
        'Noise pollution',
        'Radiation pollution',
        'Solid waste pollution',
        'Liquid waste pollution',
        'Gaseous pollution',
      ],
    },
    {
      'title': 'Pollution and Diseases',
      'subtopics': [
        'Hazardous materials & waste',
        'Diseases due to pollution',
        'Strategies to reduce pollution',
      ],
    },
    {
      'title': 'Global Issues and Improvement of Environment',
      'subtopics': [
        'Ozone layer depletion',
        'Greenhouse effect',
        'Global warming',
        'Climate change & its effects',
      ],
    },
    {
      'title': 'Disasters',
      'subtopics': [
        'Natural Disasters: Earthquakes, Floods, Droughts, Cyclones, Landslides',
        'Man-made (Human-induced) Disasters: Industrial accidents, Chemical leaks, Explosions, Nuclear accidents, Fire accidents',
      ],
    },
    {
      'title': 'Energy Consumption',
      'subtopics': [
        'Ancient Energy Use',
        'Modern Energy Use',
        'Energy & Quality of Life',
        'Rising Energy Demand',
        'Demand–Supply Gap',
      ],
    },
    {
      'title': 'Conventional Sources of Energy',
      'subtopics': ['Fossil Fuels', 'Firewood', 'Hydropower', 'Limitations'],
    },
    {
      'title': 'Non-Conventional Sources of Energy',
      'subtopics': [
        'Solar Energy',
        'Wind Energy',
        'Biomass Energy',
        'Ocean Energy',
        'Geothermal Energy',
        'Nuclear Energy',
      ],
    },
    {
      'title': 'Conservation of Energy',
      'subtopics': [
        'Efficient Use of Energy',
        'Energy Saving Methods',
        'Future Fuels',
      ],
    },
    {
      'title': 'Safe Work Environment',
      'subtopics': ['Light & Ventilation', 'Cleanliness', 'Housekeeping'],
    },
    {
      'title': 'Safety Laws, Accidents and First Aid',
      'subtopics': [
        'Safety Awareness',
        'Occupational Hazards',
        'Industrial Accidents',
        'First Aid',
        'Safety Laws',
      ],
    },
    {
      'title': 'Drugs – Ill Effects',
      'subtopics': [
        'Drug Addiction',
        'Drugs of Abuse',
        'Health Effects',
        'Educational & Social Effects',
        'Legal Issues',
        'Prevention',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Environment Studies')),
      body: AppBackground(
        imageAsset: 'assets/logo/app_icon.jpg',
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.eco, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Environment Studies - Chapters',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _chapters.length,
                      itemBuilder: (context, index) {
                        final chapter = _chapters[index];
                        final isSelected = _selectedChapter == index;

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: isSelected ? 8 : 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: isSelected
                                  ? Colors.green
                                  : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: ExpansionTile(
                            leading: CircleAvatar(
                              backgroundColor: isSelected
                                  ? Colors.green
                                  : Colors.blue,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              chapter['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.green.shade700
                                    : null,
                              ),
                            ),
                            subtitle: Text(
                              '${(chapter['subtopics'] as List).length} topics',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                            trailing: Icon(
                              isSelected
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: isSelected ? Colors.green : Colors.grey,
                            ),
                            onExpansionChanged: (expanded) {
                              setState(() {
                                _selectedChapter = expanded ? index : null;
                              });
                            },
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  16,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Topics Covered:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ...(chapter['subtopics'] as List<String>)
                                        .map(
                                          (topic) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 2,
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.circle,
                                                  size: 6,
                                                  color: Colors.grey.shade600,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    topic,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          Colors.grey.shade700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/chapter-content',
                                            arguments: {
                                              'chapterTitle': chapter['title'],
                                              'chapterNumber': '${index + 1}',
                                              'topics': chapter['subtopics'],
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.play_arrow),
                                        label: const Text('Start Chapter'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
}
