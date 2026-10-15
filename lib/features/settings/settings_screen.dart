import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/app_state.dart';
import '../../core/services/notification_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(appStateProvider);
    return Scaffold(appBar: AppBar(title: const Text('Settings & Privacy')), body: ListView(padding: const EdgeInsets.all(18), children: [
      SwitchListTile(value: s.darkMode, onChanged: ref.read(appStateProvider.notifier).toggleDarkMode, title: const Text('Dark mode')), const Divider(),
      ListTile(leading: const Icon(Icons.notifications_outlined), title: const Text('Test reminder'), subtitle: const Text('Local notification only'), onTap: () => NotificationService.instance.showTestReminder()),
      const ListTile(leading: Icon(Icons.lock_outline), title: Text('Local-only privacy'), subtitle: Text('LifeRise does not require an account or cloud backend by default.')),
      const ListTile(leading: Icon(Icons.download_outlined), title: Text('Export data'), subtitle: Text('JSON/CSV export hook ready for implementation.')),
      const ListTile(leading: Icon(Icons.restore), title: Text('Backup & restore'), subtitle: Text('Local data architecture is prepared for backup workflows.')),
    ]));
  }
}
