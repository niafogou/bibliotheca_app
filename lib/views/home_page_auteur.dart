// TODO Implement this library.
import 'package:bibliotheca_app/api/auteur_api_ctl.dart';
import 'package:bibliotheca_app/models/auteur.dart';
import 'package:bibliotheca_app/views/create_auteur_page.dart';
import 'package:bibliotheca_app/views/edit_auteur_page.dart';
import 'package:flutter/material.dart';
//declarer une classe HomePageAuteur qui etend StatefulWidget pour afficher la liste des auteurs et permettre la creation et la modification d'un auteur
class HomePageAuteur extends StatefulWidget {
  //declarer un constructeur pour la classe HomePageAuteur
  const HomePageAuteur({Key? key}) : super(key: key);
//declarer une methode createState pour creer l'etat de la page d'accueil des auteurs
  @override
  _HomePageAuteurState createState() => _HomePageAuteurState();
}
//declarer une classe _HomePageAuteurState qui etend State pour la page d'accueil des auteurs
class _HomePageAuteurState extends State<HomePageAuteur> {
  late Future<List<Auteur>> _auteurs;
  //declarer une methode initState pour initialiser la liste des auteurs en appelant l'API de recuperation de tous les auteurs

  @override
  void initState() {
    super.initState();
    _auteurs = _fetchAuteurs();
  }
//declarer une methode _fetchAuteurs pour recuperer la liste des auteurs en appelant l'API de recuperation de tous les auteurs et retourner une liste d'auteurs ou une exception en cas d'erreur
  Future<List<Auteur>> _fetchAuteurs() async {
    var result = await AuteurApiCtl.getAll();
    if (result.status) {
      return result.data ?? [];
    } else {
      throw Exception('Failed to load auteurs');
    }
  }
//declarer une methode _reloadAuteurs pour recharger la liste des auteurs en appelant la methode _fetchAuteurs et en mettant a jour l'etat de la page d'accueil des auteurs
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Auteurs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateAuteurPage()),
              ).then((value) {
                if (value == true) {
                  setState(() {
                    _auteurs = _fetchAuteurs();
                  });
                }
              });
            },
          ),
        ],
      ),
      //declarer un FutureBuilder pour afficher la liste des auteurs en fonction de l'etat de la connexion et des donnees recues de l'API de recuperation de tous les auteurs
      body: FutureBuilder<List<Auteur>>(
        future: _auteurs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No authors found'));
          } else {
            //declarer un ListView.builder pour afficher la liste des auteurs avec un ListTile pour chaque auteur et une action de modification d'un auteur en cliquant sur le ListTile
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var auteur = snapshot.data![index];
                //declarer un ListTile pour afficher le nom et le prenom de l'auteur avec une action de modification d'un auteur en cliquant sur le ListTile
                return ListTile(
                  title: Text('${auteur.nom} ${auteur.prenom}'),
                  subtitle: Text(auteur.email ?? ''),
                  //declarer une action de modification d'un auteur en cliquant sur le ListTile pour naviguer vers la page de modification d'un auteur avec les informations de l'auteur a modifier et recharger la liste des auteurs apres la modification
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAuteurPage(auteur: auteur),
                      ),
                    ).then((value) {
                      if (value == true) {
                        setState(() {
                          _auteurs = _fetchAuteurs();
                        });
                      }
                    });
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}