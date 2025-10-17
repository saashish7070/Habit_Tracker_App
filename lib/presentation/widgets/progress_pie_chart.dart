import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:habit_tracker/data/models/habit.dart';

class ProgressPieChart extends StatelessWidget {
  final List<Habit> habits;

  const ProgressPieChart({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    final total = habits.length;
    final completed = habits.where((h) => h.isCompleted).length;
    final percentage = total == 0 ? 0.0 : (completed / total) * 100;

    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: completed.toDouble(),
                  color: Colors.green,
                  title: "$completed",
                  radius: 50,
                  titleStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                PieChartSectionData(
                  value: (total - completed).toDouble(),
                  color: Colors.grey.shade300,
                  title: "${total - completed}",
                  radius: 50,
                  titleStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
              centerSpaceRadius: 40,
            ),
          ),
        ),
        const SizedBox(height: 10),
        percentage > 0 ? Text(
          "Completed: $completed / $total (${percentage.toStringAsFixed(1)}%)",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ) : Text(''),
      ],
    );
  }
}
