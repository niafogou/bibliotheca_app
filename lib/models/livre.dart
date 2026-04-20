import 'auteur.dart';
import 'category.dart';

class Livre {
  const Livre({
    required this.id,
    required this.titre,
    required this.auteur,
    required this.category,
    required this.anneePublication,
    this.description,
    this.estDisponible = true,
  });

  final int id;
  final String titre;
  final Auteur auteur;
  final Category category;
  final int anneePublication;
  final String? description;
  final bool estDisponible;
}
