import 'package:flutter/material.dart';
import 'package:mynotes/providers/note.dart';
import 'package:provider/provider.dart';

class NoteSummary extends StatefulWidget {
  const NoteSummary({super.key});

  @override
  State<NoteSummary> createState() => _NoteSummaryState();
}

class _NoteSummaryState extends State<NoteSummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      height: 100,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 200),
        child: Expanded(
          flex: 1,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Material(
                  elevation: 12,
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(12)),
                    child: ListView(
                      children: [
                        Text(
                          "💡 Dica: ${Provider.of<NoteProvider>(context).summary}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
