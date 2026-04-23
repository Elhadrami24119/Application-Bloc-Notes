import 'package:flutter/material.dart';
import '../models/note.dart';

enum TriNotes {
  dateRecent,
  dateAncien,
  titreAZ,
  titreZA,
}

class NoteService extends ChangeNotifier {
  final List<Note> _notes = [];
  TriNotes _triActuel = TriNotes.dateRecent;

  List<Note> get notes {
    final liste = List<Note>.from(_notes);
    switch (_triActuel) {
      case TriNotes.dateRecent:
        liste.sort((a, b) => b.dateCreation.compareTo(a.dateCreation));
        break;
      case TriNotes.dateAncien:
        liste.sort((a, b) => a.dateCreation.compareTo(b.dateCreation));
        break;
      case TriNotes.titreAZ:
        liste.sort((a, b) => a.titre.compareTo(b.titre));
        break;
      case TriNotes.titreZA:
        liste.sort((a, b) => b.titre.compareTo(a.titre));
        break;
    }
    return List.unmodifiable(liste);
  }

  TriNotes get triActuel => _triActuel;
  int get count => _notes.length;

  void changerTri(TriNotes tri) {
    _triActuel = tri;
    notifyListeners();
  }

  void addNote(Note note) {
    _notes.add(note);
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
    return notes
        .where((n) =>
            n.titre.toLowerCase().contains(q) ||
            n.contenu.toLowerCase().contains(q))
        .toList();
  }
}
