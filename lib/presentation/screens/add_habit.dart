import 'package:flutter/material.dart';
import 'package:habit_tracker/presentation/widgets/app_bar.dart';
import 'package:habit_tracker/presentation/widgets/habit_form.dart';

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Habits"),
      body: CustomHabitForm()
    );
  }
}

