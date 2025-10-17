part of 'habit_tracker_bloc.dart';

@immutable
sealed class HabitTrackerEvent {}

final class LoadHabits extends HabitTrackerEvent{}

final class AddHabit extends HabitTrackerEvent{
  final Habit habit;
  AddHabit({required this.habit});
}

final class RemoveHabit extends HabitTrackerEvent{
  final int index;
  RemoveHabit({required this.index});
}

final class ToggleHabitComplete extends HabitTrackerEvent{
  final int index;
  ToggleHabitComplete({required this.index});
}