// import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/presentation/screens/add_habit.dart';
import 'package:habit_tracker/presentation/screens/habits.dart';
import 'package:habit_tracker/presentation/screens/home.dart';
import 'package:habit_tracker/presentation/screens/setting.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
     GoRoute(
      name: 'habits',
      path: '/habits',
      builder: (context, state) =>  HabitListScreen(),
    ),
    GoRoute(
      name: 'addHabit',
      path: '/addHabit',
      builder: (context, state) => AddHabitScreen(),
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => SettingPage(),
    ),
  ],
);
