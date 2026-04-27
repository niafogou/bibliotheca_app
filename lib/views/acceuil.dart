import 'package:bibliotheca_app/views/liste_des_categories.dart';
import 'package:bibliotheca_app/views/liste_des_livres.dart';
import 'package:bibliotheca_app/views/liste_des_auteurs.dart';

import 'package:flutter/material.dart';
//importer les pages de liste des livres, des categories et des auteurs
class HomePage extends StatelessWidget {
  //declarer une classe HomePage qui est un widget stateless
  const HomePage({super.key});
//declarer une methode build pour construire l'interface de la page d'accueil
  @override
  Widget build(BuildContext context) {
    //retourner un Scaffold avec une AppBar et un GridView pour les boutons de navigation
    return Scaffold(
      //declarer une AppBar avec un titre et une elevation
      appBar: AppBar(
        title: const Text("Bienvenue sur Bibliotheca"),
        centerTitle: true,
        elevation: 2,
      ),
      //declarer un GridView avec 3 boutons pour naviguer vers les pages de liste 
      //des livres, des categories et des auteurs
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          //declarer une liste de boutons pour naviguer vers les pages de liste
          // des livres, des categories et des auteurs
          children: [
            _HomeMenuButton(
              icon: Icons.book,
              label: "Livres",
              onPressed: () {
                //naviguer vers la page de liste des livres
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ListeLivrePage()),
                );
              },
            ),
            //naviguer vers la page de liste des categories
            _HomeMenuButton(
              icon: Icons.category,
              label: "Catégories",
              onPressed: () {
                //naviguer vers la page de liste des categories
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ListeCategoriePage()),
                );
              },
            ),
            //naviguer vers la page de liste des auteurs
            _HomeMenuButton(
              icon: Icons.person,
              label: "Auteurs",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ListeAuteurPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
//declarer une classe _HomeMenuButton qui est un widget stateless pour les boutons de navigation

class _HomeMenuButton extends StatelessWidget {
  const _HomeMenuButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
//declarer les proprietes de la classe _HomeMenuButton
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  //declarer une methode build pour construire l'interface du bouton de navigation
@override
  Widget build(BuildContext context) {
    //retourner un Card avec une InkWell pour le bouton de navigation
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onPressed,
        //declarer une colonne pour afficher l'icone et le label du bouton de navigation
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //declarer une liste de widgets pour afficher l'icone et le label du bouton de navigation
          children: [
            Icon(icon, size: 55, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            //declarer un Text pour afficher le label du bouton de navigation
            Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
