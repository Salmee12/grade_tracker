import 'package:flutter/material.dart';
import 'package:grade_tracker/pages/subject_page.dart';
import 'package:grade_tracker/pages/subjectlist_page.dart';
import 'package:grade_tracker/pages/summary_page.dart';
import 'package:grade_tracker/provider/subject_provider.dart';
import 'package:grade_tracker/widgets/appbar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SubjectProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();


}

class _MyAppState extends State<MyApp> {

  int _selectedIndex = 0;
  bool _isDarkMode = false;

  final List<String> _titles = ['Add a new subject', 'Subject wise result', 'Result Summary'];

  final List<Widget> _pages = [
    SubjectPage(),
    SubjectlistPage(),
    SummaryPage()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
        textTheme: const TextTheme(
          titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.lightGreenAccent,
          foregroundColor: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.greenAccent
          ),
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode:  _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: MyAppBar(
          title: _titles[_selectedIndex],
          isDarkMode: _isDarkMode,
          onThemeToggle: (val) => setState(() => _isDarkMode = val),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Subject',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Subject List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.summarize),
              label: 'Summary',
            ),
          ],
        ),
      ),
    );
  }
}




