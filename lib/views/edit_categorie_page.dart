
import 'package:bibliotheca_app/api/categorie_api_ctl.dart';
import 'package:bibliotheca_app/models/category.dart';
import 'package:flutter/material.dart';

class EditCategoriePage extends StatefulWidget {
  final Categorie categorie;

  const EditCategoriePage({Key? key, required this.categorie}) : super(key: key);

  @override
  _EditCategoriePageState createState() => _EditCategoriePageState();
}

class _EditCategoriePageState extends State<EditCategoriePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _libelleController;


  @override
  void initState() {
    super.initState();
    _libelleController = TextEditingController(text: widget.categorie.libelle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier une Catégorie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _libelleController,
                decoration: const InputDecoration(labelText: 'Libellé'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un libellé';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var categorie = Categorie(
                      id: widget.categorie.id,
                      libelle: _libelleController.text,
                    );
                    CategorieApiCtl.update(categorie).then((result) {
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