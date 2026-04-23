
import 'package:bibliotheca_app/api/categorie_api_ctl.dart';
import 'package:bibliotheca_app/models/category.dart';
import 'package:flutter/material.dart';

class ListeCategoriePage extends StatefulWidget {
  const ListeCategoriePage({Key? key}) : super(key: key);

  @override
  State<ListeCategoriePage> createState() => _ListeCategoriePageState();
}

class _ListeCategoriePageState extends State<ListeCategoriePage> {
  late Future<List<Categorie>> _categories;

  @override
  void initState() {
    super.initState();
    _categories = _fetchCategories();
  }

  Future<List<Categorie>> _fetchCategories() async {
    var result = await CategorieApiCtl.getAll();

    if (result.status) {
      return result.data ?? [];
    } else {
      throw Exception("Erreur chargement catégories");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des Catégories"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _categories = _fetchCategories();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Page création catégorie
            },
          ),
        ],
      ),

      body: FutureBuilder<List<Categorie>>(
        future: _categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Erreur : ${snapshot.error}"),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Aucune catégorie trouvée"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var categorie = snapshot.data![index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text("${categorie.id}"),
                  ),
                  title: Text(categorie.libelle ?? ""),
                  subtitle: Text(
                    "ID : ${categorie.id}",
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Page modification catégorie
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}