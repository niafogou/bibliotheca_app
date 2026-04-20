import 'package:bibliotheca_app/views/liste_des_auteurs.dart';
import 'package:bibliotheca_app/views/liste_des_categories.dart';
import 'package:bibliotheca_app/views/liste_des_livres.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Bienvenue sur Bibliotheca")),
    body: GridView.count(
      crossAxisCount: 2,
      children: [
        _HomeMenuButton(
          icon: Icons.book,
          label: "Livres",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ListeLivrePage()),
            );
          },
        ),
        _HomeMenuButton(
          icon: Icons.category,
          label: "Categories",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ListeCategorie()),
            );
          },
        ),
        _HomeMenuButton(
          icon: Icons.person,
          label: "Auteurs",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ListeAuteur()),
            );
          },
        ),
      ],
    ),
  );
}

class _HomeMenuButton extends StatelessWidget {
  const _HomeMenuButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      textColor: Theme.of(context).colorScheme.primary,
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50),
          const SizedBox(height: 20),
          Text(label, style: const TextStyle(fontSize: 17)),
        ],
      ),
    );
  }
}
