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

            return Dismissible(
              key: Key(subject.name + index.toString()), // Unique key
              direction: DismissDirection.endToStart,   // Swipe from right to left
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Subject?'),
                    content: Text('Are you sure you want to delete "${subject.name}"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Delete', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
              onDismissed: (direction) {
                provider.removeSubject(index);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${subject.name} deleted'),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(subject.name),
                  subtitle: Text('Mark: ${subject.mark} | Grade: ${subject.grade}'),
                  trailing: Text(
                    subject.grade,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}