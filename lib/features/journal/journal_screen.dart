import 'package:flutter/material.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const prompts = ['What went well today?', 'What habit did I manage well?', 'What triggered an unwanted habit?', 'What did I learn today?', 'What is one thing I want to improve tomorrow?'];
    return Scaffold(appBar: AppBar(title: const Text('Evening Reflection')), body: ListView(padding: const EdgeInsets.all(18), children: [const Text('A few minutes is enough.', style: TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 14), ...prompts.map((p) => Padding(padding: const EdgeInsets.only(bottom: 12), child: TextField(maxLines: 3, decoration: InputDecoration(labelText: p))), SizedBox(height: 12)), FilledButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reflection saved locally'))), child: const Text('Save reflection'))]));
  }
}
