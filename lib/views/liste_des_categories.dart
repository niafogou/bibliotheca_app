import 'package:bibliotheca_app/views/edition_categorie.dart';
import 'package:flutter/material.dart';

class ListeCategorie extends StatelessWidget {
  const ListeCategorie({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Liste des categories")),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EditionCategorie()),
        );
      },
      child: const Icon(Icons.add),
    ),
    body: ListView.builder(
      itemCount: 20,
      itemBuilder: (context, i) => ListTile(
        leading: const Icon(Icons.category),
        title: Text("Titre de la categorie $i"),
        onTap: () {},
      ),
    ),
  );
}
