class Categorie {
  int? id;
  String? libelle;
  Categorie({this.libelle, this.id});

  Categorie.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    libelle = json["libelle"];
  }

  static List<Categorie> fromListJson(List data) {
    return data.map((e) => Categorie.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["libelle"] = libelle;
    return map;
  }
}