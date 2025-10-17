import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/bloc/habit_tracker_bloc.dart';
import 'package:habit_tracker/data/models/habit.dart';
import 'package:provider/provider.dart';
// import 'package:habit_tracker/core/utils/habit_provider.dart';

class HabitListView extends StatelessWidget {
  final List<Habit> habits;
  const HabitListView({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    // final habitProvider = context.watch<HabitProvider>();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final habit = habits[index];

        return Dismissible(
          key: ValueKey(habit.id),
          background: Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              habit.isCompleted ? Icons.close : Icons.check,
              color: Colors.white,
            ),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            final bloc = context.read<HabitTrackerBloc>();
            if (direction == DismissDirection.startToEnd) {
              bloc.add(ToggleHabitComplete(index: index));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    habit.isCompleted
                        ? "${habit.title} unmarked"
                        : "${habit.title} marked as complete ",
                  ),
                ),
              );
              return false;
            } else if (direction == DismissDirection.endToStart) {
              bool? confirmDelete = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Confirm Delete"),
                  content: Text("Are you sure you want to delete '${habit.title}'?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      child: const Text("Delete"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              );
              return confirmDelete == true;
            }
            return false;
          },
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              context.read<HabitTrackerBloc>().add(RemoveHabit(index: index));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${habit.title} deleted")),
              );
            }
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: habit.isCompleted
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.radio_button_unchecked),
              title: Text(
                habit.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('${habit.reminderTime}.${habit.regularity}'),
            ),
          ),
        );
      },
    );
  }
}
