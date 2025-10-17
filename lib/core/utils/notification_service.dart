import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/habit_provider.dart';
import 'package:habit_tracker/core/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class NotificationProvider extends ChangeNotifier {
  final LocalNotificationService localNotificationService = LocalNotificationService();
  bool _notifyOn = true;

  bool get notifyOn => _notifyOn;

  NotificationProvider() {
    _loadFromPrefs();
  }

  Future<void> toggleNotif(BuildContext context) async {
    _notifyOn = !_notifyOn;

    if (!_notifyOn) {
      await localNotificationService.cancelAllNotifications();
    } else {
      final habitProvider = Provider.of<HabitProvider>(context, listen: false);
      final habits = habitProvider.habits;

      for (var habit in habits) {
        final parts = habit.reminderTime.split(":");
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);

        DateTime scheduledDateTime = DateTime.now().copyWith(
          hour: hour,
          minute: minute,
          second: 0,
          millisecond: 0,
        );

        if (scheduledDateTime.isBefore(DateTime.now())) {
          scheduledDateTime = scheduledDateTime.add(const Duration(days: 1));
        }

        await localNotificationService.scheduleNotification(
          title: habit.title,
          body: habit.description,
          scheduledDateTime: scheduledDateTime,
        );
      }

    }

    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _notifyOn = prefs.getBool("notifyOn") ?? true;
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("notifyOn", _notifyOn);
  }
}


