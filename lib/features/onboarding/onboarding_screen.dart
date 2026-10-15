import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int step = 0;
  final pages = const [
    ('Build a routine that fits real life', 'Choose wake, work, reading and sleep anchors. You can edit everything later.', Icons.wb_sunny_outlined),
    ('Replace, don’t just resist', 'Connect unwanted habits with small, healthier alternatives that are easy to start.', Icons.loop),
    ('Read a little, consistently', 'Start with five minutes or a few pages. LifeRise tracks progress without pressure.', Icons.menu_book_outlined),
    ('Reflect without judgement', 'Missed days are information, not failure. Return gently and keep going.', Icons.favorite_outline),
  ];

  @override
  Widget build(BuildContext context) {
    final p = pages[step];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              CircleAvatar(radius: 36, child: Icon(p.$3, size: 34)),
              const SizedBox(height: 28),
              Text(p.$1, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              Text(p.$2, style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5)),
              const Spacer(),
              Row(children: List.generate(pages.length, (i) => Expanded(child: Container(height: 5, margin: const EdgeInsets.only(right: 8), decoration: BoxDecoration(color: i <= step ? Theme.of(context).colorScheme.primary : Theme.of(context).dividerColor, borderRadius: BorderRadius.circular(99))))),),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => step == pages.length - 1 ? context.go('/home') : setState(() => step++),
                  child: Padding(padding: const EdgeInsets.symmetric(vertical: 14), child: Text(step == pages.length - 1 ? 'Start LifeRise' : 'Continue')),
                ),
              ),
              TextButton(onPressed: () => context.go('/home'), child: const Text('Skip for now')),
            ],
          ),
        ),
      ),
    );
  }
}
