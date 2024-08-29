import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mynotes/models/note.dart';
import 'package:mynotes/providers/note.dart';
import 'package:mynotes/widgets/note/add_note_button.dart';
import 'package:mynotes/widgets/note/note.dart';
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
      // Simulate network fetch or database query
      await Provider.of<NoteProvider>(context, listen: false)
          .fetchNotesFromServer();
      // Update the list of items and refresh the UI
      setState(() {
        // items = List.generate(20, (index) => "Refreshed Item ${index + 1}");
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Center(
          child: Image.asset(
            "assets/images/logo.png",
            width: 100,
          ),
        ),
        centerTitle: true,
        // backgroundColor: Colors.transparent, // Deixa a AppBar transparente
        elevation: 0, // Remove a sombra
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 10.0, sigmaY: 10.0), // Define o nível de desfoque
            child: Container(
              color: Theme.of(context)
                  .colorScheme
                  .secondary
                  .withOpacity(0.25), // Cor translúcida sobre o efeito de blur
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => handleRefresh(),
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          child: FutureBuilder(
              future: Provider.of<NoteProvider>(context, listen: false)
                  .fetchNotesFromServer(),
              builder: (context, snapshot) => Consumer<NoteProvider>(
                    builder: (context, noteProvider, child) {
                      List<NoteModel> notes = noteProvider.notes;
                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: notes.length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Note(note: notes[index]),
                        ),
                      );
                    },
                  )),
        ),
      ),
      floatingActionButton: const AddNoteButton(),
    );
  }
}
