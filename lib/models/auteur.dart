class Auteur {
  int? id;
  String? nom;
  String? prenoms;
  String? email;
  Auteur({this.id, this.nom, this.prenoms, this.email});

  Auteur.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nom = json["nom"];
    prenoms = json["prenoms"];
    email = json["email"];
  }

  static List<Auteur> fromListJson(List data) {
    return data.map((e) => Auteur.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["nom"] = nom;
    map["prenoms"] = prenoms;
    map["email"] = email;
    return map;
  }
}