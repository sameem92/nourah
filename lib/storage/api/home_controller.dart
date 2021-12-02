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
      var jsonArray = jsonDecode(response.body)['data'] as List;
      List<CategoriesModal> categories = jsonArray
          .map((jsonObject) => CategoriesModal.fromJson(jsonObject))
          .toList();
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

//*********************************************************************************************

  Future<HomeModal?> getHome(
      {BuildContext? context, String? keyword, String? category,String language="",String lat='',String lng=''}) async {
    var url = Uri.parse(ApiLinks.home);

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
      return object;
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
    return null;
  }


//*********************************************************************************************
  Future ShowProductController (
      {BuildContext? context,required String product_id,String language=""})async{
    var url =Uri.parse(ApiLinks.showproduct);
    var response = await http.post(url,
        body:{
          'product_id':product_id
        },headers:
        {
          'accept':"application/json",
          'Accept-Language':language,
          'Accept-country':'1'

        });
    if (response.statusCode < 400) {
      Map<String, dynamic> jsonMap =
      Map<String, dynamic>.from(json.decode(response.body)['data']);
      return jsonMap;

    } else if (response.statusCode == 500) {
      if(context != null)
        Helper(context: context, message:jsonDecode(response.body)['message'], error: true);
    } else {
      if(context != null)

        Helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return [];
  }


  //  ****************************************************************
  Future <ShowFamilyModal?> ShowFamilyController (
      {BuildContext? context,required String id,String language='',String category="0"})async{
    var url =Uri.parse(ApiLinks.showfamily);
    var response = await http.post(url,
        body:{
          'family_id':id,
          'category':category
        },headers:
        {
          'accept':"application/json",
          'Accept-Language':language,
          'Accept-country':'1'

        });
    if (response.statusCode < 400) {

      var jsonObject = jsonDecode(response.body)['data'];
      var object = ShowFamilyModal.fromJson(jsonObject);

      return object;}
      else if (response.statusCode == 500) {
      if(context != null)
        Helper(context: context, message:jsonDecode(response.body)['message'], error: true);
    } else {
      if(context != null)

        Helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return null;
  }

  //  ****************************************************************
  Future ShowFamilyControllerMap (
      {BuildContext? context,required String id,String language=''})async{
    var url =Uri.parse(ApiLinks.showfamily);
    var response = await http.post(url,
        body:{
          'family_id':id
        },headers:
        {
          'accept':"application/json",
          'Accept-Language':language,
          'Accept-country':'1'

        });
    if (response.statusCode < 400) {
      Map<String, dynamic> jsonMap =
      Map<String, dynamic>.from(json.decode(response.body)['data']);
      return jsonMap;
        } else if (response.statusCode == 500) {
      if(context != null)
        Helper(context: context, message:jsonDecode(response.body)['message'], error: true);
    } else {
      if(context != null)

        Helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return null;
  }

  //*********************************************************************************************
  Future getShowProductFamilyController(
      {BuildContext? context,String? keyword,required String id}) async {
    var url = Uri.parse(ApiLinks.showfamily);

    var response = await http.post(url, body:{
      'family_id':id
    },headers:
    {
      'accept':"application/json",
      'Accept-Language':"ar",
      'Accept-country':'1'

    });


    if (response.statusCode < 400) {
      var jsonArray = jsonDecode(response.body)['data']['products']['data']as List;
      List<ProductsFamily> products = jsonArray
          .map((jsonObject) => ProductsFamily.fromJson(jsonObject))
          .toList();
      return products;
    } else if (response.statusCode == 500) {
      if(context != null)
        Helper(context: context, message: jsonDecode(response.body)['message'], error: true);
    } else {
      if(context != null)
        Helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return [];
  }

//*********************************************************************************************
  Future ShowImagesProductController (
      {BuildContext? context, String? product_id})async{
    var url =Uri.parse(ApiLinks.showproduct);
    var response = await http.post(url,
        body:{
          'product_id':product_id
        },headers:
        {
          'accept':"application/json",
          'Accept-Language':"ar",
          'Accept-country':'1'

        });
    if (response.statusCode < 400) {

      var jsonArray = jsonDecode(response.body)['data']['images'] as List;
      List<ImagesProduct> showImageproduct =
      jsonArray.map((jsonObject) => ImagesProduct.fromJson(jsonObject)).toList();
      return showImageproduct;
    } else if (response.statusCode == 500) {
      if(context != null)
        Helper(context: context, message:jsonDecode(response.body)['message'], error: true);
    } else {
      if(context != null)

        Helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return [];
  }

}