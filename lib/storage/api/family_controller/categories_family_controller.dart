import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/api_links.dart';
import 'package:producer_family_app/storage/models/family_modal/get_categories_modal.dart';
import '../../shared_preferences_controller.dart';

class CategoriesFamilyController {


  Future<bool> addCategoriesFamilyController(BuildContext context,
      {required String arname, required String enname,required int id,
      String language =""}) async {
    var url = Uri.parse(ApiLinks.add_family_category);

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
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode == 500) {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }

//******************************************************************************

Future getFamilyCategoriesController({BuildContext? context}) async {
  var url = Uri.parse(ApiLinks.get_family_categories);

  var response = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: SharedPreferencesController().token,
    'X-Requested-With': 'XMLHttpRequest',});

  if (response.statusCode < 400) {
    if (context != null)
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);

    var jsonArray = jsonDecode(response.body)['data'] as List;
    List<CategoriesModalFamily> categories =
    jsonArray.map((jsonObject) => CategoriesModalFamily.fromJson(jsonObject)).toList();
    return categories;


  } else if (response.statusCode == 500) {
    if (context != null)
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
  } else {
    if (context != null)
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
  }
  return [];
}

//******************************************************************************

  Future<bool> updateCategoriesFamilyController(BuildContext context,
      {required String arname, required String enname,required String category_id,
      String language=""}) async {
    var url = Uri.parse(ApiLinks.update_family_category);

    var response = await http.post(url, body: {
      "arname": arname,
      "enname": enname,
      'category_id':category_id
    }, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'accept': 'application/json',
      'Accept-Language': language,
      'X-Requested-With': 'XMLHttpRequest',
      'Accept-country': "2"
    });
    if (response.statusCode < 400) {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode == 500) {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }



  //******************************************************************************

  Future<bool> deleteCategoriesFamilyController(
  {required BuildContext context, required String category_id,
  String language=""}
      ) async {
    var url = Uri.parse(ApiLinks.delete_family_category);

    var response = await http.post(url, body: {
      'category_id':category_id
    }, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'accept': 'application/json',
      'Accept-Language': language,
      'X-Requested-With': 'XMLHttpRequest',
      'Accept-country': "2"
    });
    if (response.statusCode < 400) {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode == 500) {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }

}