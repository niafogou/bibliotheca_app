//model pour les auteurs
class Auteur {
  int? id;
  String? nom;
  String? prenom;
  String? email;
  Auteur({this.id, this.nom, this.prenom, this.email});

 // declarer un constructeur pour initialiser les champs de la classe Auteur
  Auteur.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nom = json["nom"];
    prenom = json["prenom"];
    email = json["email"];
  }
//declarer une methode statique pour convertir une liste de json en une liste d'auteurs
  static List<Auteur> fromListJson(List data) {
    return data.map((e) => Auteur.fromJson(e)).toList();
  }
//declarer une methode pour convertir une instance de Auteur en json
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["nom"] = nom;
    map["prenom"] = prenom;
    map["email"] = email;
    return map;
  }
}