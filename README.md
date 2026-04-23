# 📒 Application Bloc-Notes

Application mobile de gestion de notes personnelles développée avec Flutter dans le cadre d'un Travail Pratique.

---

## 📋 Description

L'application **Bloc-Notes** permet à l'utilisateur de gérer ses notes personnelles de manière simple et intuitive. Elle offre les fonctionnalités CRUD complètes :

- ✅ **Créer** une note
- 📖 **Lire** les notes
- ✏️ **Modifier** une note
- 🗑️ **Supprimer** une note

---

## 🗂️ Structure d'une note

Chaque note contient les informations suivantes :

| Champ | Type | Description |
|-------|------|-------------|
| **Titre** | String | Titre de la note (max 60 caractères) |
| **Contenu** | String | Corps de la note |
| **Couleur** | String | Code couleur hex (ex: `#FFE082`) |
| **Date** | DateTime | Date et heure de création |

---

## 🖥️ Architecture de l'application

L'application est composée de **4 écrans** interconnectés :

```
Accueil → Créer/Modifier → Détail → Modifier
```

| Écran | Fichier | Rôle |
|-------|---------|------|
| Page Accueil | `home_page.dart` | Liste de toutes les notes |
| Page Création | `create_page.dart` | Formulaire création / modification |
| Page Détail | `detail_page.dart` | Affichage complet d'une note |

---

## 🏗️ Structure du projet

```
lib/
├── main.dart
├── models/
│   └── note.dart
├── services/
│   └── note_service.dart
└── pages/
    ├── home_page.dart
    ├── create_page.dart
    └── detail_page.dart
```

---

## ⚙️ Technologies utilisées

| Technologie | Version | Rôle |
|-------------|---------|------|
| **Flutter** | 3.x | Framework mobile (Frontend) |
| **Dart** | 3.x | Langage de programmation |
| **Provider** | 6.1.2 | Gestion d'état global |

---

## 📚 Concepts Flutter utilisés

### Partie 1 — setState & Navigation
- `StatefulWidget` et `setState()`
- Navigation avec `Navigator.push()` et `Navigator.pop()`
- Passage de données entre pages
- Formulaires avec `TextEditingController`
- Validation des saisies utilisateur

### Partie 2 — Provider & État Global
- `ChangeNotifier` et `notifyListeners()`
- `ChangeNotifierProvider` dans `main.dart`
- `Consumer<T>`, `context.read<T>()`, `context.watch<T>()`
- Séparation logique métier / interface
- Recherche et filtrage des notes en temps réel
- Tri des notes (date, titre)

---

## 🔃 Fonctionnalité Tri des notes

L'application propose un système de tri configurable accessible depuis un bouton dans l'AppBar. L'utilisateur peut trier ses notes selon 4 options :

| Option | Comportement |
|--------|-------------|
| 📅 **Date — récent d'abord** | Tri par défaut — dernière note créée en haut |
| 🕰️ **Date — ancien d'abord** | Les plus vieilles notes apparaissent en premier |
| 🔤 **Titre A → Z** | Tri alphabétique croissant sur le titre |
| 🔤 **Titre Z → A** | Tri alphabétique décroissant sur le titre |

### Comment ça fonctionne techniquement

```dart
// Enum des options de tri
enum TriNotes {
  dateRecent,   // Par défaut
  dateAncien,
  titreAZ,
  titreZA,
}
```

- Le tri est géré directement dans le `NoteService` via un `enum TriNotes`
- La méthode `changerTri()` met à jour le tri et appelle `notifyListeners()` pour reconstruire automatiquement la liste
- Un **bandeau indicateur** sous l'AppBar affiche en permanence le tri actif
- Le tri et la **recherche fonctionnent ensemble** sans conflit
- L'interface de sélection s'affiche dans un `BottomSheet` avec une coche ✅ sur l'option active

---

## 🚀 Lancer le projet

### Prérequis
- Flutter SDK installé
- Un émulateur Android / iOS ou un navigateur Chrome

### Installation

```bash
# Cloner le projet
git clone <url_du_projet>
cd bloc_notes

# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run -d chrome      # Sur Chrome
flutter run -d android     # Sur Android
flutter run                # Choisir l'appareil
```

---

## 👥 Membres du groupe

| Matricule |
|-----------|
| 24107 |
| 24110 |
| 24119 |
| 24120 |

---

## 🎓 Informations pédagogiques

- **Matière** : Développement Mobile
- **Type** : Travaux Pratiques (TP)
- **Sujet** : Application Bloc-Notes — setState & Navigation · Provider & Gestion d'État