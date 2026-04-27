
import 'package:bibliotheca_app/api/auteur_api_ctl.dart';
import 'package:bibliotheca_app/models/auteur.dart';
import 'package:flutter/material.dart';
//declarer une classe EditAuteurPage qui est un StatefulWidget pour modifier un auteur existant

class EditAuteurPage extends StatefulWidget {
  //declarer une variable pour stocker l'auteur a modifier
  final Auteur auteur;
  //declarer un constructeur pour initialiser la variable auteur

  const EditAuteurPage({Key? key, required this.auteur}) : super(key: key);
  //declarer une methode createState pour creer l'etat de la page de modification d'un auteur

  @override
  _EditAuteurPageState createState() => _EditAuteurPageState();
}
//declarer une classe _EditAuteurPageState qui est un State pour la page de modification d'un auteur

class _EditAuteurPageState extends State<EditAuteurPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;
  late TextEditingController _prenomsController;
  late TextEditingController _emailController;
//declarer une methode initState pour initialiser les controllers de texte avec les valeurs de l'auteur a modifier
  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.auteur.nom);
    _prenomsController = TextEditingController(text: widget.auteur.prenom);
    _emailController = TextEditingController(text: widget.auteur.email);
  }
//declarer une methode build pour construire l'interface de la page de modification d'un auteur
  @override
  Widget build(BuildContext context) {
    //retourner un Scaffold avec une AppBar et un Form pour la modification d'un auteur
    return Scaffold(
      //declarer une AppBar avec un titre
      appBar: AppBar(
        title: const Text('Modifier un Auteur'),
      ),
      //declarer un Padding pour le formulaire de modification d'un auteur
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          //declarer une colonne pour les champs de saisie et le bouton de modification d'un auteur
          child: Column(
            //declarer une liste de widgets pour les champs de saisie et le bouton de modification d'un auteur
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: 'Nom'),
                //declarer une validation pour le champ de saisie du nom de l'auteur
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              //declarer un TextFormField pour le prenom de l'auteur avec une validation
              TextFormField(
                controller: _prenomsController,
                decoration: const InputDecoration(labelText: 'Prénom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un prénom';
                  }
                  return null;
                },
              ),
              //declarer un TextFormField pour l'email de l'auteur avec une validation
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un email';
                  }
                  return null;
                },
              ),
              //declarer un SizedBox pour espacer les champs de saisie et le bouton de modification d'un auteur
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var auteur = Auteur(
                      id: widget.auteur.id,
                      nom: _nomController.text,
                      prenom: _prenomsController.text,
                      email: _emailController.text,
                    );
                    //appeler l'API de modification d'un auteur et afficher un message de succes ou d'erreur en fonction du resultat
                    AuteurApiCtl.update(auteur).then((result) {
                      if (result.status) {
                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result.message ?? 'Échec de la modification')),
                        );
                      }
                    });
                  }
                },
                child: const Text('Modifier'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}