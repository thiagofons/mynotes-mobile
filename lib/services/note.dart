import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:mynotes/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

var logger = Logger();

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
      logger.e("Error adding note: $error");
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
      logger.e("Error adding note: $error");
      return false;
    }
  }

  Future<bool> updateNoteInServer(NoteModel note) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final List<String> notesStringList = prefs.getStringList("notes") ?? [];

      final List<String> updatedNotesStringList =
          notesStringList.map((String item) {
        NoteModel decodedItem = NoteModel.fromJson(jsonDecode(item));

        if (decodedItem.id == note.id) {
          logger.d(note.toString());

          return jsonEncode(note.toJson());
        }
        // Retorna o item não modificado
        return item;
      }).toList();

      // Salva a lista atualizada no SharedPreferences
      await prefs.setStringList("notes", updatedNotesStringList);

      return true;
    } catch (error) {
      logger.e("Error updating note: $error");
      return false;
    }
  }
}
