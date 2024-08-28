import 'package:flutter/material.dart';
import 'package:mynotes/models/note.dart';

class Note extends StatefulWidget {
  final NoteModel data;

  const Note({super.key, required this.data});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: const BoxDecoration(
          color: Color(0xffffc93c),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: [Text(widget.data.title!), Text(widget.data.content ?? "")],
      ),
    );
  }
}
