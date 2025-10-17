import 'package:flutter/material.dart';

class EmptyHabitView extends StatelessWidget {
  const EmptyHabitView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No habits added yet!",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
