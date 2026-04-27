import 'package:bibliotheca_app/api/auteur_api_ctl.dart';
import 'package:bibliotheca_app/models/auteur.dart';
import 'package:bibliotheca_app/views/create_auteur_page.dart';
import 'package:bibliotheca_app/views/edit_auteur_page.dart';
import 'package:flutter/material.dart';
//declarer une classe ListeAuteurPage qui est un StatefulWidget pour afficher la liste des auteurs et permettre la creation et la modification d'un auteur
class ListeAuteurPage extends StatefulWidget {
  //declarer un constructeur pour la classe ListeAuteurPage
  const ListeAuteurPage({Key? key}) : super(key: key);
//declarer une methode createState pour creer l'etat de la page de liste des auteurs
  @override
  _ListeAuteurPageState createState() => _ListeAuteurPageState();
}
//declarer une classe _ListeAuteurPageState qui etend State pour la page de liste des auteurs
class _ListeAuteurPageState extends State<ListeAuteurPage > {
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
      throw Exception(result.message ?? 'Failed to load auteurs');
    }
  }
//declarer une methode _reloadAuteurs pour recharger la liste des auteurs en appelant la methode _fetchAuteurs et en mettant a jour l'etat de la page de liste des auteurs
  void _reloadAuteurs() {
    setState(() {
      _auteurs = _fetchAuteurs();
    });
  }
//declarer une methode build pour construire l'interface de la page de liste des auteurs avec une AppBar pour le titre et les actions de rafraichissement et de creation d'un auteur, et un FutureBuilder pour afficher la liste des auteurs en fonction de l'etat de la connexion et des donnees recues de l'API de recuperation de tous les auteurs
  @override
  Widget build(BuildContext context) {
    //retourner un Scaffold avec une AppBar et un FutureBuilder pour la liste des auteurs
    return Scaffold(
      //declarer une AppBar avec un titre et des actions de rafraichissement et de creation d'un auteur
      appBar: AppBar(
        title: const Text('Liste des Auteurs'),
        //declarer des actions de rafraichissement et de creation d'un auteur dans l'AppBar pour recharger la liste des auteurs et naviguer vers la page de creation d'un auteur
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reloadAuteurs,
          ),
          //declarer une action de creation d'un auteur en cliquant sur l'icône d'ajout pour naviguer vers la page de creation d'un auteur et recharger la liste des auteurs apres la creation
          IconButton(
            icon: const Icon(Icons.add),
            //declarer une action de creation d'un auteur en cliquant sur l'icône d'ajout pour naviguer vers la page de creation d'un auteur et recharger la liste des auteurs apres la creation
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateAuteurPage(),
                ),
              ).then((value) {
                if (value == true) {
                  _reloadAuteurs();
                }
              });
            },
          ),
        ],
      ),
      //declarer un FutureBuilder pour afficher la liste des auteurs en fonction de l'etat de la connexion et des donnees recues de l'API de recuperation de tous les auteurs
      body: FutureBuilder<List<Auteur>>(
        //declarer une future pour le FutureBuilder qui est la liste des auteurs recuperee de l'API de recuperation de tous les auteurs
        future: _auteurs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              //declarer un Padding pour afficher le message d'erreur et un bouton de reessayer en cas d'erreur de chargement des auteurs
              child: Padding(
                padding: const EdgeInsets.all(24),
                //declarer une Column pour afficher le message d'erreur et un bouton de reessayer en cas d'erreur de chargement des auteurs
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  //declarer un Text pour afficher le message d'erreur de chargement des auteurs
                  children: [
                    Text('${snapshot.error}', textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    //declarer un ElevatedButton pour afficher un bouton de reessayer en cas d'erreur de chargement des auteurs et appeler la methode _reloadAuteurs pour recharger la liste des auteurs
                    ElevatedButton(
                      onPressed: _reloadAuteurs,
                      child: const Text('Reessayer'),
                    ),
                  ],
                ),
              ),
            );
            //declarer un message d'erreur pour afficher le message d'erreur de chargement des auteurs
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAuteurPage(auteur: auteur),
                      ),
                    ).then((value) {
                      if (value == true) {
                        _reloadAuteurs();
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
