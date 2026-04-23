import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteService extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => List.unmodifiable(_notes);

  int get count => _notes.length;

  void addNote(Note note) {
    _notes.insert(0, note);
    notifyListeners();
  }

  void updateNote(Note note) {
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = note;
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  Note? getNoteById(String id) {
    try {
      return _notes.firstWhere((n) => n.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Note> search(String query) {
    if (query.trim().isEmpty) return notes;
    final q = query.toLowerCase();
    return _notes
        .where((n) =>
            n.titre.toLowerCase().contains(q) ||
            n.contenu.toLowerCase().contains(q))
        .toList();
  }
}
