import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/api_links.dart';
import 'package:producer_family_app/storage/models/home_modal/categories_modal.dart';
import 'package:producer_family_app/storage/models/home_modal/home_modal.dart';
import 'package:producer_family_app/storage/models/show_modal/show_family.dart';
import 'package:producer_family_app/storage/models/show_modal/show_product_modal.dart';

class HomeController {
  Future<List<CategoriesModal>> getCategoriesController(
      {BuildContext? context}) async {
    var url = Uri.parse(ApiLinks.getcategories);

    var response = await http.get(url);
    if (response.statusCode < 400) {
      if (jsonDecode(response.body)['data'][0] != null) {
        var jsonArray = jsonDecode(response.body)['data'] as List;
        List<CategoriesModal> categories = jsonArray
            .map((jsonObject) => CategoriesModal.fromJson(jsonObject))
            .toList();
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

//*********************************************************************************************

  Future<HomeModal?> getHome(
      {BuildContext? context,
      String? keyword,
      String? category,
      String language = "",
      String lat = '',
      String lng = '',
      bool? isUpdated,
      int page = 1}) async {
    // String fileName = "getHome.json";
    // var dir = await getTemporaryDirectory();
    // File file = new File(dir.path + "/" + fileName);
    // if(isUpdated==true&&file.existsSync())
    //   file.deleteSync(recursive: true);
    //
    // if (file.existsSync())
    // {
    //   print("getHome Loading from cache");
    //   var response = file.readAsStringSync();
    //   var jsonObject = jsonDecode(response)['data'];
    //   var object = HomeModal.fromJson(jsonObject);
    //   return object;
    // }

    // else  {
    // print("getHome Loading from net");

    var url = Uri.parse("https://nourah.store/api/v2/home?page=$page");
    var response = await http.post(url, headers: {
      'accept': 'application/json',
      'Accept-Language': language,
      'Accept-country': '1'
    }, body: {
      "keyword": keyword,
      "category": category,
      "lat": lat,
      'lng': lng,
    });

    if (response.statusCode < 400) {
      var jsonObject = jsonDecode(response.body)['data'];
      var object = HomeModal.fromJson(jsonObject);
      // print('HomeGetx');
      // file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      return object;
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
    return null;
  }

  // }
//*********************************************************************************************
  Future showProductController(
      {BuildContext? context,
      required int productId,
      String language = ""}) async {
    var url = Uri.parse(ApiLinks.showproduct);
    var response = await http.post(url, body: {
      'product_id': productId.toString()
    }, headers: {
      'accept': "application/json",
      'Accept-Language': language,
      'Accept-country': '1'
    });
    if (response.statusCode < 400) {
      Map<String, dynamic> jsonMap =
          Map<String, dynamic>.from(json.decode(response.body)['data'] ?? {});
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

  //  ****************************************************************
  Future<ShowFamilyModal?> showFamilyController(
      {BuildContext? context,
      required int id,
      String language = '',
      String category = "0",
      String lat = '',
      String lng = ''}) async {
    var url = Uri.parse(ApiLinks.showfamily);
    var response = await http.post(url, body: {
      'family_id': id.toString(),
      'category': category,
      'lat': lat.toString(),
      'lng': lng.toString()
    }, headers: {
      'accept': "application/json",
      'Accept-Language': language,
      'Accept-country': '1'
    });
    if (response.statusCode < 400) {
      var jsonObject = jsonDecode(response.body)['data'];
      var object = ShowFamilyModal.fromJson(jsonObject);

      return object;
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
    return null;
  }

  //  ****************************************************************
  Future showFamilyControllerMap(
      {BuildContext? context,
      required int id,
      String language = '',
      String lat = '',
      String lng = ''}) async {
    var url = Uri.parse(ApiLinks.showfamily);
    var response = await http.post(url, body: {
      'family_id': id.toString(),
      'lat': lat.toString(),
      'lng': lng.toString()
    }, headers: {
      'accept': "application/json",
      'Accept-Language': language,
      'Accept-country': '1'
    });
    if (response.statusCode < 400) {
      Map<String, dynamic> jsonMap =
          Map<String, dynamic>.from(json.decode(response.body)['data']);
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

  //*********************************************************************************************
  Future<List<ProductsFamily>> getShowProductFamilyController(
      {BuildContext? context, String? keyword, required String id}) async {
    var url = Uri.parse(ApiLinks.showfamily);

    var response = await http.post(url, body: {
      'family_id': id.toString()
    }, headers: {
      'accept': "application/json",
      'Accept-Language': "ar",
      'Accept-country': '1'
    });

    if (response.statusCode < 400) {
      if (jsonDecode(response.body)['data']['products']['data'][0] != null) {
        var jsonArray =
            jsonDecode(response.body)['data']['products']['data'] as List;
        List<ProductsFamily> products = jsonArray
            .map((jsonObject) => ProductsFamily.fromJson(jsonObject))
            .toList();
        return products;
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

//*********************************************************************************************
  Future<List<ImagesProduct>> showImagesProductController(
      {BuildContext? context, required int productId}) async {
    var url = Uri.parse(ApiLinks.showproduct);
    var response = await http.post(url, body: {
      'product_id': productId.toString()
    }, headers: {
      'accept': "application/json",
      'Accept-Language': "ar",
      'Accept-country': '1'
    });
    if (response.statusCode < 400) {
      if (jsonDecode(response.body)['data']['images'].length != 0) {
        if (jsonDecode(response.body)['data']['images'][0] != null &&
            jsonDecode(response.body)['data']['images'][0] != "") {
          var jsonArray = jsonDecode(response.body)['data']['images'] as List;
          List<ImagesProduct> showImageproduct = jsonArray
              .map((jsonObject) => ImagesProduct.fromJson(jsonObject))
              .toList();
          return showImageproduct;
        }
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
