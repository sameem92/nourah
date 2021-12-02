

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/api_links.dart';
import 'package:producer_family_app/storage/models/orders_modal/order_family_modal.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/storage/models/orders_modal/order_driver_model.dart';
import 'package:producer_family_app/storage/models/orders_modal/order_user_modal.dart';

class OrderController {

  Future<bool> MakeOrderUserController(
      {required BuildContext context,
         String client_notes='',
         String shipping_lat='',
         String shipping_lng='',
         String shipping_to='',
         String  order_details='',
         String  family_id='',
         String  language="",
      }) async {
    var url = Uri.parse(ApiLinks.makeorder);

    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader:
      SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'accept': 'application/json',
      'Accept-country': '1',
      'Accept-Language': language
    }, body: {
      "family_id":family_id,
      "client_notes":client_notes,
      "shipping_lat":shipping_lat,
      "shipping_lng":shipping_lng,
      "shipping_to":shipping_to,
      "order_details":
      order_details
    },);
    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      print (jsonResponse);
      if (context != null)
        Helper(context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(context: context,
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

  Future MakeOrderIdUserController(
      { BuildContext? context,
        String client_notes='',
        String shipping_lat='',
        String shipping_lng='',
        String shipping_to='',
        String  order_details='',
        String  family_id='',
        String  language="",


      }) async {
    var url = Uri.parse(ApiLinks.makeorder);

    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader:
      SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'accept': 'application/json',
      'Accept-country': '1',
      'Accept-Language': language

    }, body: {
      "family_id":family_id,
      "client_notes":client_notes,
      "shipping_lat":shipping_lat,
      "shipping_lng":shipping_lng,
      "shipping_to":shipping_to,
      "order_details":
      order_details },);
    if (response.statusCode < 400) {
      Map<String, dynamic> jsonMap =
      Map<String, dynamic>.from(json.decode(response.body)['data']);
      return jsonMap;
    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else {
      if (context != null)
        Helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return {};
  }
//*********************************************************************************************
  Future<bool> ConfirmOrderUserController(
      {BuildContext? context,
        required String order_id,
         String language='',

      }) async {
    var url = Uri.parse(ApiLinks.order_user_confirm);
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader:
      SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'accept': 'application/json',
      'Accept-country': '1',
      'Accept-Language': language
    }, body: {
      "order_id":order_id,
    },);
    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(context: context,
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
  Future GetCartUserController(
      {BuildContext? context,
        required  String order_id,
        required   String coupon,
        required  String language,

      }) async {
    var url = Uri.parse(ApiLinks.getcart);
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader:
      SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'accept': 'application/json',
      'Accept-country': '1',
      'Accept-Language': language
    }, body: {
      "order_id":order_id,
      "coupon":coupon,
    },);
    if (response.statusCode < 400) {
      Map<String, dynamic> jsonMap =
      Map<String, dynamic>.from(json.decode(response.body)['data']);
      return jsonMap;

    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else {
      if (context != null)
        Helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return {};
  }
//*********************************************************************************************
  Future ConfirmCopounController(
      {BuildContext? context,
        String? order_cost,
        String? coupon,
        String language='',

      }) async {
    var url = Uri.parse(ApiLinks.confirm_coupon);
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader:
      SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'accept': 'application/json',
      'Accept-country': '1',
      'Accept-Language': language
    }, body: {
      "order_cost":order_cost,
      "coupon":coupon,
    },);
    if (response.statusCode < 400) {

      // if (context != null)
      //   Helper(context: context,
      //       message: jsonDecode(response.body)['data'].toString(),
      //       error: true);
      Map<String, dynamic> jsonMap =
      Map<String, dynamic>.from(json.decode(response.body));
      return jsonMap;
    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else {
      if (context != null)
        Helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return {};
  }
//*********************************************************************************************
  Future<bool> PaymentOrderUserController(
      {BuildContext? context,
        String? order_id,
        String? payment_method,
        String? order_cost,
        String? coupon,
        String? total_cost,
         String language='',
      }) async {
    var url = Uri.parse(ApiLinks.order_user_payment);
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader:
      SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'accept': 'application/json',
      'Accept-country': '1',
      'Accept-Language': 'ar'
    }, body: {
      "order_id":order_id,
      "payment_method":payment_method,
      "order_cost":order_cost,
      "coupon":coupon,
      "total_cost":total_cost
    },);
    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else {
      if (context != null)
        Helper(
            context: context,
            message:jsonDecode(response.body)['message'],
            error: true);
    }
    return false;
  }
//*********************************************************************************************
  Future<bool> CancelOrderUserController(
      {BuildContext? context,
        required String order_id,
        required  String language,
      }) async {
    var url = Uri.parse(ApiLinks.order_user_cancel);

    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader:
      SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'accept': 'application/json',
      'Accept-country': '2',
      'Accept-Language': language

    }, body: {
      "order_id":order_id,
    },);
    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);


    } else if (response.statusCode == 500) {

      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return false;
  }
