import 'package:bibliotheca_app/api/categorie_api_ctl.dart';
import 'package:bibliotheca_app/models/category.dart';
import 'package:bibliotheca_app/views/create_categorie_page.dart';
import 'package:bibliotheca_app/views/edit_categorie_page.dart';
import 'package:flutter/material.dart';

class HomePageCategorie extends StatefulWidget {
  const HomePageCategorie({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageCategorieState createState() => _HomePageCategorieState();
}

class _HomePageCategorieState extends State<HomePageCategorie> {
  late Future<List<Categorie>> _categories;

  @override
  void initState() {
    super.initState();
    _categories = _fetchCategorie();
  }

  Future<List<Categorie>> _fetchCategorie() async {
    var result = await CategorieApiCtl.getAll();
    if (result.status) {
      return result.data ?? [];
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Catégories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateCategoriePage()),
              ).then((value) {
                if (value == true) {
                  setState(() {
                    _categories = _fetchCategorie();
                  });
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Categorie>>(
        future: _categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var categorie = snapshot.data![index];
                return ListTile(
                  title: Text('${categorie.libelle}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditCategoriePage(categorie: categorie),
                      ),
                    ).then((value) {
                      if (value == true) {
                        setState(() {
                          _categories = _fetchCategorie();
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