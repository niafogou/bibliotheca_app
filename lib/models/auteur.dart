class Auteur {
  int? id;
  String? nom;
  String? prenom;
  String? email;
  Auteur({this.id, this.nom, this.prenom, this.email});

  Auteur.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nom = json["nom"];
    prenom = json["prenom"];
    email = json["email"];
  }

  static List<Auteur> fromListJson(List data) {
    return data.map((e) => Auteur.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["nom"] = nom;
    map["prenom"] = prenom;
    map["email"] = email;
    return map;
  }
}