import 'dart:convert';
import 'package:bibliotheca_app/configuration/api_const.dart';
import 'package:bibliotheca_app/models/auteur.dart';
import 'package:bibliotheca_app/tools/api_data.dart';
import 'package:http/http.dart' as http;

abstract class AuteurApiCtl {
  static const _module = "auteur";

  static Future<ApiData<List<Auteur>>> getAll() async {
    try {
      var res = await http.get(
        ApiConst.baseUrl(module: _module),
        headers: ApiConst.header,
      );
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        return ApiData.success(data: Auteur.fromListJson(body));
      } else {
        return ApiData.error(message: res.reasonPhrase);
      }
    } catch (e) {
      return ApiData.error();
    }
  }

  static Future<ApiData<Auteur>> create(Auteur auteur) async {
    try {
      var res = await http.post(
        ApiConst.baseUrl(module: _module, path: "create"),
        headers: ApiConst.header,
        body: jsonEncode(auteur.toJson()),
      );
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        return ApiData.success(data: Auteur.fromJson(body));
      } else {
        return ApiData.error();
      }
    } catch (e) {
      return ApiData.error();
    }
  }

  static Future<ApiData<Auteur>> update(Auteur auteur) async {
    try {
      var res = await http.post(
        ApiConst.baseUrl(module: _module, path: "update"),
        headers: ApiConst.header,
        body: jsonEncode(auteur.toJson()),
      );
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        return ApiData.success(data: Auteur.fromJson(body));
      } else {
        return ApiData.error();
      }
    } catch (e) {
      return ApiData.error();
    }
  }

  static Future<ApiData<bool>> delete(int id) async {
    try {
      var res = await http.post(
        ApiConst.baseUrl(module: _module, path: "delete/$id"),
        headers: ApiConst.header,
      );
      if (res.statusCode == 200) {
        return ApiData.success(data: true);
      } else {
        return ApiData.error();
      }
    } catch (e) {
      return ApiData.error();
    }
  }
}