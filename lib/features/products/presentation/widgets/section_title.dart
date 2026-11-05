import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, this.decoration});

  final String title;
  final String? decoration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        children: [
          Semantics(
            headingLevel: 2,
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          if (decoration case final emoji?) ...[
            const SizedBox(width: 8),
            ExcludeSemantics(child: Text(emoji)),
          ],
        ],
      ),
    );
  }
}
