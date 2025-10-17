import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    log("Notification Initialized");

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kathmandu'));
  }

  Future<void> showNotificationAddition(String title, String body) async {
    HapticFeedback.heavyImpact();
    await flutterLocalNotificationsPlugin.show(
      1,
      "New Task Added For Today",
      "$title : $body",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "1",
          "Notif",
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDateTime,
  }) async {
    HapticFeedback.heavyImpact();
    final tz.TZDateTime scheduledTZDateTime =
        tz.TZDateTime.from(scheduledDateTime, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      scheduledDateTime.millisecondsSinceEpoch ~/ 1000,
      "Remainder For $title",
      "You had set remainder for $body",
      scheduledTZDateTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "1",
          "Habit Notification",
          channelDescription: "Notification for Scheduled Habit Task",
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: null,
    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
