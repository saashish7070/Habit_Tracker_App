import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/theme_provider.dart';
import 'core/routes/router.dart';
import 'package:provider/provider.dart';

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>(); 
  
    return MaterialApp.router(
      title: 'Habit Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light, 
      routerConfig: router,
    );
  }
}
