import 'package:flutter/material.dart';

class EditionCategorie extends StatelessWidget {
  const EditionCategorie({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Edition de categorie")),
    body: Form(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: "Nom de la categorie"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: const Text("Enregistrer")),
        ],
      ),
    ),
  );
}
