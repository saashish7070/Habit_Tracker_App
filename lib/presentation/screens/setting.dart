import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/theme_provider.dart';
import 'package:habit_tracker/presentation/widgets/app_bar_back.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(title: 'Settings'),
      body: Center(
        child: Column(
          children: [
            SwitchListTile(
              title: Text("Dark Mode"),
              value: context.watch<ThemeProvider>().isDark,
              onChanged: (value) {
                context.read<ThemeProvider>().themeToggle();
              },
            )

          ],
        ),
      ),
    );
  }
}