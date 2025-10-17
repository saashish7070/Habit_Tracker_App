import 'dart:convert';

import 'package:habit_tracker/data/models/app_setting.dart';
import 'package:habit_tracker/data/models/daily_progress_model.dart';
import 'package:habit_tracker/data/models/habit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String habitsKey = "habits";
  static const String settingsKey = "settings";
  static const String progressKey = "progress";

  final SharedPreferences prefs;

  StorageService(this.prefs);

  //Storage created for the Habits
  Future<void> saveHabits(List<Habit> habits) async{
    final jsonList = habits.map((h)=>h.toJson()).toList();
    await prefs.setString(habitsKey, jsonEncode(jsonList));
  }

  List<Habit> loadHabits(){
    final jsonString = prefs.getString(habitsKey);
    if (jsonString == null) return [];
    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.map((e)=> Habit.fromJson(e)).toList();
  }
  
  //Storage created for the Settings
  Future<void> saveSettings(List<AppSettings> appSettings) async{
    await prefs.setString(settingsKey, jsonEncode(appSettings));
  }
  
  AppSettings loadSettings(){
    final jsonString = prefs.getString(settingsKey);
    if (jsonString == null) return AppSettings();
    return AppSettings.fromJson(jsonDecode(jsonString));
  }

  //Storage created for the Progress
  Future<void> saveProgress(List<DailyProgressModel> dailyProgress) async{
    final jsonList = dailyProgress.map((p)=>p.toJson()).toList();
    await prefs.setString(progressKey, jsonEncode(jsonList));
  }

  List<DailyProgressModel> loadDailyProgress() {
    final jsonString = prefs.getString(progressKey);
    if (jsonString == null) return [];
    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.map((e) => DailyProgressModel.fromJson(e)).toList();
  }
}