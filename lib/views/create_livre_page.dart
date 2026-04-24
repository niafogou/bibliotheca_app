import 'package:bibliotheca_app/api/livre_api_ctl.dart';
import 'package:bibliotheca_app/models/livre.dart';
import 'package:flutter/material.dart';

class CreateLivrePage extends StatefulWidget {
  const CreateLivrePage({Key? key}) : super(key: key);

  @override
  _CreateLivrePageState createState() => _CreateLivrePageState();
}

class _CreateLivrePageState extends State<CreateLivrePage> {
  final _formKey = GlobalKey<FormState>();

  final _libelleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nbPagesController = TextEditingController();
  final _imageController = TextEditingController();
  final _categorieIdController = TextEditingController();
  final _auteurIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Créer un Livre"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: SingleChildScrollView(
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
                      return "Veuillez entrer le libellé";
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Description",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer la description";
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: _nbPagesController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Nombre de pages",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer le nombre de pages";
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: _imageController,
                  decoration: const InputDecoration(
                    labelText: "Image URL",
                  ),
                ),

                TextFormField(
                  controller: _categorieIdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "ID Catégorie",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer catégorie";
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: _auteurIdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "ID Auteur",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer auteur";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var livre = Livre(
                        libelle: _libelleController.text,
                        description: _descriptionController.text,
                        nbPage: int.parse(_nbPagesController.text),
                        image: _imageController.text,
                        categorieId:
                            int.parse(_categorieIdController.text),
                        auteurId:
                            int.parse(_auteurIdController.text),
                      );

                      LivreApiCtl.create(livre).then((result) {
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
      ),
    );
  }
}