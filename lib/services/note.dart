import 'dart:convert';

import 'package:mynotes/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteService {
  Future<List<NoteModel>> getNotesFromServer() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> notesStringList = prefs.getStringList("notes") ?? [];

    return notesStringList.map((noteString) {
      final Map<String, dynamic> noteJson = jsonDecode(noteString);
      return NoteModel.fromJson(noteJson);
    }).toList();
  }

  Future<bool> addNoteToServer(NoteModel note) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final List<String> notesStringList = prefs.getStringList("notes") ?? [];

      notesStringList.add(jsonEncode(note.toJson()));

      await prefs.setStringList("notes", notesStringList);

      return true;
    } catch (error) {
      print("Error adding note: $error");
      return false;
    }
  }

  Future<bool> removeNoteFromServer(NoteModel note) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final List<String> notesStringList = prefs.getStringList("notes") ?? [];

      notesStringList.remove(jsonEncode(note.toJson()));

      await prefs.setStringList("notes", notesStringList);

      return true;
    } catch (error) {
      print("Error adding note: $error");
      return false;
    }
  }
}
