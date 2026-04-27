// lib/main.dart

import 'package:bibliotheca_app/views/acceuil.dart';
import 'package:flutter/material.dart';
//importer les pages de la liste des auteurs, des livres et des categories
void main() {
  //declarer la fonction main pour lancer l'application et afficher la page d'accueil
  runApp(const BibliothecaApp());
}
//declarer une classe BibliothecaApp qui est un widget stateless pour l'application Bibliotheca
class BibliothecaApp extends StatelessWidget {
  const BibliothecaApp({super.key});
//declarer une methode build pour construire l'interface de l'application Bibliotheca avec un MaterialApp et une page d'accueil
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
