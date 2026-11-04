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
                // TODO(a11y): [S9 Semantics]
                // The emoji is read aloud: "Good morning, waving hand".
                // Fix: keep the emoji on screen, but give the Text a clean
                // spoken label.
                //
                //   Text(
                //     'Good morning 👋',
                //     semanticsLabel: 'Good morning',
                //     style: textTheme.bodySmall,
                //   ),
                Text('Good morning 👋', style: textTheme.bodySmall),
                const SizedBox(height: 2),
                // TODO(a11y): [H1 Heading]
                // "Fresh Market" is the screen title, but there is no AppBar,
                // so it is not announced as a heading.
                // Fix: give it heading level 1 (the main title of the screen).
                //
                //   Semantics(
                //     headingLevel: 1,
                //     child: Text('Fresh Market', style: textTheme.headlineSmall),
                //   ),
                Text('Fresh Market', style: textTheme.headlineSmall),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
