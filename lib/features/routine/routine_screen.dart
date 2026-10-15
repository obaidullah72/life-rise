import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/app_state.dart';

class RoutineScreen extends ConsumerWidget {
  const RoutineScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(appStateProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Routine')),
      floatingActionButton: FloatingActionButton.extended(onPressed: () => _add(context, ref), icon: const Icon(Icons.add), label: const Text('Activity')),
      body: ListView.separated(
        padding: const EdgeInsets.all(18), itemCount: s.routine.length, separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) { final a = s.routine[i]; return Card(child: ListTile(leading: Checkbox(value: a.completed, onChanged: (_) => ref.read(appStateProvider.notifier).toggleRoutine(a.id)), title: Text(a.title, style: TextStyle(fontWeight: FontWeight.w700, decoration: a.completed ? TextDecoration.lineThrough : null)), subtitle: Text('${a.time} · ${a.category}'), trailing: const Icon(Icons.drag_handle))); },
      ),
    );
  }

  void _add(BuildContext context, WidgetRef ref) {
    final title = TextEditingController(); final time = TextEditingController(text: '7:00 PM');
    showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Add routine activity'), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: title, decoration: const InputDecoration(labelText: 'Title')), const SizedBox(height: 10), TextField(controller: time, decoration: const InputDecoration(labelText: 'Time'))]), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')), FilledButton(onPressed: () { if (title.text.trim().isNotEmpty) ref.read(appStateProvider.notifier).addRoutine(title.text.trim(), time.text.trim(), 'Personal'); Navigator.pop(context); }, child: const Text('Add'))]));
  }
}
