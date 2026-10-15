import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/app_state.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(appStateProvider);
    final unwanted = s.habits.where((e) => !e.isPositive).toList();
    final positive = s.habits.where((e) => e.isPositive).toList();
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(title: const Text('Habit Transformation'), bottom: const TabBar(tabs: [Tab(text: 'Reduce'), Tab(text: 'Build')])),
      floatingActionButton: FloatingActionButton(onPressed: () => _add(context, ref), child: const Icon(Icons.add)),
      body: TabBarView(children: [_list(context, ref, unwanted), _list(context, ref, positive)]),
    ));
  }

  Widget _list(BuildContext context, WidgetRef ref, List items) => ListView(padding: const EdgeInsets.all(18), children: [
    Text('Track patterns without judgement. A lapse is information, not failure.', style: Theme.of(context).textTheme.bodyMedium), const SizedBox(height: 14),
    ...items.map((h) => Card(child: ListTile(title: Text(h.title, style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text(h.isPositive ? 'Completed ${h.todayCount} time(s) today' : 'Replacement: ${h.replacement ?? 'Not set'}'), trailing: FilledButton.tonal(onPressed: () => ref.read(appStateProvider.notifier).logHabit(h.id), child: Text(h.isPositive ? 'Done' : 'Log'))))),
  ]);

  void _add(BuildContext context, WidgetRef ref) {
    final c = TextEditingController(); bool positive = true;
    showDialog(context: context, builder: (_) => StatefulBuilder(builder: (context, setLocal) => AlertDialog(title: const Text('New habit'), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: c, decoration: const InputDecoration(labelText: 'Habit')), SwitchListTile(value: positive, onChanged: (v) => setLocal(() => positive = v), title: const Text('Positive habit'))]), actions: [FilledButton(onPressed: () { if (c.text.trim().isNotEmpty) ref.read(appStateProvider.notifier).addHabit(c.text.trim(), positive); Navigator.pop(context); }, child: const Text('Save'))])));
  }
}
