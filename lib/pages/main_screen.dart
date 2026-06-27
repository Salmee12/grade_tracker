import 'package:flutter/material.dart';
import 'package:grade_tracker/pages/subject_page.dart';
import 'package:grade_tracker/pages/subjectlist_page.dart';
import 'package:grade_tracker/pages/summary_page.dart';
import 'package:provider/provider.dart';

import '../provider/appstate_provider.dart';
import '../widgets/appbar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);

    final List<String> titles = ['Add Subject', 'Subject List', 'Summary'];

    return Scaffold(
      appBar: MyAppBar(
        title: titles[appState.currentIndex],
        isDarkMode: appState.isDarkMode,
        onThemeToggle: (val) {
          Provider.of<AppStateProvider>(context, listen: false).setTheme(val);
        },
      ),
      body: IndexedStack(
        index: appState.currentIndex,
        children: const [
          SubjectPage(),
          SubjectlistPage(),
          SummaryPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: appState.currentIndex,
        onTap: (index) {
          Provider.of<AppStateProvider>(context, listen: false).changePage(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.summarize), label: 'Summary'),
        ],
      ),
    );
  }
}