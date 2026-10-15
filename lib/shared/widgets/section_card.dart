import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.child, this.padding = const EdgeInsets.all(18)});
  final Widget child;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) => Card(
    child: Container(
      padding: padding,
      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).dividerColor.withOpacity(.25)), borderRadius: BorderRadius.circular(20)),
      child: child,
    ),
  );
}
