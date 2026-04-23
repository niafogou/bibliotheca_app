import 'package:bibliotheca_app/api/livre_api_ctl.dart';
import 'package:bibliotheca_app/models/livre.dart';
import 'package:flutter/material.dart';

class ListeLivrePage extends StatefulWidget {
  const ListeLivrePage({Key? key}) : super(key: key);

  @override
  State<ListeLivrePage> createState() => _ListeLivrePageState();
}

class _ListeLivrePageState extends State<ListeLivrePage> {
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
      throw Exception("Erreur chargement livres");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des Livres"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _livres = _fetchLivres();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Page ajout livre
            },
          ),
        ],
      ),

      body: FutureBuilder<List<Livre>>(
        future: _livres,
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
              child: Text("Aucun livre trouvé"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var livre = snapshot.data![index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text("${livre.id}"),
                  ),

                  title: Text(livre.libelle ?? ""),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(livre.description ?? ""),
                      Text("Pages : ${livre.nbPage ?? 0}"),
                    ],
                  ),

                  trailing: const Icon(Icons.arrow_forward_ios),

                  onTap: () {
                    // Page modification livre
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