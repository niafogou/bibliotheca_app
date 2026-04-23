import 'package:bibliotheca_app/api/auteur_api_ctl.dart';
import 'package:bibliotheca_app/models/auteur.dart';
import 'package:bibliotheca_app/views/create_auteur_page.dart';
import 'package:bibliotheca_app/views/edit_auteur_page.dart';
import 'package:flutter/material.dart';

class ListeAuteurPage extends StatefulWidget {
  const ListeAuteurPage({Key? key}) : super(key: key);

  @override
  _ListeAuteurPageState createState() => _ListeAuteurPageState();
}

class _ListeAuteurPageState extends State<ListeAuteurPage > {
  late Future<List<Auteur>> _auteurs;

  @override
  void initState() {
    super.initState();
    _auteurs = _fetchAuteurs();
  }

  Future<List<Auteur>> _fetchAuteurs() async {
    var result = await AuteurApiCtl.getAll();
    if (result.status) {
      return result.data ?? [];
    } else {
      throw Exception(result.message ?? 'Failed to load auteurs');
    }
  }

  void _reloadAuteurs() {
    setState(() {
      _auteurs = _fetchAuteurs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Auteurs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reloadAuteurs,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateAuteurPage(),
                ),
              ).then((value) {
                if (value == true) {
                  _reloadAuteurs();
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Auteur>>(
        future: _auteurs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${snapshot.error}', textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _reloadAuteurs,
                      child: const Text('Reessayer'),
                    ),
                  ],
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No authors found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var auteur = snapshot.data![index];
                return ListTile(
                  title: Text('${auteur.nom} ${auteur.prenoms}'),
                  subtitle: Text(auteur.email ?? ''),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAuteurPage(auteur: auteur),
                      ),
                    ).then((value) {
                      if (value == true) {
                        _reloadAuteurs();
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
