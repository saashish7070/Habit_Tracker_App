import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/bloc_observer.dart';
import 'package:habit_tracker/core/utils/bloc/habit_tracker_bloc.dart';
// import 'package:habit_tracker/core/utils/habit_provider.dart';
import 'package:habit_tracker/core/utils/notification_helper.dart';
import 'package:habit_tracker/core/utils/notification_service.dart';
import 'package:habit_tracker/core/utils/theme_provider.dart';
import 'package:habit_tracker/data/local/storage_service.dart';
import 'package:habit_tracker/my_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final storageService = StorageService(prefs);

  final notificationService = LocalNotificationService();
  await notificationService.initializeNotification();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  Bloc.observer = SimpleBlocObserver();
  
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => HabitProvider(storageService)),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => themeProvider), 
      ],
      child: BlocProvider(
        create: (_) => HabitTrackerBloc(storageService)..add(LoadHabits()),
        child: const HabitTrackerApp()),
    ),
  );
}
