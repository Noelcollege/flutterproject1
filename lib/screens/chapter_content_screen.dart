import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class ChapterContentScreen extends StatefulWidget {
  final String chapterTitle;
  final String chapterNumber;
  final List<String> topics;

  const ChapterContentScreen({
    super.key,
    required this.chapterTitle,
    required this.chapterNumber,
    required this.topics,
  });

  static const String routeName = '/chapter-content';

  @override
  State<ChapterContentScreen> createState() => _ChapterContentScreenState();
}

class _ChapterContentScreenState extends State<ChapterContentScreen> {
  int _currentTopicIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chapter ${widget.chapterNumber} - ${widget.chapterTitle}'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Chapter Progress
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.eco, color: Colors.green, size: 28),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Chapter ${widget.chapterNumber}: ${widget.chapterTitle}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        LinearProgressIndicator(
                          value:
                              (_currentTopicIndex + 1) / widget.topics.length,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.green,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Progress: ${_currentTopicIndex + 1} of ${widget.topics.length} topics',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Topic Navigation
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Current Topic',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green.shade200),
                          ),
                          child: Text(
                            widget.topics[_currentTopicIndex],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _currentTopicIndex > 0
                                    ? () {
                                        setState(() {
                                          _currentTopicIndex--;
                                        });
                                      }
                                    : null,
                                icon: const Icon(Icons.arrow_back),
                                label: const Text('Previous'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FilledButton.icon(
                                onPressed:
                                    _currentTopicIndex <
                                        widget.topics.length - 1
                                    ? () {
                                        setState(() {
                                          _currentTopicIndex++;
                                        });
                                      }
                                    : null,
                                icon: const Icon(Icons.arrow_forward),
                                label: const Text('Next'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Content Section
                Expanded(
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Learning Content',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Video Section
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.play_circle_outline,
                                  size: 64,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Video Content',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Video will be available soon',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Quiz Section
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.blue.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.quiz,
                                      color: Colors.blue,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Quiz Assessment',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Test your understanding of ${widget.topics[_currentTopicIndex]}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Quiz feature coming soon!',
                                          ),
                                          backgroundColor: Colors.blue,
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.quiz),
                                    label: const Text('Start Quiz'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.blue,
                                      side: BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
