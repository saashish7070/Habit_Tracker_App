import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/utils/bloc/habit_tracker_bloc.dart';
import 'package:habit_tracker/presentation/widgets/app_bar.dart';
import 'package:habit_tracker/presentation/widgets/empty_habit_view.dart';
import 'package:habit_tracker/presentation/widgets/habit_list.dart';
import 'package:habit_tracker/presentation/widgets/progress_pie_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Let's build a habit"),
      body: BlocBuilder<HabitTrackerBloc, HabitTrackerState>(
        builder: (context, state) {
          if (state is HabitTrackerInitial || state is HabitTrackerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HabitTrackerLoaded) {
            final habits = state.habits;

            return SingleChildScrollView(
              child: Column(
                children: [
                  ProgressPieChart(habits: habits),
                  const SizedBox(height: 20),
                  habits.isEmpty
                      ? const EmptyHabitView()
                      : HabitListView(habits: habits),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
