import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/api_links.dart';
import 'package:producer_family_app/storage/models/family_modal/get_categories_modal.dart';

import '../../shared_preferences_controller.dart';

class CategoriesFamilyController {
  Future<bool> addCategoriesFamilyController(BuildContext context,
      {required String arname,
      required String enname,
      required int id,
      String language = ""}) async {
    var url = Uri.parse(ApiLinks.addFamilyCategory);

    var response = await http.post(url, body: {
      "arname": arname,
      "enname": enname,
    }, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'accept': 'application/json',
      'Accept-Language': language,
      'X-Requested-With': 'XMLHttpRequest',
      'Accept-country': "2"
    });
    if (response.statusCode < 400) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode == 500) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }

//******************************************************************************

  Future<List<CategoriesModalFamily>> getFamilyCategoriesController(
      {BuildContext? context, bool? isUpdated}) async {
    String fileName = "getFamilyCategoriesController.json";
    var dir = await getTemporaryDirectory();
    File file = File("${dir.path}/$fileName");
    if (isUpdated == true && file.existsSync())
      file.deleteSync(recursive: true);
    if (file.existsSync()) {
      // print("getFamilyCategoriesController Loading from cache");
      var response = file.readAsStringSync();
      var jsonArray = jsonDecode(response)['data'] as List;
      List<CategoriesModalFamily> categories = jsonArray
          .map((jsonObject) => CategoriesModalFamily.fromJson(jsonObject))
          .toList();
      return categories;
    } else {
      // print("getFamilyCategoriesController Loading from net");

      var url = Uri.parse(ApiLinks.getFamilyCategories);

      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
      });

      if (response.statusCode < 400) {
        if (context != null) {
          helper(
              context: context,
              message: jsonDecode(response.body)['message'],
              error: true);
        }
        if (jsonDecode(response.body)['data'][0] != null) {
          var jsonArray = jsonDecode(response.body)['data'] as List;
          List<CategoriesModalFamily> categories = jsonArray
              .map((jsonObject) => CategoriesModalFamily.fromJson(jsonObject))
              .toList();
          file.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);

          return categories;
        }
      } else if (response.statusCode == 500) {
        if (context != null) {
          helper(
              context: context,
              message: jsonDecode(response.body)['message'],
              error: true);
        }
      } else {
        if (context != null) {
          helper(
              context: context,
              message: jsonDecode(response.body)['message'],
              error: true);
        }
      }
      return [];
    }
  }
//******************************************************************************

  Future<bool> updateCategoriesFamilyController(BuildContext context,
      {required String arname,
      required String enname,
      required String categoryId,
      String language = ""}) async {
    var url = Uri.parse(ApiLinks.updateFamilyCategory);

    var response = await http.post(url, body: {
      "arname": arname,
      "enname": enname,
      'category_id': categoryId
    }, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'accept': 'application/json',
      'Accept-Language': language,
      'X-Requested-With': 'XMLHttpRequest',
      'Accept-country': "2"
    });
    if (response.statusCode < 400) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode == 500) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }

  //******************************************************************************

  Future<bool> deleteCategoriesFamilyController(
      {required BuildContext context,
      required String categoryId,
      String language = ""}) async {
    var url = Uri.parse(ApiLinks.deleteFamilyCategory);

    var response = await http.post(url, body: {
      'category_id': categoryId
    }, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'accept': 'application/json',
      'Accept-Language': language,
      'X-Requested-With': 'XMLHttpRequest',
      'Accept-country': "2"
    });
    if (response.statusCode < 400) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode == 500) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }
}
