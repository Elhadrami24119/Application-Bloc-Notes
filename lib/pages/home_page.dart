import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../services/note_service.dart';
import 'create_page.dart';
import 'detail_page.dart';

// StatelessWidget car plus besoin de setState pour les notes
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// On garde StatefulWidget uniquement pour la recherche (_query)
class _HomePageState extends State<HomePage> {
  String _query = '';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _ouvrirCreation() async {
    final Note? nouvelleNote = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateNotePage()),
    );
    if (nouvelleNote != null && context.mounted) {
      context.read<NoteService>().addNote(nouvelleNote);
    }
  }

  Future<void> _ouvrirDetail(Note note) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailNotePage(note: note)),
    );
    if (!context.mounted) return;

    if (result is Note) {
      context.read<NoteService>().updateNote(result);
    } else if (result == 'deleted') {
      context.read<NoteService>().deleteNote(note.id);
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
    // Récupère la liste filtrée selon la recherche
    final noteService = context.watch<NoteService>();
    final notes = _query.isEmpty
        ? noteService.notes
        : noteService.search(_query);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[700],
        foregroundColor: Colors.white,
        title: const Text('Mes Notes'),
        // Compteur dans l'AppBar avec Consumer (ne reconstruit que le badge)
        actions: [
          Consumer<NoteService>(
            builder: (context, service, _) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${service.count} note${service.count > 1 ? 's' : ''}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        // Barre de recherche sous le titre
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Rechercher une note...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _query = '';
                            _searchController.clear();
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _query.isEmpty ? Icons.note_outlined : Icons.search_off,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    _query.isEmpty ? 'Aucune note' : 'Aucun résultat',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    _query.isEmpty
                        ? 'Appuyez sur + pour créer une note'
                        : 'Essayez un autre mot-clé',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
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
                    onTap: () => _ouvrirDetail(note),
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
