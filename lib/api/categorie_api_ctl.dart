import 'dart:convert';
import 'package:bibliotheca_app/configuration/api_const.dart';
import 'package:bibliotheca_app/models/category.dart';
import 'package:bibliotheca_app/tools/api_data.dart';
import 'package:http/http.dart' as http;

abstract class CategorieApiCtl {
  static const _module = "categorie";

  static Future<ApiData<List<Categorie>>> getAll() async {
    try {
      var res = await http.get(
        ApiConst.baseUrl(module: _module),
        headers: ApiConst.header,
      );
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        return ApiData.success(data: Categorie.fromListJson(body));
      } else {
        return ApiData.error(message: res.reasonPhrase);
      }
    } catch (e) {
      return ApiData.error();
    }
  }

  static Future<ApiData<Categorie>> create(Categorie categorie) async {
    try {
      var res = await http.post(
        ApiConst.baseUrl(module: _module, path: "create"),
        headers: ApiConst.header,
        body: jsonEncode(categorie.toJson()),
      );
      if (res.statusCode == 201) {
        var body = jsonDecode(res.body);
        return ApiData.success(data: Categorie.fromJson(body));
      } else {
        return ApiData.error();
      }
    } catch (e) {
      return ApiData.error();
    }
  }

  static Future<ApiData<Categorie>> update(Categorie categorie) async {
    try {
      var res = await http.post(
        ApiConst.baseUrl(module: _module, path: "update"),
        headers: ApiConst.header,
        body: jsonEncode(categorie.toJson()),
      );
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        return ApiData.success(data: Categorie.fromJson(body));
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