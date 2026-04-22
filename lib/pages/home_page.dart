import 'package:flutter/material.dart';
import '../models/note.dart';
import 'create_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> _notes = [];

  Future<void> _ouvrirCreation() async {
    final Note? nouvelleNote = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateNotePage()),
    );
    if (nouvelleNote != null) {
      setState(() {
        _notes.insert(0, nouvelleNote);
      });
    }
  }

  Future<void> _ouvrirDetail(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailNotePage(note: _notes[index]),
      ),
    );
    if (result is Note) {
      setState(() {
        _notes[index] = result;
      });
    } else if (result == 'deleted') {
      setState(() {
        _notes.removeAt(index);
      });
    }
  }

  Color _hexVersColor(String hex) {
    final h = hex.replaceFirst('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }

  String _formaterDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Notes'),
        backgroundColor: Colors.amber[700],
        foregroundColor: Colors.white,
      ),
      body: _notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.note_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Aucune note',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    'Appuyez sur + pour créer une note',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                final couleur = _hexVersColor(note.couleur);
                final apercu = note.contenu.length > 30
                    ? '${note.contenu.substring(0, 30)}...'
                    : note.contenu;

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () => _ouvrirDetail(index),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: couleur, width: 5),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note.titre,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            apercu,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          SizedBox(height: 8),
                          Text(
                            _formaterDate(note.dateCreation),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _ouvrirCreation,
        backgroundColor: Colors.amber[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}