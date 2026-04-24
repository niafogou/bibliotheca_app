import 'package:bibliotheca_app/api/livre_api_ctl.dart';
import 'package:bibliotheca_app/models/livre.dart';
import 'package:flutter/material.dart';

class EditLivrePage extends StatefulWidget {
  final Livre livre;

  const EditLivrePage({
    Key? key,
    required this.livre,
  }) : super(key: key);

  @override
  _EditLivrePageState createState() => _EditLivrePageState();
}

class _EditLivrePageState extends State<EditLivrePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _libelleController;
  late TextEditingController _descriptionController;
  late TextEditingController _nbPagesController;
  late TextEditingController _imageController;
  late TextEditingController _categorieIdController;
  late TextEditingController _auteurIdController;

  @override
  void initState() {
    super.initState();

    _libelleController =
        TextEditingController(text: widget.livre.libelle);

    _descriptionController =
        TextEditingController(text: widget.livre.description);

    _nbPagesController =
        TextEditingController(
          text: widget.livre.nbPage.toString(),
        );

    _imageController =
        TextEditingController(text: widget.livre.image);

    _categorieIdController =
        TextEditingController(
          text: widget.livre.categorieId.toString(),
        );

    _auteurIdController =
        TextEditingController(
          text: widget.livre.auteurId.toString(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier un Livre"),
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
                      return "Veuillez entrer un libellé";
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
                      return "Veuillez entrer une description";
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
                        id: widget.livre.id,
                        libelle: _libelleController.text,
                        description: _descriptionController.text,
                        nbPage:
                            int.parse(_nbPagesController.text),
                        image: _imageController.text,
                        categorieId:
                            int.parse(
                              _categorieIdController.text,
                            ),
                        auteurId:
                            int.parse(
                              _auteurIdController.text,
                            ),
                      );

                      LivreApiCtl.update(livre).then((result) {
                        if (result.status) {
                          Navigator.pop(context, true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                result.message ??
                                    "Échec de la modification",
                              ),
                            ),
                          );
                        }
                      });
                    }
                  },
                  child: const Text("Modifier"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}