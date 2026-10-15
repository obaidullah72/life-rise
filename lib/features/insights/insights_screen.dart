import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/app_state.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(appStateProvider);
    final done = s.routine.where((e) => e.completed).length;
    return Scaffold(appBar: AppBar(title: const Text('Insights')), body: ListView(padding: const EdgeInsets.all(18), children: [
      Row(children: [Expanded(child: _Stat('Routine today', '$done/${s.routine.length}')), const SizedBox(width: 10), Expanded(child: _Stat('Reading', '${s.readingMinutesToday} min'))]),
      const SizedBox(height: 16),
      Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Weekly completion', style: TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 18), SizedBox(height: 190, child: BarChart(BarChartData(borderData: FlBorderData(show: false), gridData: const FlGridData(show: false), titlesData: const FlTitlesData(leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true))), barGroups: [55,70,45,82,65,90,72].asMap().entries.map((e) => BarChartGroupData(x: e.key, barRods: [BarChartRodData(toY: e.value.toDouble(), width: 16, borderRadius: BorderRadius.circular(6))])).toList())))]))),
      const SizedBox(height: 16),
      Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Pattern summary', style: TextStyle(fontWeight: FontWeight.w800)), SizedBox(height: 10), Text('Your strongest consistency is in the morning. Unplanned screen time appears most often late in the evening. Consider keeping the “Read instead” action visible around bedtime.')]))),
    ]));
  }
}

class _Stat extends StatelessWidget { const _Stat(this.label, this.value); final String label, value; @override Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label), const SizedBox(height: 6), Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800))]))); }
