// TODO Implement this library.
import 'package:bibliotheca_app/api/auteur_api_ctl.dart';
import 'package:bibliotheca_app/models/auteur.dart';
import 'package:bibliotheca_app/views/create_auteur_page.dart';
import 'package:bibliotheca_app/views/edit_auteur_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      throw Exception('Failed to load auteurs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Auteurs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateAuteurPage()),
              ).then((value) {
                if (value == true) {
                  setState(() {
                    _auteurs = _fetchAuteurs();
                  });
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
            return Center(child: Text('Error: ${snapshot.error}'));
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
                        setState(() {
                          _auteurs = _fetchAuteurs();
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