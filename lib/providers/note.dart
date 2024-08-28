import 'package:flutter/material.dart';
import 'package:mynotes/models/note.dart';
import 'package:mynotes/services/note.dart';
import 'package:uuid/uuid.dart';

class NoteProvider with ChangeNotifier {
  final NoteService _noteService;

  NoteProvider(this._noteService);

  var uuid = Uuid();

  List<NoteModel> _notes = [];

  List<NoteModel> get notes => _notes;

  void createNote(NoteModel note) {
    note.id = uuid.v1();

    _notes.add(note);

    notifyListeners();
  }

  void removeNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
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
