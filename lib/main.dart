import 'package:flutter/material.dart';

import 'views/accueil.dart';

void main() {
  runApp(const BibliothecaApp());
}

class BibliothecaApp extends StatelessWidget {
  const BibliothecaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bibliotheca',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
