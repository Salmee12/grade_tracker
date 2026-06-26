import 'package:flutter/material.dart';

import '../model/Subject.dart';


class SubjectProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];

  List<Subject> get subjects => List.unmodifiable(_subjects);

  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  void removeSubject(int index) {
    if (index >= 0 && index < _subjects.length) {
      _subjects.removeAt(index);
      notifyListeners();
    }
  }

  List<Subject> get passingSubjects =>
      _subjects.where((s) => s.mark >= 50).toList();

  int get totalSubjects => _subjects.length;

  int get passingCount => passingSubjects.length;

  double get averageMark =>
      _subjects.isEmpty
          ? 0
          : _subjects.map((s) => s.mark).reduce((a, b) => a + b) / _subjects.length;
}