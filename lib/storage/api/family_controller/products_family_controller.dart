import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/api_links.dart';
import 'package:producer_family_app/storage/models/family_modal/products_family.dart';
import '../../shared_preferences_controller.dart';

class ProductFamilyController {
  Future getFamilyProductsController({BuildContext? context,String language=''}) async {
    var url = Uri.parse(ApiLinks.get_family_products);

    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'Accept-Language': language
    });

    if (response.statusCode < 400) {
      var jsonArray = jsonDecode(response.body)['data'] as List;

      List<ProductsModalFamily> productsFamily = jsonArray
          .map((jsonObject) => ProductsModalFamily.fromJson(jsonObject))
          .toList();
      return productsFamily;
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

  //*********************************************************************

  Future getFamilyOneProductsController({BuildContext? context}) async {
    var url = Uri.parse(ApiLinks.get_family_products);

    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
    });

    if (response.statusCode < 400) {
      Map<String, dynamic> jsonMap =
          Map<String, dynamic>.from(json.decode(response.body)["data"]);
      return jsonMap;
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

  //*********************************************************************

  Future<bool> adddProductController(BuildContext context,
      {String? path1 = "",
      String? path2 = "",
      required int category,
      required String arname,
      required String? enname,
      required String price,
      required String duration_from,
      required String duration_to,
      required String duration_unit,
      String? offer_duration,
      String? offer_duration_unit,
      String? offer_price,
      String? offer_discount,
      required String ardesc,
      String language = '',
      String? endesc,


        required String image_id,


      required Function(bool status) uploadEvent}) async {
    var url = Uri.parse(
      ApiLinks.add_family_product,
    );

    var multiPartRequest = http.MultipartRequest('post', url);
    multiPartRequest.headers["X-Requested-With"] = 'XMLHttpRequest';
    multiPartRequest.headers["Accept-Language"] = language;
    multiPartRequest.headers[HttpHeaders.authorizationHeader] =
        SharedPreferencesController().token;
    var multiPartFile = path1 != null
        ? await http.MultipartFile.fromPath("images[]", path1)
        : null;
    var multiPartFile2 = path2 != null
        ? await http.MultipartFile.fromPath("images[]", path2)
        : null;
    multiPartFile != null ? multiPartRequest.files.add(multiPartFile) : null;
    multiPartFile2 != null ? multiPartRequest.files.add(multiPartFile2) : null;
    multiPartRequest.fields['category'] = category.toString();
    multiPartRequest.fields['arname'] = arname;
    multiPartRequest.fields['enname'] = enname!;
    multiPartRequest.fields['price'] = price;
    multiPartRequest.fields['offer_duration'] = offer_duration!;
    multiPartRequest.fields['duration_from'] = duration_from;
    multiPartRequest.fields['duration_to'] = duration_to;
    multiPartRequest.fields['duration_unit'] = duration_unit;
    multiPartRequest.fields['offer_duration_unit'] = offer_duration_unit!;
    multiPartRequest.fields['offer_price'] = offer_price!;
    multiPartRequest.fields['offer_discount'] = offer_discount ?? '';
    multiPartRequest.fields['ardesc'] = ardesc;
    multiPartRequest.fields['endesc'] = endesc!;

    var response = await multiPartRequest.send();
    response.stream.transform(utf8.decoder).listen((event) {
      var responseBody = jsonDecode(event);
      Helper(context: context, message: responseBody['message'], error: true);

      if (response.statusCode < 400) {
        uploadEvent(true);
      } else if (response.statusCode == 500) {
        Helper(context: context, message: responseBody['message'], error: true);
        uploadEvent(false);
      } else {
        Helper(context: context, message: responseBody['message'], error: true);
      }
    });

    return false;
  }

//*********************************************************************************************

  Future<bool> editProductController(BuildContext context,
      {
        String? path1="",
        String? path2="",
        required String product_id,
        required String image_id,

        required String category,
        required String arname,
        required String? enname,
        required String price,
        required String duration_from,
        required String duration_to,
        required String duration_unit,
        String? offer_duration,
        String? offer_duration_unit,
        String? offer_price,
        String? offer_discount,
        required String ardesc,
        String language='',
        String? endesc,

        required Function(bool status) uploadEvent}) async {
    var url = Uri.parse(
      ApiLinks.update_family_product,
    );

    var multiPartRequest = http.MultipartRequest('post', url);
    multiPartRequest.headers["X-Requested-With"] = 'XMLHttpRequest';
    multiPartRequest.headers["Accept-Language"] =
    Localizations.localeOf(context).languageCode == "ar"
         ? "ar"
         : "en";
    multiPartRequest.headers[HttpHeaders.authorizationHeader] =
        SharedPreferencesController().token;
    var multiPartFile = path1!=null?
    await http.MultipartFile.fromPath("images[]", path1):null;
    var multiPartFile2 =path2!=null? await http.MultipartFile.fromPath("images[]", path2):null;
    multiPartFile != null ?  multiPartRequest.files.add(multiPartFile):null;
    multiPartFile2 != null ? multiPartRequest.files.add(multiPartFile2):null;
    multiPartRequest.fields['category'] = category;
    multiPartRequest.fields['product_id'] = product_id;
    multiPartRequest.fields['arname'] = arname;
    multiPartRequest.fields['enname'] = enname!;
    multiPartRequest.fields['price'] = price;
    multiPartRequest.fields['offer_duration'] = offer_duration!;
    multiPartRequest.fields['duration_from'] = duration_from;
    multiPartRequest.fields['duration_to'] = duration_to;
    multiPartRequest.fields['duration_unit'] = duration_unit;
    multiPartRequest.fields['offer_duration_unit'] = offer_duration_unit!;
    multiPartRequest.fields['offer_price'] = offer_price!;
    multiPartRequest.fields['offer_discount'] = offer_discount??'';
    multiPartRequest.fields['ardesc'] = ardesc;
    multiPartRequest.fields['endesc'] = endesc!;
    multiPartRequest.fields['image_id'] = image_id;

    var response = await multiPartRequest.send();
    response.stream.transform(utf8.decoder).listen((event) {
      var responseBody = jsonDecode(event);
      Helper(context: context, message: responseBody['message'], error: true);

      if (response.statusCode < 400) {
        uploadEvent(true);
      } else if (response.statusCode == 500) {
        Helper(context: context, message: responseBody['message'], error: true);
        uploadEvent(false);
      } else {
        Helper(context: context, message: responseBody['message'], error: true);
      }
    });

    return false;
  }

//*********************************************************************************************

  Future<bool> deleteProductFamilyController(
      {required BuildContext context,
      required String product_id,
      String language = ''}) async {
    var url = Uri.parse(ApiLinks.delete_family_product);

    var response = await http.post(url, body: {
      'product_id': product_id
    }, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'Accept-Language': language,
      'X-Requested-With': 'XMLHttpRequest',
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
