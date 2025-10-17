import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/utils/bloc/habit_tracker_bloc.dart';
import 'package:habit_tracker/presentation/widgets/habit_list.dart';
import 'package:habit_tracker/presentation/widgets/empty_habit_view.dart';

class HabitListScreen extends StatelessWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Habits")),
      body: BlocBuilder<HabitTrackerBloc, HabitTrackerState>(
        builder: (context, state) {
         if (state is HabitTrackerLoaded) {
            if (state.habits.isEmpty) {
              return const EmptyHabitView();
            }
            return HabitListView(habits: state.habits);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
