
import 'package:bibliotheca_app/api/auteur_api_ctl.dart';
import 'package:bibliotheca_app/models/auteur.dart';
import 'package:flutter/material.dart';

class EditAuteurPage extends StatefulWidget {
  final Auteur auteur;

  const EditAuteurPage({Key? key, required this.auteur}) : super(key: key);

  @override
  _EditAuteurPageState createState() => _EditAuteurPageState();
}

class _EditAuteurPageState extends State<EditAuteurPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;
  late TextEditingController _prenomsController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.auteur.nom);
    _prenomsController = TextEditingController(text: widget.auteur.prenoms);
    _emailController = TextEditingController(text: widget.auteur.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier un Auteur'),
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
                decoration: const InputDecoration(labelText: 'Prénoms'),
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
                      id: widget.auteur.id,
                      nom: _nomController.text,
                      prenoms: _prenomsController.text,
                      email: _emailController.text,
                    );
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