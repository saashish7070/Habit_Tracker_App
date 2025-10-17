import 'package:flutter/widgets.dart';
import 'package:habit_tracker/data/local/storage_service.dart';
import 'package:habit_tracker/data/models/habit.dart';

class HabitProvider extends ChangeNotifier {
  final StorageService storage;
  List<Habit> _habits = [];

  HabitProvider(this.storage) {
    _loadHabits();
  }

  List<Habit> get habits => _habits;

  Future<void> _loadHabits() async {
    _habits = storage.loadHabits();
    notifyListeners();
  }

  Future<void> saveHabit(Habit habit) async {
    _habits.add(habit);
    await storage.saveHabits(_habits);
    notifyListeners();
  }

  Future<void> removeHabit(int index) async {
    _habits.removeAt(index);
    await storage.saveHabits(_habits);
    notifyListeners();
  }

  Future<void> markHabitComplete(int index) async {
    final habit = _habits[index];
    habit.isCompleted = true;
    _habits[index] = habit;
    await storage.saveHabits(_habits);
    notifyListeners();
  }

  Future<void> toggleHabitComplete(int index) async {
    final habit = _habits[index];
    habit.isCompleted = !habit.isCompleted;
    _habits[index] = habit;
    await storage.saveHabits(_habits);
    notifyListeners();
  }
}
