# LifeRise

LifeRise is a Flutter/Dart personal growth app based on the supplied specification: daily routine planning, habit transformation, reading, reflection, insights, reminders, calendar/history, and privacy-first local persistence.

## Stack

- Flutter + Dart
- Material 3
- Riverpod
- GoRouter
- SharedPreferences
- SQLite (sqflite) data layer scaffold
- Flutter Local Notifications
- FL Chart

## Run

This ZIP contains the full Dart source structure. If the platform folders are not present, generate them once from the project root:

```bash
flutter create . --project-name liferise
flutter pub get
flutter run
```

## Notes

- Data is stored locally by default.
- The app is backend-free and offline-first.
- SQLite tables are scaffolded in `lib/data/app_database.dart` for structured logs/history.
- SharedPreferences is currently used for lightweight persisted UI/demo state.
- Local notifications are initialized in `main.dart`.
- Add Android/iOS notification permission configuration as required by the Flutter Local Notifications package for your target OS versions.

## Project structure

```text
lib/
  app/
    liferise_app.dart
    router.dart
    theme.dart
  core/
    models/
    services/
  data/
  features/
    onboarding/
    home/
    routine/
    habits/
    reading/
    insights/
    journal/
    calendar/
    settings/
  shared/widgets/
```
