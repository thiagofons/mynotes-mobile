import 'dart:ui';

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
    return Scaffold(
      appBar: AppBar(
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
              color: Colors.white
                  .withOpacity(0.25), // Cor translúcida sobre o efeito de blur
            ),
          ),
        ),
      ),
      body: Container(
        color: const Color(0xff2974ff),
        child: Consumer<NoteProvider>(
          builder: (context, noteProvider, child) {
            List<NoteModel> notes = noteProvider.notes;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notes.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Note(data: notes[index]),
              ),
            );
          },
        ),
      ),
      floatingActionButton: const AddNoteButton(),
    );
  }
}
