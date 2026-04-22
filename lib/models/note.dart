class Note {
  final String id;
  String titre;
  String contenu;
  String couleur;
  final DateTime dateCreation;
  DateTime? dateModification;

  Note({
    required this.id,
    required this.titre,
    required this.contenu,
    required this.couleur,
    required this.dateCreation,
    this.dateModification,
  });
}
