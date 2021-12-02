import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/api_links.dart';
import 'package:producer_family_app/storage/models/app_modal/faq_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/message_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/notification_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/social_media_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/statistics.dart';
import '../shared_preferences_controller.dart';

class AppController {
  Future<List<FaqModal>> getFaqController({BuildContext? context,String Language="ar"}) async {
    var url = Uri.parse(ApiLinks.faq);
    var response = await http.get(url, headers: {
      'Accept-Language': Language,
      'Accept-country': "2",
      'accept': "application/json",
    });
    if (response.statusCode < 400) {
      var jsonArray = jsonDecode(response.body)['data'] as List;
      List<FaqModal> faqs =
          jsonArray.map((jsonObject) => FaqModal.fromJson(jsonObject)).toList();
      return faqs;
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
  Future getStatisticsController({BuildContext? context}) async {
    var url = Uri.parse(ApiLinks.getstatistics);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,

      'Accept-Language': "ar",
      'Accept-country': "2",
      'accept': "application/json",
    });
    if (response.statusCode < 400) {
      Map<String, dynamic> jsonMap =
      Map<String, dynamic>.from(json.decode(response.body)['data']);
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
  //*********************************************************************************************
  Future getColumnStatisticsController({BuildContext? context}) async {
    var url = Uri.parse(ApiLinks.getstatistics);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,

      'Accept-Language': "ar",
      'Accept-country': "2",
      'accept': "application/json",
    });
    if (response.statusCode < 400) {

      var jsonArray = jsonDecode(response.body)["data"]["statistics"]["data"]as List;
      List<StatisticssModal> statistics =
      jsonArray.map((jsonObject) => StatisticssModal.fromJson(jsonObject)).toList();
      return statistics;
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
  Future getPrivacyController({BuildContext? context,required String Language}) async {
    var url = Uri.parse(ApiLinks.privacy);
    var response = await http.get(url, headers: {
      'Accept-Language': Language,
      'Accept-country': "2",
      'accept': "application/json"
    });
    if (response.statusCode < 400) {
      Map<String, dynamic> jsonMap =
          Map<String, dynamic>.from(json.decode(response.body)['data']);
      return jsonMap;
    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(context: context, message:jsonDecode(response.body)['message'], error: true);
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
  Future getAboutUsController({BuildContext? context,required String Language}) async {
    var url = Uri.parse(ApiLinks.aboutUs);
    var response = await http.get(url,
        headers: {'Accept-Language':Language, 'accept': "application/json"});
    if (response.statusCode < 400) {
      Map<String, dynamic> jsonMap =
          Map<String, dynamic>.from(json.decode(response.body)['data']);
      return jsonMap;
    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(context: context, message: jsonDecode(response.body)['message'], error: true);
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
  Future getSocialMediaController({BuildContext? context}) async {
    var url = Uri.parse(ApiLinks.socialMedia);
    var response = await http.get(url);
    if (response.statusCode < 400) {
      var jsonArray = jsonDecode(response.body)['data'] as List;
      List<SocialMediaModal> socials = jsonArray
          .map((jsonObject) => SocialMediaModal.fromJson(jsonObject))
          .toList();
      return socials;
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
  Future<List<MessagesModal>> getMessageController({BuildContext? context,String language=''}) async {
    var url = Uri.parse(ApiLinks.mymessages);
    var response = await http.get(url, headers: {
     HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'Accept-Language': language,
      'Accept-country': "2",
      'accept': "application/json",
    });
    if (response.statusCode < 400) {
      var jsonArray = jsonDecode(response.body)['data'] as List;
      List<MessagesModal> messages =
      jsonArray.map((jsonObject) => MessagesModal.fromJson(jsonObject)).toList();

      return messages;
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
  Future<bool> postMessageController({BuildContext? context,required String message,
  String language=''}) async {
    var url = Uri.parse(ApiLinks.addNewmessage);
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
       'X-Requested-With': 'XMLHttpRequest',
      'Accept-Language': language,
      'Accept-country': "2",
      'accept': "application/json",
    },body: {
      'message':message,


    });
    if (response.statusCode < 400) {
      if (context != null)
        Helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
      return true;
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
    return false;
  }
  //*********************************************************************************************
  Future<List<NotificationsModal>> getNotificationController({BuildContext? context}) async {
    var url = Uri.parse(ApiLinks.mynotifications);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      // 'X-Requested-With': 'XMLHttpRequest',
      "Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImQxMGZjNjNjZDk3MmIxYjExYzhlYTk3MmEyODQxYmM2MjdjMjZhYzBlMWNmMDdhZjNmMTgwMzVjNDI3YWQzZjUyNzc1ZWUyYzc5NjA0ZjQ5In0.eyJhdWQiOiIxIiwianRpIjoiZDEwZmM2M2NkOTcyYjFiMTFjOGVhOTcyYTI4NDFiYzYyN2MyNmFjMGUxY2YwN2FmM2YxODAzNWM0MjdhZDNmNTI3NzVlZTJjNzk2MDRmNDkiLCJpYXQiOjE2MzE1NTg1ODAsIm5iZiI6MTYzMTU1ODU4MCwiZXhwIjoxNjYzMDk0NTgwLCJzdWIiOiIyMyIsInNjb3BlcyI6W119.UbgUpEUXKv8XIgQ7GruGCQyv7NYsDK6l-2VN7Do5lCt1rvLv1iUjgtWvd9WRz-q3KMcg9HCzm0-9xRzD22-MGpzLH5r8WenLc93HdW4kzmN5XDMTCjBfyRkRxopc-_jNBlAB0t3tftSeqG_LjgNcbX70x7d4AFWo9wVpsMKk4VSaOAz9KhjNBfquYQk4ihVvvRu4kE8-sA7eifhOtMXsaJQOiu0Br_TmvYQYp6r8QLWJjoY7dCtdL93YpMIa1moFmY0TaF6PrO7VIiMpyjrFMjxY4o_baXA1je5TGjLX2Gmm8CfhL8CtCK4LLOLZLUOkNAUqy3oSdQEMOp0oKyKRQbq-OCaO4ATiczAz9Of9024lOb06uZXMynSB8lZQHBxoSr14owiSqHHv-BLnvF_lyxYf9HH_3w8Ns8tVjx0VJ37Pk597CGOSiYfosi98RFamk1Qpmem-MB1gmWGWYyNq7hbWbYxRSV-wQ5i5ePRG4hczDFKqAXf34mKy1Bk5YES0x7JvudSYjRENn790mmtOOAjhklIDovITlFdIEW1euoy4eAjyHtLmLEom9y9CzHmUTRlb9sX6nlp5UdoWjP2G5RGFKRAENjCnaythM1RH5Vj0nEmTnYGQ52WLBa0_Qi80CJVz03uTpe4G7_S5DfHsIue8GuLc3cxKi2cWO_TNyJc",
      'content-type': "application/json",
      'accept': "application/json",
    });
    if (response.statusCode < 400) {
      var jsonArray = jsonDecode(response.body)['data'] as List;
      List<NotificationsModal> notifications =
      jsonArray.map((jsonObject) => NotificationsModal.fromJson(jsonObject)).toList();

      return notifications;
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


}
