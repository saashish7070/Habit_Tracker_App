import 'package:flutter/material.dart';
import 'package:habit_tracker/presentation/screens/add_habit.dart';
import 'package:habit_tracker/presentation/screens/dashboard.dart';
import 'package:habit_tracker/presentation/screens/habits.dart';
import 'package:habit_tracker/presentation/widgets/bottom_navigation.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  List<Widget> _buildScreens(){
    return [
      DashboardScreen(),
      AddHabitScreen(),
      HabitListScreen(),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(context,controller: BottomNavBar.controller, screens: _buildScreens(),
    items: BottomNavBar.items(),navBarStyle: NavBarStyle.style6);
    }
}

