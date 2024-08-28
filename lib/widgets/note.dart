import 'package:flutter/material.dart';
import 'package:mynotes/models/note.dart';
import 'package:mynotes/providers/note.dart';
import 'package:provider/provider.dart';

class Note extends StatefulWidget {
  final NoteModel data;

  const Note({super.key, required this.data});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    removeNote() {
      Provider.of<NoteProvider>(context, listen: false)
          .removeNote(widget.data.id!);
    }

    return Container(
      width: 120,
      height: 120,
      padding: const EdgeInsets.all(12), // padding igual em todos os lados
      decoration: const BoxDecoration(
        color: Color(0xffffc93c),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.data.title ?? "",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              IconButton(
                  onPressed: () => removeNote(),
                  icon: Icon(
                    Icons.remove,
                    size: 24,
                    color: Theme.of(context).colorScheme.error,
                  ))
            ],
          ),
          Text(
            widget.data.content ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
