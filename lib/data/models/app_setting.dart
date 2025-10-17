class AppSettings{
  bool isDarkTheme;
  bool isNotificationEnabled;
  String language;

  AppSettings({
    this.isDarkTheme = false,
    this.isNotificationEnabled = true,
    this.language = 'en',
  });

  Map<String,dynamic> toJson()=>{
    'isDarkTheme': isDarkTheme,
    'isNotificationEnabled':isNotificationEnabled,
    'language':language,
  };

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
    isDarkTheme: json['isDarkTheme'],
    isNotificationEnabled: json['isNotificationEnabled'],
    language: json['language'],
  );
}