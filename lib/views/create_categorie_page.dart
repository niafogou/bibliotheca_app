import 'package:bibliotheca_app/api/categorie_api_ctl.dart';
import 'package:bibliotheca_app/models/category.dart';
import 'package:flutter/material.dart';

class CreateCategoriePage extends StatefulWidget {
  const CreateCategoriePage({Key? key}) : super(key: key);

  @override
  _CreateCategoriePageState createState() => _CreateCategoriePageState();
}

class _CreateCategoriePageState extends State<CreateCategoriePage> {
  final _formKey = GlobalKey<FormState>();
  final _libelleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Créer une Catégorie"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              TextFormField(
                controller: _libelleController,
                decoration: const InputDecoration(
                  labelText: "Libellé",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer un libellé";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var categorie = Categorie(
                      libelle: _libelleController.text,
                    );

                    CategorieApiCtl.create(categorie).then((result) {
                      if (result.status) {
                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              result.message ??
                                  "Échec de la création",
                            ),
                          ),
                        );
                      }
                    });
                  }
                },
                child: const Text("Créer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}