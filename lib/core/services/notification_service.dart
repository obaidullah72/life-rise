import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();
  static final instance = NotificationService._();
  final _plugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _plugin.initialize(const InitializationSettings(android: android, iOS: ios));
  }

  Future<void> showTestReminder() async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails('liferise_reminders', 'LifeRise reminders', importance: Importance.defaultImportance),
      iOS: DarwinNotificationDetails(),
    );
    await _plugin.show(1, 'LifeRise', 'A small step is enough today.', details);
  }
}
