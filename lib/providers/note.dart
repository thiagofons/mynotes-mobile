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
    _notes = await _noteService.getNotesFromServer();

    notifyListeners();
  }

  void createNote(NoteModel note) async {
    note.id = uuid.v1();

    final success = await _noteService.addNoteToServer(note);

    if (success) {
      _notes.add(note);
      notifyListeners();
    }
  }

  void removeNote(NoteModel note) async {
    final success = await _noteService.removeNoteFromServer(note);

    if (success) {
      _notes.remove(note);
      notifyListeners();
    }
  }

  void updateNote(NoteModel newNote) async {
    final success = await _noteService.updateNoteInServer(newNote);

    if (success) {
      NoteModel oldNote = _notes.firstWhere((note) => note.id == newNote.id);
      oldNote.title = newNote.title;
      oldNote.content = newNote.content;

      notifyListeners(); // Notifica os ouvintes sobre a alteração
    }
  }
}
