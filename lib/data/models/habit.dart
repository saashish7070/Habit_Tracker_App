class Habit {
  final String id;
  String title;
  String description;
  String regularity;
  String reminderTime;
  bool isCompleted;
  DateTime createdAt;

  Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.regularity,
    required this.reminderTime,
    this.isCompleted = false,
    required this.createdAt,
  });

  Map<String,dynamic> toJson()=>{
    'id':id,
    'title':title,
    'description':description,
    'regularity':regularity,
    'reminderTime':reminderTime,
    'isCompleted':isCompleted,
    'createdAt':createdAt.toIso8601String(),
  };


  factory Habit.fromJson(Map<String,dynamic> json) => Habit(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    regularity: json['regularity'],
    reminderTime: json['reminderTime'],
    isCompleted: json['isCompleted']?? false,
    createdAt: DateTime.parse(json['createdAt']),
  );
}