
import 'package:bibliotheca_app/api/auteur_api_ctl.dart';
import 'package:bibliotheca_app/models/auteur.dart';
import 'package:flutter/material.dart';

class CreateAuteurPage extends StatefulWidget {
  const CreateAuteurPage({Key? key}) : super(key: key);

  @override
  _CreateAuteurPageState createState() => _CreateAuteurPageState();
}

class _CreateAuteurPageState extends State<CreateAuteurPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomsController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un Auteur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var auteur = Auteur(
                      nom: _nomController.text,
                      prenom: _prenomsController.text,
                      email: _emailController.text,
                    );
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