import 'package:flutter/material.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isDarkMode;
  final ValueChanged<bool> onThemeToggle;

  const MyAppBar({
    super.key,
    required this.title,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold)),
      actions: [
        Switch(
          value: isDarkMode,
          onChanged: onThemeToggle,
          thumbIcon: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Icon(Icons.dark_mode, color: Colors.indigo, size: 16);
            }
            return Icon(Icons.light_mode, color: Colors.orange, size: 16);
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.indigo.shade200;
            }
            return Colors.orange.shade200;
          }),
        ),
      ],
    );
  }

  // AppBar has a fixed height — this tells Scaffold how tall it is
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}