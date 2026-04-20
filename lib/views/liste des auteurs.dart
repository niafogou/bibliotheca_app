// lib/views/liste_auteur.dart

import 'package:flutter/material.dart';

class ListeAuteur extends StatelessWidget {
  const ListeAuteur({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Liste des auteurs")),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, i) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text("Auteur $i"),
            subtitle: Text("email$i@gmail.com"),
          );
        },
      ),
    );
  }
}
