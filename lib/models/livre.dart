import 'package:bibliotheca_app/models/category.dart';

import 'auteur.dart';


class Livre {
  int? id;
  String? libelle;
  String? description;
  int? nbPage;
  String? image;
  int? categorieId;
  int? auteurId;
  Categorie? categorie;
  Auteur? auteur;

  Livre({
    this.id,
    this.libelle,
    this.description,
    this.nbPage,
    this.image,
    this.categorieId,
    this.auteurId,
    this.categorie,
    this.auteur,
  });

  Livre.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    libelle = json["libelle"];
    description = json["description"];
    nbPage = json["nb_page"];
    image = json["image"];

    categorieId = json["categorie_id"];
    auteurId = json["auteur_id"];

    categorie = json["categorie"] != null
        ? Categorie.fromJson(json["categorie"])
        : null;

    auteur = json["auteur"] != null
        ? Auteur.fromJson(json["auteur"])
        : null;
  }

  static List<Livre> fromListJson(List data) {
    return data.map((e) => Livre.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "libelle": libelle,
      "description": description,
      "nb_page": nbPage,
      "image": image,
      "categorie_id": categorieId,
      "auteur_id": auteurId,
    };
  }
}