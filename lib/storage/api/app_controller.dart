import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/api_links.dart';
import 'package:producer_family_app/storage/models/app_modal/banners_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/faq_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/message_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/notification_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/social_media_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/statistics.dart';

import '../shared_preferences_controller.dart';

class AppController {
  Future<List<FaqModal>> getFaqController(
      {BuildContext? context, String language = "ar"}) async {
    // print("getFaqController Loading from net");
    var url = Uri.parse(ApiLinks.faq);
    var response = await http.get(url, headers: {
      'Accept-Language': language,
      'Accept-country': "2",
      'accept': "application/json",
    });
    if (response.statusCode < 400) {
      if (jsonDecode(response.body)['data'][0] != null) {
        var jsonArray = jsonDecode(response.body)['data'] as List;
        List<FaqModal> faqs = jsonArray
            .map((jsonObject) => FaqModal.fromJson(jsonObject))
            .toList();
        return faqs;
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

  // }
  //*********************************************************************************************
  Future getStatisticsController(
      {BuildContext? context, bool? isUpdated}) async {
    String fileName = "getStatistics.json";
    var dir = await getTemporaryDirectory();
    File file = File("${dir.path}/$fileName");
    if (isUpdated == true) file.deleteSync(recursive: true);

    if (file.existsSync()) {
      // print("getStatistics Loading from cache");
      var response = file.readAsStringSync();
      Map<dynamic, dynamic> jsonMap =
          Map<dynamic, dynamic>.from(json.decode(response)['data']);
      return jsonMap;
    } else {
      // print("getStatistics Loading from net");
      var url = Uri.parse(ApiLinks.getStatistics);
      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'Accept-Language': "ar",
        'Accept-country': "2",
        'accept': "application/json",
      });
      if (response.statusCode < 400) {
        Map<dynamic, dynamic> jsonMap = Map<dynamic, dynamic>.from(
            json.decode(response.body)['data'] ?? {});
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

  //*********************************************************************************************
  Future<List<StatisticssModal>> getColumnStatisticsController(
      {BuildContext? context, bool? isUpdated}) async {
    String fileName = "getColumnStatistics.json";
    var dir = await getTemporaryDirectory();
    File file = File("${dir.path}/$fileName");
    if (isUpdated == true) file.deleteSync(recursive: true);

    if (file.existsSync()) {
      // print("getColumnStatistics Loading from cache");
      var response = file.readAsStringSync();
      var jsonArray =
          jsonDecode(response)["data"]["statistics"]["data"] as List;
      List<StatisticssModal> statistics = jsonArray
          .map((jsonObject) => StatisticssModal.fromJson(jsonObject))
          .toList();
      return statistics;
    } else {
      // print("getColumnStatistics Loading from net");

      var url = Uri.parse(ApiLinks.getStatistics);
      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'Accept-Language': "ar",
        'Accept-country': "2",
        'accept': "application/json",
      });
      if (response.statusCode < 400) {
        // if( jsonDecode(response.body)['data']["statistics"]["data"][0]!=null){

        var jsonArray =
            jsonDecode(response.body)["data"]["statistics"]["data"] as List;
        List<StatisticssModal> statistics = jsonArray
            .map((jsonObject) => StatisticssModal.fromJson(jsonObject))
            .toList();

        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);
        return statistics;
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

  //*********************************************************************************************
  Future getPrivacyController(
      {BuildContext? context, required String language}) async {
    // print("getPrivacyController Loading from net");
    var url = Uri.parse(ApiLinks.privacy);
    var response = await http.get(url, headers: {
      'Accept-Language': language,
      'Accept-country': "2",
      'accept': "application/json"
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

  // }
  //*********************************************************************************************
  Future getAboutUsController(
      {BuildContext? context, required String language}) async {
    // print("getAboutUsController Loading from net");
    var url = Uri.parse(ApiLinks.aboutUs);
    var response = await http.get(url,
        headers: {'Accept-Language': language, 'accept': "application/json"});
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

  // }
//*********************************************************************************************
  Future<List<SocialMediaModal>> getSocialMediaController(
      {BuildContext? context}) async {
    String fileName = "getSocialMediaController.json";
    var dir = await getTemporaryDirectory();
    File file = File("${dir.path}/$fileName");
    if (file.existsSync()) {
      // print("getSocialMedia Loading from cache");
      var response = file.readAsStringSync();

      var jsonArray = jsonDecode(response)['data'] as List;
      List<SocialMediaModal> socials = jsonArray
          .map((jsonObject) => SocialMediaModal.fromJson(jsonObject))
          .toList();
      return socials;
    } else {
      // print("getSocialMedia Loading from net");
      var url = Uri.parse(ApiLinks.socialMedia);
      var response = await http.get(url);
      if (response.statusCode < 400) {
        if (jsonDecode(response.body)['data'][0] != null) {
          var jsonArray = jsonDecode(response.body)['data'] as List;
          List<SocialMediaModal> socials = jsonArray
              .map((jsonObject) => SocialMediaModal.fromJson(jsonObject))
              .toList();
          file.writeAsStringSync(response.body,
              flush: true, mode: FileMode.write);

          return socials;
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

//*********************************************************************************************
  Future<List<MessagesModal>> getMessageController(
      {BuildContext? context, bool? isUpdated, String language = ''}) async {
    // String fileName = "getMessageController.json";
    // var dir = await getTemporaryDirectory();
    // File file = new File(dir.path + "/" + fileName);
    // if(isUpdated==true)file.deleteSync(recursive: true);
    //
    // if (file.existsSync()) {
    //   print("getMessageController Loading from cache");
    //   var response = file.readAsStringSync();
    //
    //   var jsonArray = jsonDecode(response)['data'] as List;
    //   List<MessagesModal> messages =
    //   jsonArray.map((jsonObject) => MessagesModal.fromJson(jsonObject)).toList();
    //   return messages;
    // }else{
    //   print("getMessageController Loading from net");
    var url = Uri.parse(ApiLinks.mymessages);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'Accept-Language': language,
      'Accept-country': "2",
      'accept': "application/json",
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
        List<MessagesModal> messages = jsonArray
            .map((jsonObject) => MessagesModal.fromJson(jsonObject))
            .toList();
        // file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
        return messages;
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
  Future<bool> postMessageController(
      {BuildContext? context,
      required String message,
      String language = ''}) async {
    var url = Uri.parse(ApiLinks.addNewmessage);
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'Accept-Language': language,
      'Accept-country': "2",
      'accept': "application/json",
    }, body: {
      'message': message,
    });
    if (response.statusCode < 400) {
      if (context != null) {
        helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
      }
      return true;
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
    return false;
  }

  //*********************************************************************************************
  Future<List<NotificationsModal>> getNotificationController(
      {BuildContext? context}) async {
    // print("getNotificationController Loading from net");
    var url = Uri.parse(ApiLinks.myNotifications);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'content-type': "application/json",
      'accept': "application/json",
    });
    if (response.statusCode < 400) {
      if (jsonDecode(response.body)['data'][0] != null) {
        var jsonArray = jsonDecode(response.body)['data'] as List;
        List<NotificationsModal> notifications = jsonArray
            .map((jsonObject) => NotificationsModal.fromJson(jsonObject))
            .toList();
        return notifications;
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
  Future<List<BannersModal>> getBannersController(
      {BuildContext? context}) async {
    // print("getBannersController Loading from net");
    var url = Uri.parse(ApiLinks.banners);
    var response = await http.get(url);
    if (response.statusCode < 400) {
      if (jsonDecode(response.body)['data'][0] != null) {
        var jsonArray = jsonDecode(response.body)['data'] as List;
        List<BannersModal> banners = jsonArray
            .map((jsonObject) => BannersModal.fromJson(jsonObject))
            .toList();
        return banners;
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
  Future<bool> sendChatController(
      {BuildContext? context,
      required int receiverId,
      required String orderNo,
      String language = ''}) async {
    var url = Uri.parse(ApiLinks.sendMessage);
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'Accept-Language': language,
      'Accept-country': "2",
      'accept': "application/json",
    }, body: {
      'receiver_id': receiverId.toString(),
      'order_no': orderNo.toString(),
    });
    if (response.statusCode < 400) {
      if (context != null) {
        helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
      }
      return true;
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
    return false;
  }
}
