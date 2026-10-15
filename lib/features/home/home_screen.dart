import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/app_state.dart';
import '../../shared/widgets/section_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(appStateProvider);
    final done = s.routine.where((e) => e.completed).length;
    final progress = s.routine.isEmpty ? 0.0 : done / s.routine.length;
    return Scaffold(
      appBar: AppBar(title: const Text('LifeRise'), actions: [IconButton(onPressed: () => context.push('/calendar'), icon: const Icon(Icons.calendar_month_outlined)), IconButton(onPressed: () => context.push('/settings'), icon: const Icon(Icons.settings_outlined))]),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Text('Good morning', style: Theme.of(context).textTheme.labelLarge),
          Text('Today is a fresh start.', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 18),
          SectionCard(child: Row(children: [
            SizedBox(width: 90, height: 90, child: Stack(alignment: Alignment.center, children: [CircularProgressIndicator(value: progress, strokeWidth: 9), Text('${(progress * 100).round()}%', style: const TextStyle(fontWeight: FontWeight.w800))])),
            const SizedBox(width: 18),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Daily progress', style: TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 6), Text('$done of ${s.routine.length} routine items complete'), const SizedBox(height: 8), Text('${s.readingMinutesToday}/${s.readingGoal} reading minutes')]))
          ])),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _Quick(title: 'Read instead', icon: Icons.menu_book_outlined, onTap: () => context.go('/reading'))),
            const SizedBox(width: 12),
            Expanded(child: _Quick(title: 'Reflect', icon: Icons.edit_note_outlined, onTap: () => context.push('/journal'))),
          ]),
          const SizedBox(height: 18),
          Text('Today’s routine', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          ...s.routine.take(4).map((a) => Card(child: CheckboxListTile(value: a.completed, onChanged: (_) => ref.read(appStateProvider.notifier).toggleRoutine(a.id), title: Text(a.title, style: const TextStyle(fontWeight: FontWeight.w600)), subtitle: Text('${a.time} · ${a.category}'), controlAffinity: ListTileControlAffinity.leading))),
          const SizedBox(height: 8),
          FilledButton.tonal(onPressed: () => context.go('/routine'), child: const Text('View full routine')),
        ],
      ),
    );
  }
}

class _Quick extends StatelessWidget {
  const _Quick({required this.title, required this.icon, required this.onTap});
  final String title; final IconData icon; final VoidCallback onTap;
  @override Widget build(BuildContext context) => Card(child: InkWell(borderRadius: BorderRadius.circular(20), onTap: onTap, child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon), const SizedBox(height: 18), Text(title, style: const TextStyle(fontWeight: FontWeight.w800))]))));
}
