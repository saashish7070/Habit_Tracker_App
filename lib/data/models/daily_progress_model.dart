class DailyProgressModel {
  final DateTime date;
  final List<String> completedHabitIds;

  DailyProgressModel({
    required this.date,
    required this.completedHabitIds,
  });

  Map<String,dynamic> toJson() => {
    'date':date,
    'completeHabitIds':completedHabitIds,
  };

  factory DailyProgressModel.fromJson(Map<String,dynamic> json) => DailyProgressModel(
    date: json['date'], 
    completedHabitIds: json['completedHabitIds']
    );
}