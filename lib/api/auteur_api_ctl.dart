import 'dart:convert';
import 'package:bibliotheca_app/configuration/api_const.dart';
import 'package:bibliotheca_app/models/auteur.dart';
import 'package:bibliotheca_app/tools/api_data.dart';
import 'package:http/http.dart' as http;
//declarer une classe abstraite pour le controleur de l'api de auteurs
abstract class AuteurApiCtl {
  //declarer une constante pour le module des auteurs
  static const _module = "auteur";
  //declarer une methode statique pour recuperer tous les auteurs
  static Future<ApiData<List<Auteur>>> getAll() async {
    //faire un appel get a l'api pour recuperer tous les auteurs
    try {
      var res = await http.get(
        ApiConst.baseUrl(module: _module),
        headers: ApiConst.header,
      );
      //si la reponse est 200, decoder le corps de la reponse 
      //et retourner une instance de ApiData avec les auteurs
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        return ApiData.success(data: Auteur.fromListJson(body));
      } else {
        return ApiData.error(message: res.reasonPhrase);
      }
      //si la reponse n'est pas 200, retourner une instance de ApiData 
      //avec un message d'erreur
    } catch (e) {
      return ApiData.error();
    }
  }
//declarer une methode statique pour creer un auteur
  static Future<ApiData<Auteur>> create(Auteur auteur) async {
    //faire un appel post a l'api pour creer un auteur
    try {
      var res = await http.post(
        ApiConst.baseUrl(module: _module, path: "create"),
        headers: ApiConst.header,
        body: jsonEncode(auteur.toJson()),
      );
      //si la reponse est 201, decoder le corps de la reponse 
      //et retourner une instance de ApiData avec l'auteur cree
      if (res.statusCode == 201) {
        var body = jsonDecode(res.body);
        return ApiData.success(data: Auteur.fromJson(body));
      } else {
        //si la reponse n'est pas 201, retourner une instance de ApiData 
        //avec un message d'erreur
        return ApiData.error();
        //si une exception est levee, retourner une instance de ApiData 
        //avec un message d'erreur
      }
      //si une exception est levee, retourner une instance de ApiData 
      //avec un message d'erreur
    } catch (e) {
      return ApiData.error();
    }
  }
  //declarer une methode statique pour mettre a jour un auteur

  static Future<ApiData<Auteur>> update(Auteur auteur) async {
     //faire un appel post a l'api pour mettre a jour un auteur
    try {
      var res = await http.post(
        ApiConst.baseUrl(module: _module, path: "update"),
        headers: ApiConst.header,
        body: jsonEncode(auteur.toJson()),
      );
      //si la reponse est 200, decoder le corps de la reponse 
      //et retourner une instance de ApiData avec l'auteur mis a jour
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        return ApiData.success(data: Auteur.fromJson(body));
      } else {
        //si la reponse n'est pas 200, retourner une instance de ApiData 
        //avec un message d'erreur
        return ApiData.error();
      }
      //si une exception est levee, retourner une instance de ApiData 
      //avec un message d'erreur
    } catch (e) {
      return ApiData.error();
    }
  }
//declarer une methode statique pour supprimer un auteur
  static Future<ApiData<bool>> delete(int id) async {
      //faire un appel post a l'api pour supprimer un auteur
    try {
      var res = await http.post(
        ApiConst.baseUrl(module: _module, path: "delete/$id"),
        headers: ApiConst.header,
      );
      //si la reponse est 200, retourner une instance de ApiData avec true
      if (res.statusCode == 200) {
        return ApiData.success(data: true);
      } else {
        //si la reponse n'est pas 200, retourner une instance de ApiData 
        //avec un message d'erreur
        return ApiData.error();
      }
      //si une exception est levee, retourner une instance de ApiData 
      //avec un message d'erreur
    } catch (e) {
      return ApiData.error();
    }
  }
}