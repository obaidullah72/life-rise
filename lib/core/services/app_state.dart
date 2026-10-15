import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';

class LifeRiseState {
  const LifeRiseState({
    this.darkMode = false,
    this.userName = 'Friend',
    this.readingGoal = 20,
    this.readingMinutesToday = 12,
    this.routine = const [],
    this.habits = const [],
    this.books = const [],
  });
  final bool darkMode;
  final String userName;
  final int readingGoal;
  final int readingMinutesToday;
  final List<RoutineActivity> routine;
  final List<HabitItem> habits;
  final List<ReadingBook> books;

  LifeRiseState copyWith({bool? darkMode, String? userName, int? readingGoal, int? readingMinutesToday, List<RoutineActivity>? routine, List<HabitItem>? habits, List<ReadingBook>? books}) => LifeRiseState(
    darkMode: darkMode ?? this.darkMode,
    userName: userName ?? this.userName,
    readingGoal: readingGoal ?? this.readingGoal,
    readingMinutesToday: readingMinutesToday ?? this.readingMinutesToday,
    routine: routine ?? this.routine,
    habits: habits ?? this.habits,
    books: books ?? this.books,
  );
}

class AppStateNotifier extends StateNotifier<LifeRiseState> {
  AppStateNotifier() : super(_seed()) { _load(); }
  static const _key = 'liferise_state_v1';
  static const _uuid = Uuid();

  static LifeRiseState _seed() => LifeRiseState(
    routine: [
      RoutineActivity(id: 'r1', title: 'Wake up & water', time: '7:00 AM', category: 'Wellness'),
      RoutineActivity(id: 'r2', title: 'Read for 15 minutes', time: '8:00 AM', category: 'Reading'),
      RoutineActivity(id: 'r3', title: 'Focused work / study', time: '9:00 AM', category: 'Focus'),
      RoutineActivity(id: 'r4', title: 'Exercise or walk', time: '6:00 PM', category: 'Fitness'),
      RoutineActivity(id: 'r5', title: 'Evening reflection', time: '9:30 PM', category: 'Reflection'),
    ],
    habits: [
      HabitItem(id: 'h1', title: 'Unplanned scrolling', isPositive: false, replacement: 'Read 5 pages'),
      HabitItem(id: 'h2', title: 'Procrastination', isPositive: false, replacement: '5-minute focus sprint'),
      HabitItem(id: 'h3', title: 'Daily reading', isPositive: true),
      HabitItem(id: 'h4', title: 'Evening walk', isPositive: true),
    ],
    books: [ReadingBook(id: 'b1', title: 'Atomic Habits', author: 'James Clear', pagesRead: 84, totalPages: 320)],
  );

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    final raw = p.getString(_key);
    if (raw == null) return;
    try {
      final j = jsonDecode(raw) as Map<String, dynamic>;
      state = LifeRiseState(
        darkMode: j['darkMode'] ?? false,
        userName: j['userName'] ?? 'Friend',
        readingGoal: j['readingGoal'] ?? 20,
        readingMinutesToday: j['readingMinutesToday'] ?? 0,
        routine: (j['routine'] as List? ?? []).map((e) => RoutineActivity.fromJson(Map<String, dynamic>.from(e))).toList(),
        habits: (j['habits'] as List? ?? []).map((e) => HabitItem.fromJson(Map<String, dynamic>.from(e))).toList(),
        books: (j['books'] as List? ?? []).map((e) => ReadingBook.fromJson(Map<String, dynamic>.from(e))).toList(),
      );
    } catch (_) {}
  }

  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_key, jsonEncode({
      'darkMode': state.darkMode,
      'userName': state.userName,
      'readingGoal': state.readingGoal,
      'readingMinutesToday': state.readingMinutesToday,
      'routine': state.routine.map((e) => e.toJson()).toList(),
      'habits': state.habits.map((e) => e.toJson()).toList(),
      'books': state.books.map((e) => e.toJson()).toList(),
    }));
  }

  void toggleDarkMode(bool value) { state = state.copyWith(darkMode: value); _save(); }
  void toggleRoutine(String id) {
    final items = [...state.routine];
    final i = items.indexWhere((e) => e.id == id);
    if (i >= 0) items[i].completed = !items[i].completed;
    state = state.copyWith(routine: items); _save();
  }
  void addRoutine(String title, String time, String category) {
    state = state.copyWith(routine: [...state.routine, RoutineActivity(id: _uuid.v4(), title: title, time: time, category: category)]); _save();
  }
  void logHabit(String id) {
    final items = [...state.habits];
    final i = items.indexWhere((e) => e.id == id);
    if (i >= 0) items[i].todayCount++;
    state = state.copyWith(habits: items); _save();
  }
  void addHabit(String title, bool positive, {String? replacement}) {
    state = state.copyWith(habits: [...state.habits, HabitItem(id: _uuid.v4(), title: title, isPositive: positive, replacement: replacement)]); _save();
  }
  void addReadingMinutes(int minutes) { state = state.copyWith(readingMinutesToday: state.readingMinutesToday + minutes); _save(); }
  void addBook(String title, String author) { state = state.copyWith(books: [...state.books, ReadingBook(id: _uuid.v4(), title: title, author: author)]); _save(); }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, LifeRiseState>((ref) => AppStateNotifier());
