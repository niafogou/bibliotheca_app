import 'package:flutter/material.dart';

class ListLivrePage extends StatefulWidget {
  const ListLivrePage({super.key});

  @override
  State<ListLivrePage> createState() => _ListLivrePageState();
}

class _ListLivrePageState extends State<ListLivrePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Liste des livres")),
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {},
    ),
    body: ListView.builder(
      itemCount: 20,
      itemBuilder: (context, i) => ListTile(
        leading: const Icon(Icons.book),
        title: Text("Titre du livre $i"),
        subtitle: Text("description du livre $i ..."),
        onTap: () {},
      ),
    ),
  );
}
