import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/api_links.dart';
import 'package:producer_family_app/storage/models/family_modal/products_family.dart';

import '../../shared_preferences_controller.dart';

class ProductFamilyController {
  Future<List<ProductsModalFamily>> getFamilyProductsController(
      {BuildContext? context, String language = '', bool? isUpdated}) async {
    String fileName = "getFamilyProductsController.json";
    var dir = await getTemporaryDirectory();
    File file = File("${dir.path}/$fileName");
    if (isUpdated == true && file.existsSync())
      file.deleteSync(recursive: true);
    if (file.existsSync()) {
      // print("getFamilyProductsController Loading from cache");
      var response = file.readAsStringSync();
      var jsonArray = jsonDecode(response)['data'] as List;
      List<ProductsModalFamily> productsFamily = jsonArray
          .map((jsonObject) => ProductsModalFamily.fromJson(jsonObject))
          .toList();
      return productsFamily;
    } else {
      // print("getFamilyProductsController Loading from net");
      var url = Uri.parse(ApiLinks.getFamilyProducts);
      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'Accept-Language': language
      });
      if (response.statusCode < 400) {
        if (jsonDecode(response.body)['data'][0] != null) {
          var jsonArray = jsonDecode(response.body)['data'] as List;
          List<ProductsModalFamily> productsFamily = jsonArray
              .map((jsonObject) => ProductsModalFamily.fromJson(jsonObject))
              .toList();
          file.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);

          return productsFamily;
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
  //*********************************************************************

  Future getFamilyOneProductsController({BuildContext? context}) async {
    var url = Uri.parse(ApiLinks.getFamilyProducts);

    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
    });
    if (response.statusCode < 400) {
      Map<String, dynamic> jsonMap =
          Map<String, dynamic>.from(json.decode(response.body)["data"]);
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

  //*********************************************************************
  Future<bool> adddProductController(BuildContext context,
      {String? path1 = "",
      required int category,
      required String arname,
      required String enname,
      required int price,
      required int brand,
      required int durationFrom,
      required int durationTo,
      required String durationUnit,
      required int offerDuration,
      String? offerDurationUnit,
      required int offerPrice,
      required int offerStatus,
      int? offerDiscount,
      required String ardesc,
      String language = '',
      String? endesc,
      required String imageId,
      required Function(bool status) uploadEvent}) async {
    var url = Uri.parse(
      ApiLinks.addFamilyProduct,
    );
    var multiPartRequest = http.MultipartRequest('post', url);
    multiPartRequest.headers["X-Requested-With"] = 'XMLHttpRequest';
    multiPartRequest.headers["Accept-Language"] = language;
    multiPartRequest.headers[HttpHeaders.authorizationHeader] =
        SharedPreferencesController().token;
    var multiPartFile = path1 != null
        ? await http.MultipartFile.fromPath("images[]", path1)
        : null;
    multiPartFile != null ? multiPartRequest.files.add(multiPartFile) : null;
    multiPartRequest.fields['category'] = category.toString();
    multiPartRequest.fields['arname'] = arname;
    multiPartRequest.fields['enname'] = enname;
    multiPartRequest.fields['price'] = price.toString();
    multiPartRequest.fields['brand'] = brand.toString();
    multiPartRequest.fields['offer_duration'] = offerDuration.toString();
    multiPartRequest.fields['duration_from'] = durationFrom.toString();
    multiPartRequest.fields['duration_to'] = durationTo.toString();
    multiPartRequest.fields['duration_unit'] = durationUnit;
    multiPartRequest.fields['offer_duration_unit'] = offerDurationUnit!;
    multiPartRequest.fields['offer_price'] = offerPrice.toString();
    multiPartRequest.fields['offer_status'] = offerStatus.toString();
    // multiPartRequest.fields['offer_discount'] = offer_discount.toString();
    multiPartRequest.fields['ardesc'] = ardesc;
    multiPartRequest.fields['endesc'] = endesc!;

    var response = await multiPartRequest.send();
    response.stream.transform(utf8.decoder).listen((event) {
      var responseBody = jsonDecode(event);
      helper(context: context, message: responseBody['message'], error: true);

      if (response.statusCode < 400) {
        uploadEvent(true);
      } else if (response.statusCode == 500) {
        helper(context: context, message: responseBody['message'], error: true);
        uploadEvent(false);
      } else {
        helper(context: context, message: responseBody['message'], error: true);
      }
    });
    return false;
  }

  //*********************************************************************
  Future<bool> adddProductWithoutSaleController(BuildContext context,
      {String? path1 = "",
      required int category,
      required String arname,
      required String? enname,
      required int price,
      required int brand,
      required int durationFrom,
      required int durationTo,
      required String durationUnit,
      required String ardesc,
      String language = '',
      String? endesc,
      required String imageId,
      required Function(bool status) uploadEvent}) async {
    var url = Uri.parse(
      ApiLinks.addFamilyProduct,
    );
    var multiPartRequest = http.MultipartRequest('post', url);
    multiPartRequest.headers["X-Requested-With"] = 'XMLHttpRequest';
    multiPartRequest.headers["Accept-Language"] = language;
    multiPartRequest.headers[HttpHeaders.authorizationHeader] =
        SharedPreferencesController().token;
    var multiPartFile = path1 != null
        ? await http.MultipartFile.fromPath("images[]", path1)
        : null;
    multiPartFile != null ? multiPartRequest.files.add(multiPartFile) : null;
    multiPartRequest.fields['category'] = category.toString();
    multiPartRequest.fields['arname'] = arname;
    multiPartRequest.fields['enname'] = enname!;
    multiPartRequest.fields['price'] = price.toString();
    multiPartRequest.fields['brand'] = brand.toString();
    multiPartRequest.fields['duration_from'] = durationFrom.toString();
    multiPartRequest.fields['duration_to'] = durationTo.toString();
    multiPartRequest.fields['duration_unit'] = durationUnit;
    multiPartRequest.fields['ardesc'] = ardesc;
    multiPartRequest.fields['endesc'] = endesc!;

    var response = await multiPartRequest.send();
    response.stream.transform(utf8.decoder).listen((event) {
      var responseBody = jsonDecode(event);
      helper(context: context, message: responseBody['message'], error: true);

      if (response.statusCode < 400) {
        uploadEvent(true);
      } else if (response.statusCode == 500) {
        helper(context: context, message: responseBody['message'], error: true);
        uploadEvent(false);
      } else {
        helper(context: context, message: responseBody['message'], error: true);
      }
    });
    return false;
  }

//*********************************************************************************************

  Future<bool> editProductController(BuildContext context,
      {String? path1 = "",
      required int productId,
      required int imageId,
      required int category,
      required String arname,
      required String? enname,
      required int price,
      required int brand,
      required int durationFrom,
      required int durationTo,
      required String durationUnit,
      required int offerDuration,
      required String offerDurationUnit,
      required double offerPrice,
      required int offerStatus,
      required String ardesc,
      String language = '',
      required String endesc,
      required Function(bool status) uploadEvent}) async {
    var url = Uri.parse(
      ApiLinks.updateFamilyProduct,
    );

    var multiPartRequest = http.MultipartRequest('post', url);
    multiPartRequest.headers["X-Requested-With"] = 'XMLHttpRequest';
    multiPartRequest.headers["Accept-Language"] =
        Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en";
    multiPartRequest.headers[HttpHeaders.authorizationHeader] =
        SharedPreferencesController().token;
    var multiPartFile = path1 != null
        ? await http.MultipartFile.fromPath("images[]", path1)
        : null;

    multiPartFile != null ? multiPartRequest.files.add(multiPartFile) : null;
    multiPartRequest.fields['category'] = category.toString();
    multiPartRequest.fields['product_id'] = productId.toString();
    multiPartRequest.fields['arname'] = arname;
    multiPartRequest.fields['enname'] = enname!;
    multiPartRequest.fields['price'] = price.toString();
    multiPartRequest.fields['brand'] = brand.toString();
    multiPartRequest.fields['offer_duration'] = offerDuration.toString();
    multiPartRequest.fields['duration_from'] = durationFrom.toString();
    multiPartRequest.fields['duration_to'] = durationTo.toString();
    multiPartRequest.fields['duration_unit'] = durationUnit;
    multiPartRequest.fields['offer_duration_unit'] = offerDurationUnit;
    multiPartRequest.fields['offer_price'] = offerPrice.toString();
    multiPartRequest.fields['offer_status'] = offerStatus.toString();
    multiPartRequest.fields['ardesc'] = ardesc;
    multiPartRequest.fields['endesc'] = endesc;
    multiPartRequest.fields['image_id'] = imageId.toString();

    var response = await multiPartRequest.send();
    response.stream.transform(utf8.decoder).listen((event) {
      var responseBody = jsonDecode(event);
      helper(context: context, message: responseBody['message'], error: true);

      if (response.statusCode < 400) {
        uploadEvent(true);
      } else if (response.statusCode == 500) {
        helper(context: context, message: responseBody['message'], error: true);
        uploadEvent(false);
      } else {
        helper(context: context, message: responseBody['message'], error: true);
      }
    });
    return false;
  }

  //*********************************************************************************************

  Future<bool> editProductWithoutSaleController(
    BuildContext context, {
    String? path1 = "",
    required int productId,
    required int imageId,
    required int category,
    required String arname,
    required String enname,
    required int price,
    required int brand,
    required int durationFrom,
    required int durationTo,
    required String durationUnit,
    required String ardesc,
    String language = '',
    required String endesc,
    required Function(bool status) uploadEvent,
  }) async {
    var url = Uri.parse(
      ApiLinks.updateFamilyProduct,
    );

    var multiPartRequest = http.MultipartRequest('post', url);
    multiPartRequest.headers["X-Requested-With"] = 'XMLHttpRequest';
    multiPartRequest.headers["Accept-Language"] =
        Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en";
    multiPartRequest.headers[HttpHeaders.authorizationHeader] =
        SharedPreferencesController().token;
    var multiPartFile = path1 != null
        ? await http.MultipartFile.fromPath("images[]", path1)
        : null;

    multiPartFile != null ? multiPartRequest.files.add(multiPartFile) : null;
    multiPartRequest.fields['category'] = category.toString();
    multiPartRequest.fields['product_id'] = productId.toString();
    multiPartRequest.fields['arname'] = arname;
    multiPartRequest.fields['enname'] = enname;
    multiPartRequest.fields['price'] = price.toString();
    multiPartRequest.fields['brand'] = brand.toString();
    multiPartRequest.fields['duration_from'] = durationFrom.toString();
    multiPartRequest.fields['duration_to'] = durationTo.toString();
    multiPartRequest.fields['duration_unit'] = durationUnit;
    multiPartRequest.fields['ardesc'] = ardesc;
    multiPartRequest.fields['endesc'] = endesc;
    multiPartRequest.fields['image_id'] = imageId.toString();

    var response = await multiPartRequest.send();
    response.stream.transform(utf8.decoder).listen((event) {
      var responseBody = jsonDecode(event);
      helper(context: context, message: responseBody['message'], error: true);

      if (response.statusCode < 400) {
        uploadEvent(true);
      } else if (response.statusCode == 500) {
        helper(context: context, message: responseBody['message'], error: true);
        uploadEvent(false);
      } else {
        helper(context: context, message: responseBody['message'], error: true);
      }
    });
    return false;
  }

//*********************************************************************************************

  Future<bool> deleteProductFamilyController(
      {required BuildContext context,
      required String productId,
      String language = ''}) async {
    var url = Uri.parse(ApiLinks.deleteFamilyProduct);

    var response = await http.post(url, body: {
      'product_id': productId
    }, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'Accept-Language': language,
      'X-Requested-With': 'XMLHttpRequest',
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
//*********************************************************************************************

  Future getFamilyMainCategoriesController({BuildContext? context}) async {
    var url = Uri.parse(ApiLinks.getMainFamilyCategories);

    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
    });
    if (response.statusCode < 400) {
      var jsonArray = jsonDecode(response.body)['data'] as List;
      List<MainCategoriesModalFamily> mainCategories = jsonArray
          .map((jsonObject) => MainCategoriesModalFamily.fromJson(jsonObject))
          .toList();
      return mainCategories;
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
