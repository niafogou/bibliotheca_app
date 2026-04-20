// lib/views/liste_categorie.dart

import 'package:flutter/material.dart';

class ListeCategorie extends StatelessWidget {
  const ListeCategorie({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des catégories")),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, i) {
          return ListTile(
            leading: const Icon(Icons.category),
            title: Text("Catégorie $i"),
          );
        },
      ),
    );
  }
}
