import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:habit_tracker/data/local/storage_service.dart';
import 'package:habit_tracker/data/models/habit.dart';
// import 'package:meta/meta.dart';

part 'habit_tracker_event.dart';
part 'habit_tracker_state.dart';

class HabitTrackerBloc extends Bloc<HabitTrackerEvent, HabitTrackerState> {
  final StorageService storage;

  HabitTrackerBloc(this.storage) : super(HabitTrackerInitial()) {
    on<LoadHabits>(_onLoadHabits);
    on<AddHabit>(_onAddHabits);
    on<RemoveHabit>(_onRemoveHabit);
    on<ToggleHabitComplete>(_onToggleHabitComplete);
  }

  Future<void> _onLoadHabits(LoadHabits event, Emitter<HabitTrackerState> emit) async {
    emit(HabitTrackerLoading());
    final habits = await storage.loadHabits();
    emit(HabitTrackerLoaded(habits));
  }


  Future<void> _onAddHabits(AddHabit event,Emitter<HabitTrackerState> emit) async{
    if(state is HabitTrackerLoaded){
      final current = (state as HabitTrackerLoaded).habits;
      final updated = List<Habit>.from(current)..add(event.habit);
      await storage.saveHabits(updated);
      emit(HabitTrackerLoaded(updated));
    }
  }


  Future<void> _onRemoveHabit(
    RemoveHabit event,
    Emitter<HabitTrackerState> emit,
  ) async {
    if (state is HabitTrackerLoaded) {
      final current = (state as HabitTrackerLoaded).habits;
      final updated = List<Habit>.from(current)..removeAt(event.index);
      await storage.saveHabits(updated);
      emit(HabitTrackerLoaded(updated));
    }
  }

  Future<void> _onToggleHabitComplete(
    ToggleHabitComplete event,
    Emitter<HabitTrackerState> emit,
  ) async {
    if (state is HabitTrackerLoaded) {
      final current = (state as HabitTrackerLoaded).habits;
      final updated = List<Habit>.from(current);
      final habit = updated[event.index];
      habit.isCompleted = !habit.isCompleted;
      updated[event.index] = habit;
      await storage.saveHabits(updated);
      emit(HabitTrackerLoaded(updated));
    }
  }

}



