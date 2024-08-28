import 'package:flutter/material.dart';
import 'package:mynotes/models/note.dart';

class NoteProvider with ChangeNotifier {
  List<NoteModel> _notes = [NoteModel(title: "Thiago", content: "Cu")];

  List<NoteModel> get notes => _notes;

  void createNote(NoteModel note) {
    _notes.add(note);
  }

  /**
  void updateNote(Note newNote) {
    _notes.map((note) => {
      if(note.id == newNote.id) {
        note = newNote
      }
    });
  }
  */
}
