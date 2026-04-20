// lib/views/liste_livre.dart

import 'package:flutter/material.dart';
import 'edition_livre.dart';

class ListeLivrePage extends StatelessWidget {
  const ListeLivrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des livres")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditionLivre()),
          );
        },
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, i) {
          return ListTile(
            leading: const Icon(Icons.book),
            title: Text("Titre du livre $i"),
            subtitle: Text("Description du livre $i"),
          );
        },
      ),
    );
  }
}
