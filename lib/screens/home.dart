import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mynotes/models/note.dart';
import 'package:mynotes/providers/note.dart';
import 'package:mynotes/widgets/note/add_note_button.dart';
import 'package:mynotes/widgets/note/note.dart';
import 'package:mynotes/widgets/note_summary/note_summary.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    handleRefresh() async {
      await Provider.of<NoteProvider>(context, listen: false)
          .fetchNotesFromServer();
      await Provider.of<NoteProvider>(context, listen: false).getNotesSummary();
      setState(() {});
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Center(
          child: Image.asset(
            "assets/images/logo.png",
            width: 100,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => handleRefresh(),
        child: Stack(
          children: [
            FutureBuilder(
              future: Provider.of<NoteProvider>(context, listen: false)
                  .fetchNotesFromServer(),
              builder: (context, snapshot) => Consumer<NoteProvider>(
                builder: (context, noteProvider, child) {
                  List<NoteModel> notes = noteProvider.notes;
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 132, 16, 16),
                    itemCount: notes.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Note(note: notes[index]),
                    ),
                  );
                },
              ),
            ),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: NoteSummary(),
            ),
          ],
        ),
      ),
      floatingActionButton: const AddNoteButton(),
    );
  }
}
