import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Calendar & History')), body: Padding(padding: const EdgeInsets.all(18), child: Column(children: [CalendarDatePicker(initialDate: DateTime.now(), firstDate: DateTime(DateTime.now().year - 1), lastDate: DateTime(DateTime.now().year + 1), onDateChanged: (_) {}), const SizedBox(height: 16), const Card(child: ListTile(leading: Icon(Icons.info_outline), title: Text('Missing records are not treated as failure.'), subtitle: Text('Open any day to review routines, habits, reading and reflections.')))])));
}
