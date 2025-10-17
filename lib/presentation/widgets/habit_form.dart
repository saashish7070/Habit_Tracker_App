import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/utils/bloc/habit_tracker_bloc.dart';
import 'package:habit_tracker/core/utils/notification_service.dart';
import 'package:habit_tracker/data/models/habit.dart';

class CustomHabitForm extends StatefulWidget {
  const CustomHabitForm({super.key});

  @override
  State<CustomHabitForm> createState() => _CustomHabitFormState();
}

class _CustomHabitFormState extends State<CustomHabitForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _regularityController = TextEditingController();
  final _reminderTimeController = TextEditingController();

  final List<String> _regularityItems = ["Once", "Daily", "Weekly", "Monthly", "Yearly"];
  int _selectedRegular = 0;

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final bloc = context.read<HabitTrackerBloc>();
    final notifProvider = context.read<NotificationProvider>();

    Habit habit = Habit(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      description: _descriptionController.text,
      regularity: _regularityController.text,
      reminderTime: _reminderTimeController.text,
      createdAt: DateTime.now(),
    );

    bloc.add(AddHabit(habit:habit));

    if (notifProvider.notifyOn && habit.reminderTime.isNotEmpty) {
      final parts = habit.reminderTime.split(":");
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);

      DateTime scheduledTime = DateTime.now().copyWith(hour: hour, minute: minute, second: 0);
      if (scheduledTime.isBefore(DateTime.now())) {
        scheduledTime = scheduledTime.add(const Duration(days: 1));
      }

      notifProvider.localNotificationService.scheduleNotification(
        title: habit.title,
        body: habit.description,
        scheduledDateTime: scheduledTime,
      );
    }

    // Clear form
    _titleController.clear();
    _descriptionController.clear();
    _regularityController.clear();
    _reminderTimeController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Habit Added Successfully!")),
    );
  }

  InputDecoration _buildInputDecoration({
    required String label,
    IconData? icon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fillColor = isDark ? Colors.grey[850] : Colors.grey[200];

    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      prefixIcon: icon != null ? Icon(icon, color: isDark ? Colors.white70 : Colors.black87) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifProvider = context.watch<NotificationProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundColor: Colors.black12,
              child: Icon(Icons.task_alt, size: 35, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            Text(
              "Fill the details to track your habit",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 28),

            // Title
            TextFormField(
              controller: _titleController,
              decoration: _buildInputDecoration(label: "Title", icon: Icons.title),
              validator: (value) => value!.isEmpty ? "Enter a title" : null,
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              controller: _descriptionController,
              maxLines: 2,
              decoration: _buildInputDecoration(label: "Description", icon: Icons.description),
            ),
            const SizedBox(height: 16),

            // Regularity
            DropdownButtonFormField<String>(
              initialValue: _regularityItems[_selectedRegular],
              items: _regularityItems
                  .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _regularityController.text = value!;
                  _selectedRegular = _regularityItems.indexOf(value);
                });
              },
              decoration: _buildInputDecoration(label: "Regularity", icon: Icons.calendar_today),
            ),
            const SizedBox(height: 16),

            // Reminder Time
            TextFormField(
              controller: _reminderTimeController,
              readOnly: true,
              decoration: _buildInputDecoration(label: "Reminder Time", icon: Icons.access_time),
              onTap: () {
                DateTime selectedTime = DateTime.now();

                showModalBottomSheet(
                  context: context,
                  backgroundColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[900]
                      : Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) => SizedBox(
                    height: 250,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(brightness: Theme.of(context).brightness),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        initialDateTime: DateTime.now(),
                        use24hFormat: true,
                        onDateTimeChanged: (time) {
                          selectedTime = time;
                        },
                      ),
                    ),
                  ),
                ).whenComplete(() {
                  setState(() {
                    _reminderTimeController.text =
                        "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
                  });
                });
              },
            ),
            const SizedBox(height: 16),

            // Notification toggle
            SwitchListTile(
              title: Text(
                "Enable Notifications",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              activeThumbColor: Theme.of(context).colorScheme.secondary,
              inactiveThumbColor: Colors.grey,
              value: notifProvider.notifyOn,
              onChanged: (_) => notifProvider.toggleNotif(context),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: _submitForm,
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _regularityController.dispose();
    _reminderTimeController.dispose();
    super.dispose();
  }
}
