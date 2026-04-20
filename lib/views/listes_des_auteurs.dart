import 'package:flutter/material.dart';

class EditionAuteur extends StatelessWidget {
  const EditionAuteur({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Edition d'auteur")),
    body: Form(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(decoration: const InputDecoration(labelText: "Nom")),
          TextFormField(
            decoration: const InputDecoration(labelText: "Prenoms"),
          ),
          TextFormField(decoration: const InputDecoration(labelText: "Email")),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: const Text("Enregistrer")),
        ],
      ),
    ),
  );
}
