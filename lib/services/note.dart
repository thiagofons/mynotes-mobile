import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:logger/logger.dart';
import 'package:mynotes/api/api_endpoints.dart';
import 'package:mynotes/models/note.dart';

var logger = Logger();

class NoteService {
  Future<List<NoteModel>> getNotesFromServer() async {
    final request = await http.get(Uri.parse(ApiEndpoints.notes));

    return NoteModel.listFromJson(jsonDecode(request.body));
  }

  Future<bool> addNoteToServer(NoteModel note) async {
    try {
      await http.post(Uri.parse(ApiEndpoints.notes), body: note.toJson());

      return true;
    } catch (error) {
      logger.e("Error adding note: $error");
      return false;
    }
  }

  Future<bool> removeNoteFromServer(NoteModel note) async {
    try {
      await http.delete(Uri.parse(ApiEndpoints.notesById(note.id!)));

      return true;
    } catch (error) {
      logger.e("Error adding note: $error");
      return false;
    }
  }

  Future<bool> updateNoteInServer(NoteModel note) async {
    try {
      await http.put(Uri.parse(ApiEndpoints.notesById(note.id!)),
          body: note.toJson());

      return true;
    } catch (error) {
      logger.e("Error updating note: $error");
      return false;
    }
  }
}
