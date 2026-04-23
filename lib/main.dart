// lib/main.dart

import 'package:bibliotheca_app/views/acceuil.dart';
import 'package:flutter/material.dart';
import 'views/home_page.dart' hide HomePage;

void main() {
  runApp(const BibliothecaApp());
}

class BibliothecaApp extends StatelessWidget {
  const BibliothecaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bibliotheca",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}
