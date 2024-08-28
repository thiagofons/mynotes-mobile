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

  Future<void> fetchNotesFromServer() async {
    final request = await _noteService.getNotesFromServer();

    if (request != null) {
      _notes = request;
    }

    notifyListeners();
  }

  void createNote(NoteModel note) {
    note.id = uuid.v1();

    _noteService.addNoteToServer(note).then((value) {
      _notes.add(note);
    });

    notifyListeners();
  }

  void removeNote(NoteModel note) {
    String id = note.id!;

    _noteService.removeNoteFromServer(note).then((value) {
      _notes.remove(note);
    });

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
