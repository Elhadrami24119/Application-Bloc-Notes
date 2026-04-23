import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/note_service.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const BlocNotesApp());
}

class BlocNotesApp extends StatelessWidget {
  const BlocNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteService(),
      child: MaterialApp(
        title: 'Bloc-Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
