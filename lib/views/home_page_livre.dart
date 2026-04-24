import 'package:bibliotheca_app/api/livre_api_ctl.dart';
import 'package:bibliotheca_app/models/livre.dart';
import 'package:bibliotheca_app/views/create_livre_page.dart';
import 'package:bibliotheca_app/views/edit_livre_page.dart';
import 'package:flutter/material.dart';

class HomePageLivre extends StatefulWidget {
  const HomePageLivre({Key? key}) : super(key: key);

  @override
  State<HomePageLivre> createState() => _HomePageLivreState();
}

class _HomePageLivreState extends State<HomePageLivre> {
  late Future<List<Livre>> _livres;

  @override
  void initState() {
    super.initState();
    _livres = _fetchLivres();
  }

  Future<List<Livre>> _fetchLivres() async {
    var result = await LivreApiCtl.getAll();

    if (result.status) {
      return result.data ?? [];
    } else {
      throw Exception("Failed to load livres");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des Livres"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const CreateLivrePage(),
                ),
              ).then((value) {
                if (value == true) {
                  setState(() {
                    _livres = _fetchLivres();
                  });
                }
              });
            },
          ),
        ],
      ),

      body: FutureBuilder<List<Livre>>(
        future: _livres,

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No livres found"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,

            itemBuilder: (context, index) {
              var livre = snapshot.data![index];

              return ListTile(
                title: Text(
                  livre.libelle ?? "",
                ),

                subtitle: Text(
                  livre.description ?? "",
                ),

                trailing: Text(
                  "${livre.nbPage ?? 0} p",
                ),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditLivrePage(
                        livre: livre,
                      ),
                    ),
                  ).then((value) {
                    if (value == true) {
                      setState(() {
                        _livres =
                            _fetchLivres();
                      });
                    }
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}