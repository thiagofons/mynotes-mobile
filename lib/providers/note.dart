import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:mynotes/models/note.dart';
import 'package:mynotes/services/note.dart';
import 'package:uuid/uuid.dart';

class NoteProvider with ChangeNotifier {
  final NoteService _noteService;

  NoteProvider(this._noteService);

  var uuid = const Uuid();

  List<NoteModel> _notes = [];
  List<NoteModel> get notes => _notes;

  String _summary = "";
  String get summary => _summary;

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

    logger.d(success);

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

  Future<void> getNotesSummary() async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];

    if (apiKey == null) {
      print('No \$API_KEY environment variable');
      return;
    }

    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);

    print(_notes.toString());

    final content = [
      Content.text(
          'Tenho esse conjunto de notas de uma pessoa em uma aplicativo de notas: ${_notes.toString()}. Escreva um resumo sucinto sobre as notas, com até 30 palavras, levando em conta que o dia de hoje é ${DateTime.now()}. Fale em segunda pessoa, como se estivesse falando com o usuário diretamente. Escolha apenas uma nota, a qual você acha mais importante, e faça o comentário sobre ela. Use imperativos e uma linguagem amigável, sem precisar descrever objetivamente o que as notas dizem. Utilize, no máximo 140 caracteres')
    ];

    final response = await model.generateContent(content);

    _summary = response.text ?? "";
  }
}
