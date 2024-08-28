import 'package:flutter/material.dart';
import 'package:mynotes/models/note.dart';
import 'package:mynotes/providers/note.dart';
import 'package:mynotes/widgets/add_note_button.dart';
import 'package:mynotes/widgets/note.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<NoteModel> notes = Provider.of<NoteProvider>(context).notes;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            "assets/images/logo.png",
            width: 100,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xff2974ff),
        child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notes.length,
            itemBuilder: (context, index) => Note(data: notes[index])),
      ),
      floatingActionButton: const AddNoteButton(),
    );
  }
}
