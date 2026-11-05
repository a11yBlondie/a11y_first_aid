import 'package:flutter/material.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key, required this.trailing});

  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning 👋',
                  semanticsLabel: 'Good morning',
                  style: textTheme.bodySmall,
                ),
                const SizedBox(height: 2),
                Semantics(
                  headingLevel: 1,
                  child: Text('Fresh Market', style: textTheme.headlineSmall),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
