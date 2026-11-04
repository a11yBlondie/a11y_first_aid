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
          // TODO(a11y): [H2 Heading]
          // Section titles are not headings, so users can't jump between
          // sections with the headings navigation.
          // Fix: give it heading level 2 (a section inside the screen).
          //
          //   Semantics(
          //     headingLevel: 2,
          //     child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          //   ),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          if (decoration case final emoji?) ...[
            const SizedBox(width: 8),
            // TODO(a11y): [S7 Semantics]
            // The emoji decoration is read aloud: "fire, fire, fire".
            // Fix:
            //
            //   ExcludeSemantics(child: Text(emoji)),
            Text(emoji),
          ],
        ],
      ),
    );
  }
}
