
import 'package:bibliotheca_app/api/auteur_api_ctl.dart';
import 'package:bibliotheca_app/models/auteur.dart';
import 'package:flutter/material.dart';
//declarer une classe CreateAuteurPage qui est un widget stateful pour la page de creation d'un auteur

class CreateAuteurPage extends StatefulWidget {
  const CreateAuteurPage({Key? key}) : super(key: key);
//declarer une methode createState pour creer l'etat de la page de creation d'un auteur
  @override
  _CreateAuteurPageState createState() => _CreateAuteurPageState();
}
//declarer une classe _CreateAuteurPageState qui est un widget state pour la page de creation d'un auteur
class _CreateAuteurPageState extends State<CreateAuteurPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomsController = TextEditingController();
  final _emailController = TextEditingController();
//declarer une methode build pour construire l'interface de la page de creation d'un auteur
  @override
  Widget build(BuildContext context) {
    //retourner un Scaffold avec une AppBar et un Form pour la creation d'un auteur
    return Scaffold(
      //declarer une AppBar avec un titre
      appBar: AppBar(
        title: const Text('Créer un Auteur'),
      ),
      //declarer un Padding pour le formulaire de creation d'un auteur
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          //declarer une colonne pour les champs de saisie et le bouton de creation d'un auteur
          child: Column(
            //declarer une liste de widgets pour les champs de saisie et le bouton de creation d'un auteur
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: 'Nom'),
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
                    return 'Veuillez entrer des prénoms';
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
              //declarer un SizedBox pour espacer les champs de saisie et le bouton de creation d'un auteur
              const SizedBox(height: 20),
              //declarer un ElevatedButton pour le bouton de creation d'un auteur avec une action pour valider le formulaire et appeler l'API de creation d'un auteur
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var auteur = Auteur(
                      nom: _nomController.text,
                      prenom: _prenomsController.text,
                      email: _emailController.text,
                    );
                    //appeler l'API de creation d'un auteur et afficher un message de succes ou d'erreur en fonction du resultat
                    AuteurApiCtl.create(auteur).then((result) {
                      if (result.status) {
                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result.message ?? 'Échec de la création')),
                        );
                      }
                    });
                  }
                },
                child: const Text('Créer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}