//*********************************************************************************************
  Future<bool> RefreshOrderUserController(
      {BuildContext? context,
        required  String language,

      }) async {
    var url = Uri.parse(ApiLinks.findDelivery);

    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader:
      SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'accept': 'application/json',
      'Accept-Language': language

    },
    );
    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);

    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return false;
  }
//*********************************************************************************************

  Future<bool> ConfirmDeliveryOrderUserController(
      {BuildContext? context,
        required String id,
         String language="",

      }) async {
    var url = Uri.parse(ApiLinks.user_delivery_request_confirm);

    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader:
      SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'accept': 'application/json',
      'Accept-country': '2',
      'Accept-Language': language

    }, body: {
      "id":id,
    },);
    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);

    } else if (response.statusCode == 500) {

      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return false;
  }


//*********************************************************************************************

  Future<bool> DeliveredDeliveryOrderUserController(
      {BuildContext? context,
        required String order_id,
         String language='',

      }) async {
    var url = Uri.parse(ApiLinks.order_user_delivered);

    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader:
      SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'accept': 'application/json',
      'Accept-country': '1',
      'Accept-Language': language

    }, body: {
      "order_id":order_id,
    },);
    if (response.statusCode < 400) {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);

    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return false;
  }

  //*********************************************************************************************

  Future <List<GetUserOrdersModal>>getOrdersController({BuildContext? context,String language=""}) async {
    var url = Uri.parse(ApiLinks.getuserOrders);

    var response = await http.get(url, headers:
    {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'accept': 'application/json',
      'Accept-Language': language,
      'Accept-country': '1'
    }, );

    if (response.statusCode < 400) {
      var jsonArray = jsonDecode(
          response.body)['data']as List;

      List<GetUserOrdersModal> orders = jsonArray
          .map((jsonObject) => GetUserOrdersModal.fromJson(jsonObject))
          .toList();
      return orders;
    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(context: context,
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
  Future getOrdersFollowController({BuildContext? context}) async {
    var url = Uri.parse(ApiLinks.getuserOrders);

    var response = await http.get(url, headers:
    {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
       'accept': 'application/json',
      'Accept-Language': "ar",
      'Accept-country': '1'
    }, );

    if (response.statusCode < 400) {
      var jsonArray = jsonDecode(
          response.body)['data']as List;

      List<GetUserFollowOrdersModal> orders = jsonArray
          .map((jsonObject) => GetUserFollowOrdersModal.fromJson(jsonObject))
          .toList();
      return orders;
    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(context: context,
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

  Future rateOrdersController({BuildContext? context,
    required String family_id,
    required String delivery_id,
    required String order_id,
    required String comment,
    required String rate,
     String language='',
    required String delivery_rate,


  }) async {
    var url = Uri.parse(ApiLinks.order_user_add_rate);

    var response = await http.post(url, headers:
    {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
         'accept': 'application/json',
      'Accept-Language':language,
      'Accept-country': '2'
    }, body: {
      "family_id": family_id,
      "delivery_id": delivery_id,
      "order_id": order_id,
      "comment": comment,
      "rate": rate,
      "delivery_rate": delivery_rate,
    });

    if (response.statusCode < 400) {

      if (context != null)

        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else if (response.statusCode == 500) {


      if (context != null)
        Helper(context: context,
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

  Future reportOrdersController({BuildContext? context,
    required String report_type,
    required String order_id,
    required String report,
     String language="",


  }) async {
    var url = Uri.parse(ApiLinks.makereport);

    var response = await http.post(url, headers:
    {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'accept': 'application/json',
      'Accept-Language': language,
      'Accept-country': '1'
    }, body: {
      "report_type": report_type,
      "order_id": order_id,
      "report": report,

    });

    if (response.statusCode < 400) {
      if (context != null)

        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else if (response.statusCode == 500) {

      if (context != null)
        Helper(context: context,
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
  Future getOrdersDriverController({BuildContext? context,String language=""}) async {
    var url = Uri.parse(ApiLinks.getdeliveryOrders);

    var response = await http.get(url, headers:
    {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
         'accept': 'application/json',
      'Accept-Language': language,
      'Accept-country': '1'
    }, );

    if (response.statusCode < 400) {
      var jsonArray = jsonDecode(
          response.body)['data']as List;

      List<OrderDriverModal> orders = jsonArray
          .map((jsonObject) => OrderDriverModal.fromJson(jsonObject))
          .toList();
      return orders;
    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(context: context,
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
  Future<bool> requestOrderDriverController(
      {BuildContext? context,
        required String order_id,
        required String delivery_duration,
        required String delivery_duration_unit,
        required String shipping_cost,
        String language="",



      }) async {
    var url = Uri.parse(ApiLinks.order_delivery_request);

    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader:
      SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'accept': 'application/json',
      'Accept-country': '1',
      'Accept-Language':language

    }, body: {
      "order_id":order_id,
      "delivery_duration":delivery_duration,
      "delivery_duration_unit":delivery_duration_unit,
      "shipping_cost":shipping_cost,

    },);
    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);

    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return false;
  }
  //*********************************************************************************************
  Future<bool> requestOrderFamilyController(
      {BuildContext? context,
        required String order_id,
        required String order_duration,
        required String order_duration_unit,
        required String family_notes,
         String language="",



      }) async {
    var url = Uri.parse(ApiLinks.order_family_confirm);

    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader:
      SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'accept': 'application/json',
      'Accept-country': '1',
      'Accept-Language': language

    }, body: {
      "order_id":order_id,
      "order_duration":order_duration,
      "order_duration_unit":order_duration_unit,
      "family_notes":family_notes,

    },);
    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);

    } else if (response.statusCode == 500) {

      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return false;
  }
//*********************************************************************************************
  Future<bool> rateMeOrderFamilyController(
      {BuildContext? context,
        required String order_id,
        String language="",


      }) async {
    var url = Uri.parse(ApiLinks.order_family_rate_me);

    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader:
      SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'accept': 'application/json',
      'Accept-country': '1',
      'Accept-Language': language

    }, body: {
      "order_id":order_id,


    },);
    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);

    } else if (response.statusCode == 500) {

      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return false;
  }
//*********************************************************************************************

  Future getOrdersFamilyController({BuildContext? context,String language=''}) async {
    var url = Uri.parse(ApiLinks.getfamilyOrders);

    var response = await http.get(url, headers:
    {
     "Authorization":
"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImUzZGI4Y2JmMWFlYTk3ZmE2YTIzODY0OTc3MDdlZmYyZDI4NjliYjU5YmUyYTIxN2UxOTM1YzMyNzkwZTEyZGU3NjNkODRjMDllYmRiNzk5In0.eyJhdWQiOiIxIiwianRpIjoiZTNkYjhjYmYxYWVhOTdmYTZhMjM4NjQ5NzcwN2VmZjJkMjg2OWJiNTliZTJhMjE3ZTE5MzVjMzI3OTBlMTJkZTc2M2Q4NGMwOWViZGI3OTkiLCJpYXQiOjE2Mjc4Mzc4NDYsIm5iZiI6MTYyNzgzNzg0NiwiZXhwIjoxNjU5MzczODQ2LCJzdWIiOiIzIiwic2NvcGVzIjpbXX0.GAZuYUdyJBVYjUChyf3ilej9woMIniyFutMqxmGR2tfnEaRhn16ykYey0-BDpdVVdD1qVa2oqhrT-hts0VtC2h7h_ziciuJX7B1OBjPkF_xlfvJ8xQLX9_33qTzQl12xhGthb1vnBBHrwhQSjy7H2U0bgFQxu2x-hhNeAEokjZdoZRxv3kUKgCk0M1uGSK7oZkywxHI3T1V0Mc44GZ5MBhxeaqtqvvpdrzt-vXJqfre548fYaG5YwBpfDkwsOBaSc4vJK_pJrBS8o8MuvA-ajYl_GMvfx5UqG4pIMez4Xl5gX86tKbtRPQ-hfWTS5lLGj-vgGdVG5jSZ31v_GrXpmpK69PFEdmXT1kD4aqGkBQ2Sx2N9TfAixjgb0yTtyBQNG7F5GYZKINpzyqqoVI404LmMmRWrdCHeI8RMCvZ2n5dkUOTbbTGctpMItdOPJTFJNE-Uw-tSBYPXOBeXcOkTcPWL3J7tPN8qB16oLETxZyOB1U5S3aiiLGSJPFVpgXNtPC2x10HCowWZKitDfLmbJ96kICQfuq05kyWioe5fcKOY1Lr8HKwINtm1nbVV4hKWW09bHFuPoKMsc29dpWFO8omoBp3ACXmlNh4Y3_F_7y8aai3T6QqrsF6i5tET_z8VhFIpNyam_1y3IYz0zH9-lkjsRwdxMnaFA_tk9loufsY"
     ,
    // HttpHeaders.authorizationHeader: SharedPreferencesController().token,
       'accept': 'application/json',
      'Accept-Language': language,
      'Accept-country': '1'
    }, );

    if (response.statusCode < 400) {
      var jsonArray = jsonDecode(
          response.body)['data']as List;

      List<OrderFamilyModal> orders = jsonArray
          .map((jsonObject) => OrderFamilyModal.fromJson(jsonObject))
          .toList();
      return orders;
    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(context: context,
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
  Future<bool> readyOrderFamilyController(
      {BuildContext? context,
        required String order_id,
         String language="",



      }) async {
    var url = Uri.parse(ApiLinks.order_family_ready);

    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader:
      SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'accept': 'application/json',
      'Accept-country': '1',
      'Accept-Language': language

    }, body: {
      "order_id":order_id,


    },);
    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
return true;
    } else if (response.statusCode == 500) {

      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else {
      if (context != null)
        Helper(context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return false;
  }
//*********************************************************************************************

}