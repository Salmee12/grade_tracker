import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/Subject.dart';
import '../provider/subject_provider.dart';


class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _markController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _markController.dispose();
    super.dispose();
  }
// Check if subject already exists
  bool _subjectExists(String name) {
    final provider = Provider.of<SubjectProvider>(context, listen: false);
    return provider.subjects.any(
          (subject) => subject.name.toLowerCase() == name.toLowerCase().trim(),
    );
  }
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final mark = double.parse(_markController.text.trim());

      final subject = Subject(name: name, mark: mark);
      // Add using Provider
      Provider.of<SubjectProvider>(context, listen: false).addSubject(subject);


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Added: $name')),
      );

      _nameController.clear();
      _markController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.indigo, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Subject Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.trim().isEmpty == true) return 'Required';
                  if (_subjectExists(value!)) {
                    return 'Subject with this name already exists';
                  }

                  return null;

                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _markController,
                decoration: const InputDecoration(
                  labelText: 'Mark',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.trim().isEmpty == true) return 'Required';
                  final mark = double.tryParse(value!);
                  if (mark == null) return 'Invalid number';
                  if (mark < 0 || mark > 100) return '0-100 only';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Subject'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}