import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/subject_provider.dart';


class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Consumer<SubjectProvider>(
        builder: (context, provider, child) {
          final total = provider.totalSubjects;
          final passing = provider.passingCount;
          final average = provider.averageMark;
      
          final failing = total - passing;
      
          if (total == 0) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No data yet',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text('Add some subjects first'),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Summary',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // Statistics Cards
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: 'Total Subjects',
                        value: total.toString(),
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        title: 'Passing',
                        value: '$passing (${(passing / total * 100).toStringAsFixed(1)}%)',
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        title: 'Failing',
                        value: failing.toString(),
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                const Text('Average Mark', style: TextStyle(fontSize: 18)),
                Text(
                  '${average.toStringAsFixed(1)} / 100',
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 24),
                const Text('Grade Distribution', style: TextStyle(fontSize: 18)),

                // Grade Distribution
                ...provider.subjects
                    .map((s) => s.grade)
                    .toSet()
                    .map((grade) {
                  final count = provider.subjects.where((s) => s.grade == grade).length;
                  return ListTile(
                    leading: Text(grade, style: const TextStyle(fontSize: 24)),
                    title: LinearProgressIndicator(
                      value: count / total,
                      backgroundColor: Colors.grey[300],
                      color: _getGradeColor(grade),
                    ),
                    trailing: Text('$count'),
                  );
                }).toList(),

                const SizedBox(height: 24),

                // All Subjects
                const Text('All Subjects', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 8),

                // Replaced inner ListView with Column + map for better scroll behavior
                ...provider.subjects.map((subject) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(subject.name),
                      subtitle: Text('${subject.mark} marks'),
                      trailing: Text(
                        subject.grade,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _getGradeColor(subject.grade),
                        ),
                      ),
                    ),
                  );
                }).toList(),

                const SizedBox(height: 40), // Extra space at bottom
              ],
            ),
          );
        },
    );
      
      


  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.lightGreen;
      case 'C':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }
}

// Small helper widget
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}