import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/subject_provider.dart';


class SubjectlistPage extends StatelessWidget {
  const SubjectlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SubjectProvider>(
      builder: (context, provider, child) {
        if (provider.subjects.isEmpty) {
          return const Center(child: Text('No subjects yet. Add some!'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.subjects.length,
          itemBuilder: (context, index) {
            final subject = provider.subjects[index];
            return Card(
              child: ListTile(
                title: Text(subject.name),
                subtitle: Text('Mark: ${subject.mark} | Grade: ${subject.grade}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(subject.grade, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => provider.removeSubject(index),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}