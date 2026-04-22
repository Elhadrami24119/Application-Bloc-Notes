import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const BlocNotesApp());
}

class BlocNotesApp extends StatelessWidget {
  const BlocNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc-Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
