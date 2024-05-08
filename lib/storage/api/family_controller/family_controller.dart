import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/api_links.dart';

import '../../shared_preferences_controller.dart';

class FamilyController {
  Future getCategoriesController({BuildContext? context}) async {
    var url = Uri.parse(ApiLinks.profile);

    var response = await http.get(url);

    if (response.statusCode < 400) {
      Map<String, dynamic> jsonMap =
          Map<String, dynamic>.from(json.decode(response.body)['data']);
      return jsonMap;
    } else if (response.statusCode == 500) {
      if (context != null) {
        helper(context: context, message: "error in server", error: true);
      }
    } else {
      if (context != null) {
        helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
      }
    }
    return {};
  }

//*********************************************************************************************
  Future getFamilyPoliciesController(
      {BuildContext? context, bool? isUpdated}) async {
    String fileName = "getFamilyPoliciesController.json";
    var dir = await getTemporaryDirectory();
    File file = File("${dir.path}/$fileName");
    if (isUpdated == true) file.deleteSync(recursive: true);
    if (file.existsSync()) {
      // print("getFamilyPoliciesController Loading from cache");
      var response = file.readAsStringSync();
      Map<dynamic, dynamic> jsonMap =
          Map<dynamic, dynamic>.from(json.decode(response)['data']);
      return jsonMap;
    } else {
      // print("getFamilyPoliciesController Loading from net");

      var url = Uri.parse(ApiLinks.getfamilypolicies);

      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'Accept-country': '2',
        'Accept-Language': 'ar'
      });

      if (response.statusCode < 400) {
        Map<dynamic, dynamic> jsonMap =
            Map<dynamic, dynamic>.from(json.decode(response.body)['data']);
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);

        return jsonMap;
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
      return {};
    }
  }

// *******************************************************************************************
  Future<bool> addPoliciesFamilyController(BuildContext context,
      {required String arPolicy,
      required String enPolicy,
      String language = ""}) async {
    var url = Uri.parse(ApiLinks.addOrupdateFamilyPolicies);

    var response = await http.post(url, body: {
      "arpolicy": arPolicy,
      "enpolicy": enPolicy,
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
