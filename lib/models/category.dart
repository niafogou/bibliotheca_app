class Categorie {
  int? id;
  String? libelle;
  String? description;
  String? email;
  Categorie({this.libelle, this.description, this.id});

  Categorie.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    libelle = json["libelle"];
    description = json["description"];
    email = json["email"];
  }

  static List<Categorie> fromListJson(List data) {
    return data.map((e) => Categorie.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["libelle"] = libelle;
    map["description"] = description  ;
    map["email"] = email;
    return map;
  }
}