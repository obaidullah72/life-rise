import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/app_state.dart';

class ReadingScreen extends ConsumerStatefulWidget {
  const ReadingScreen({super.key});
  @override ConsumerState<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends ConsumerState<ReadingScreen> {
  Timer? timer; int seconds = 0; bool running = false;
  void toggle() {
    if (running) { timer?.cancel(); setState(() => running = false); return; }
    setState(() => running = true);
    timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() => seconds++));
  }
  @override void dispose() { timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(appStateProvider);
    final m = seconds ~/ 60, sec = seconds % 60;
    return Scaffold(appBar: AppBar(title: const Text('Reading')), body: ListView(padding: const EdgeInsets.all(18), children: [
      Card(child: Padding(padding: const EdgeInsets.all(22), child: Column(children: [Text('Today: ${s.readingMinutesToday}/${s.readingGoal} min', style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 14), LinearProgressIndicator(value: (s.readingMinutesToday / s.readingGoal).clamp(0, 1)), const SizedBox(height: 24), Text('${m.toString().padLeft(2,'0')}:${sec.toString().padLeft(2,'0')}', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800)), const SizedBox(height: 12), FilledButton.icon(onPressed: toggle, icon: Icon(running ? Icons.pause : Icons.play_arrow), label: Text(running ? 'Pause' : 'Start reading')), if (seconds > 0) TextButton(onPressed: () { final minutes = (seconds / 60).ceil(); ref.read(appStateProvider.notifier).addReadingMinutes(minutes); timer?.cancel(); setState(() { seconds = 0; running = false; }); }, child: const Text('Save session'))]))),
      const SizedBox(height: 18),
      Text('Books', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)), const SizedBox(height: 8),
      ...s.books.map((b) => Card(child: ListTile(leading: const CircleAvatar(child: Icon(Icons.menu_book)), title: Text(b.title, style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text('${b.author} · ${b.pagesRead}/${b.totalPages} pages')))),
      const SizedBox(height: 12), FilledButton.tonal(onPressed: () => _addBook(context), child: const Text('Add a book')),
    ]));
  }
  void _addBook(BuildContext context) { final t = TextEditingController(), a = TextEditingController(); showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Add book'), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: t, decoration: const InputDecoration(labelText: 'Title')), const SizedBox(height: 10), TextField(controller: a, decoration: const InputDecoration(labelText: 'Author'))]), actions: [FilledButton(onPressed: () { if (t.text.trim().isNotEmpty) ref.read(appStateProvider.notifier).addBook(t.text.trim(), a.text.trim()); Navigator.pop(context); }, child: const Text('Add'))])); }
}
