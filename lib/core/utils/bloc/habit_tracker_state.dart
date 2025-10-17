part of 'habit_tracker_bloc.dart';

@immutable
sealed class HabitTrackerState {}

final class HabitTrackerInitial extends HabitTrackerState {}

final class HabitTrackerLoading extends HabitTrackerState {}

final class HabitTrackerLoaded extends HabitTrackerState {
  final List<Habit> habits;
  HabitTrackerLoaded(this.habits);
}