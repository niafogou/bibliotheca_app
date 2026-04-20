import 'package:flutter/material.dart';

import '../models/auteur.dart';
import '../models/category.dart';
import '../models/livre.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _categories = [
    Category(id: 1, nom: 'Roman'),
    Category(id: 2, nom: 'Science'),
    Category(id: 3, nom: 'Histoire'),
  ];

  static const _livres = [
    Livre(
      id: 1,
      titre: 'Le Petit Prince',
      auteur: Auteur(id: 1, nom: 'Antoine de Saint-Exupery'),
      category: Category(id: 1, nom: 'Roman'),
      anneePublication: 1943,
      description: 'Un conte poetique sur le voyage, l amitie et l enfance.',
    ),
    Livre(
      id: 2,
      titre: 'Une breve histoire du temps',
      auteur: Auteur(id: 2, nom: 'Stephen Hawking'),
      category: Category(id: 2, nom: 'Science'),
      anneePublication: 1988,
      estDisponible: false,
    ),
    Livre(
      id: 3,
      titre: 'Sapiens',
      auteur: Auteur(id: 3, nom: 'Yuval Noah Harari'),
      category: Category(id: 3, nom: 'Histoire'),
      anneePublication: 2011,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bibliotheca'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Categories', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final category in _categories)
                Chip(label: Text(category.nom)),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Livres disponibles',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          for (final livre in _livres) _LivreCard(livre: livre),
        ],
      ),
    );
  }
}

class _LivreCard extends StatelessWidget {
  const _LivreCard({required this.livre});

  final Livre livre;

  @override
  Widget build(BuildContext context) {
    final statusColor = livre.estDisponible ? Colors.green : Colors.red;
    final statusText = livre.estDisponible ? 'Disponible' : 'Indisponible';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: const Icon(Icons.menu_book),
        ),
        title: Text(livre.titre),
        subtitle: Text(
          '${livre.auteur.nom} - ${livre.category.nom} - ${livre.anneePublication}',
        ),
        trailing: Text(
          statusText,
          style: TextStyle(color: statusColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
