import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/home/home_screen.dart';
import '../features/routine/routine_screen.dart';
import '../features/habits/habits_screen.dart';
import '../features/reading/reading_screen.dart';
import '../features/insights/insights_screen.dart';
import '../features/journal/journal_screen.dart';
import '../features/calendar/calendar_screen.dart';
import '../features/settings/settings_screen.dart';
import '../shared/widgets/app_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => AppShell(shell: shell),
      branches: [
        StatefulShellBranch(routes: [GoRoute(path: '/home', builder: (_, __) => const HomeScreen())]),
        StatefulShellBranch(routes: [GoRoute(path: '/routine', builder: (_, __) => const RoutineScreen())]),
        StatefulShellBranch(routes: [GoRoute(path: '/habits', builder: (_, __) => const HabitsScreen())]),
        StatefulShellBranch(routes: [GoRoute(path: '/reading', builder: (_, __) => const ReadingScreen())]),
        StatefulShellBranch(routes: [GoRoute(path: '/insights', builder: (_, __) => const InsightsScreen())]),
      ],
    ),
    GoRoute(path: '/journal', builder: (_, __) => const JournalScreen()),
    GoRoute(path: '/calendar', builder: (_, __) => const CalendarScreen()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
  ],
);
