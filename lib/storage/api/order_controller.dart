import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/api_links.dart';
import 'package:producer_family_app/storage/models/orders_modal/get_order_delivery_requests_modal.dart';
import 'package:producer_family_app/storage/models/orders_modal/new_order_driver_modal.dart';
import 'package:producer_family_app/storage/models/orders_modal/order_driver_model.dart';
import 'package:producer_family_app/storage/models/orders_modal/order_family_modal.dart';
import 'package:producer_family_app/storage/models/orders_modal/order_user_modal.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';

class OrderController {
  Future makeOrderIdUserController({
    BuildContext? context,
    String clientNotes = '',
    String shippingLat = '',
    String shippingLng = '',
    String shippingTo = '',
    required List orderDetails,
    required int familyId,
    String language = "",
  }) async {
    var url = Uri.parse(ApiLinks.makeorder);
    String encoded = json.encode(orderDetails);
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'Accept-country': '1',
        'Accept-Language': language
      },
      body: {
        "family_id": familyId.toString(),
        "client_notes": clientNotes,
        "shipping_lat": shippingLat,
        "shipping_lng": shippingLng,
        "shipping_to": shippingTo,
        "order_details": encoded
      },
    );
    if (response.statusCode < 400) {
      Map<dynamic, dynamic> jsonMap =
          Map<dynamic, dynamic>.from(json.decode(response.body)['data']);
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
  Future<bool> confirmOrderUserController({
    BuildContext? context,
    required int orderId,
    String language = '',
  }) async {
    var url = Uri.parse(ApiLinks.orderUserConfirm);
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'Accept-country': '1',
        'Accept-Language': language
      },
      body: {
        "order_id": orderId.toString(),
      },
    );
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
  Future getCartUserController({
    BuildContext? context,
    required int orderId,
    required String coupon,
    required String language,
  }) async {
    var url = Uri.parse(ApiLinks.getcart);
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'Accept-country': '1',
        'Accept-Language': language
      },
      body: {
        "order_id": orderId.toString(),
        "coupon": coupon.toString(),
      },
    );
    if (response.statusCode < 400) {
      Map<dynamic, dynamic> jsonMap =
          Map<dynamic, dynamic>.from(json.decode(response.body)['data']);
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
  Future confirmCopounController({
    BuildContext? context,
    double? orderCost,
    String? coupon,
    required int orderId,
    String language = '',
  }) async {
    var url = Uri.parse(ApiLinks.confirmCoupon);
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'Accept-country': '1',
        'Accept-Language': language
      },
      body: {
        "order_cost": orderCost.toString(),
        "coupon": coupon,
        "order_id": orderId.toString(),
      },
    );

    if (response.statusCode < 400) {
      if (context != null) {
        helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
      }
      var jsonResponse = jsonDecode(response.body)['data'] as dynamic;
      return jsonResponse;
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
  Future<bool> paymentOrderUserController({
    BuildContext? context,
    required int orderId,
    int? paymentMethod,
    double? orderCost,
    int? coupon,
    double? totalCost,
    String language = '',
  }) async {
    var url = Uri.parse(ApiLinks.orderUserPayment);
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'Accept-country': '1',
        'Accept-Language': 'ar'
      },
      body: {
        "order_id": orderId.toString(),
        "payment_method": paymentMethod.toString(),
        "order_cost": orderCost.toString(),
        "coupon": coupon.toString(),
        "total_cost": totalCost.toString(),
      },
    );
    if (response.statusCode < 400) {
      String message = Localizations.localeOf(context!).languageCode == "ar"
          ? "تم تأكيد الدفع من جهة العميل بنجاح"
          : "Client Confirmed payment Successfully";
      return jsonDecode(response.body)['message'] == message ? true : false;
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
  Future<bool> cancelOrderUserController({
    BuildContext? context,
    required String orderId,
    required String language,
  }) async {
    var url = Uri.parse(ApiLinks.orderUserCancel);
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'Accept-country': '2',
        'Accept-Language': language
      },
      body: {
        "order_id": orderId,
      },
    );
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
  Future<bool> refreshOrderUserController({
    BuildContext? context,
    int? orderNo,
    required String language,
  }) async {
    var url = Uri.parse(ApiLinks.findDelivery);
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'Accept-country': '2',
        'Accept-Language': language
      },
      body: {
        "order_id": orderNo.toString(),
      },
    );
    if (response.statusCode < 400) {
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

  Future<bool> confirmDeliveryOrderUserController({
    BuildContext? context,
    required int id,
    String language = "",
  }) async {
    var url = Uri.parse(ApiLinks.userDeliveryRequestConfirm);
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'Accept-country': '2',
        'Accept-Language': language
      },
      body: {
        "id": id.toString(),
      },
    );
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

  Future<bool> deliveredDeliveryOrderUserController({
    BuildContext? context,
    required int orderId,
    String language = '',
  }) async {
    var url = Uri.parse(ApiLinks.orderUserDelivered);
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'Accept-country': '1',
        'Accept-Language': language
      },
      body: {
        "order_id": orderId.toString(),
      },
    );
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

  Future<List<GetUserOrdersModal>> getOrdersController(
      {BuildContext? context, String language = ""}) async {
    var url = Uri.parse(ApiLinks.getuserOrders);

    var response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'accept': 'application/json',
        'Accept-Language': language,
        'Accept-country': '1'
      },
    );

    if (response.statusCode < 400) {
      if (jsonDecode(response.body)['data'][0] != null) {
        var jsonArray = jsonDecode(response.body)['data'] as List;
        List<GetUserOrdersModal> orders = jsonArray
            .map((jsonObject) => GetUserOrdersModal.fromJson(jsonObject))
            .toList();
        return orders;
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

  Future<List<GetOrderDeliveryRequestsModal>>
      getOrderDeliveryRequestsController({
    BuildContext? context,
    String language = "",
    required int orderId,
  }) async {
    var url = Uri.parse(ApiLinks.getOrderDeliveryRequests);

    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'Accept-country': '1',
        'Accept-Language': language
      },
      body: {
        "order_id": orderId.toString(),
      },
    );

    if (response.statusCode < 400) {
      if (jsonDecode(response.body)['data'][0] != null) {
        var jsonArray = jsonDecode(response.body)['data'] as List;
        List<GetOrderDeliveryRequestsModal> delivers = jsonArray
            .map((jsonObject) =>
                GetOrderDeliveryRequestsModal.fromJson(jsonObject))
            .toList();
        return delivers;
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

  Future<bool> rateOrdersController({
    BuildContext? context,
    required String familyId,
    required String deliveryId,
    required String orderId,
    required String comment,
    required String rate,
    String language = '',
    required String deliveryRate,
  }) async {
    var url = Uri.parse(ApiLinks.orderUserAddRate);
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'accept': 'application/json',
      'Accept-Language': language,
      'Accept-country': '2'
    }, body: {
      "family_id": familyId,
      "delivery_id": deliveryId,
      "order_id": orderId,
      "comment": comment,
      "rate": rate,
      "delivery_rate": deliveryRate,
    });

    if (response.statusCode < 400) {
      if (context != null) {
        helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
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
    return false;
  }

//*********************************************************************************************

  Future<bool> reportOrdersController({
    BuildContext? context,
    required String reportType,
    required int orderId,
    required String report,
    String language = "",
  }) async {
    var url = Uri.parse(ApiLinks.makeReport);

    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'accept': 'application/json',
      'Accept-Language': language,
      'Accept-country': '1'
    }, body: {
      "report_type": reportType,
      "order_id": orderId.toString(),
      "report": report,
    });

    if (response.statusCode < 400) {
      if (context != null) {
        helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
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
    return false;
  }

//*********************************************************************************************
  Future<List<OrderDriverModal>> getOrdersDriverController(
      {BuildContext? context, String language = ""}) async {
    var url = Uri.parse(ApiLinks.getdeliveryOrders);

    var response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'accept': 'application/json',
        'Accept-Language': language,
        'Accept-country': '1'
      },
    );

    if (response.statusCode < 400) {
      // if( jsonDecode(response.body)['data'][0]!=null){
      var jsonArray = jsonDecode(response.body)['data'] as List;

      List<OrderDriverModal> orders = jsonArray
          .map((jsonObject) => OrderDriverModal.fromJson(jsonObject))
          .toList();
      return orders;
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
  Future<List<NewOrderDriverModal>> getNewOrdersDriverController(
      {BuildContext? context, String language = ""}) async {
    var url = Uri.parse(ApiLinks.getdeliveryNewOrders);

    var response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'accept': 'application/json',
        'Accept-Language': language,
        'Accept-country': '1'
      },
    );

    if (response.statusCode < 400) {
      // if( jsonDecode(response.body)['data'][0]!=null){
      var jsonArray = jsonDecode(response.body)['data'] as List;

      List<NewOrderDriverModal> orders = jsonArray
          .map((jsonObject) => NewOrderDriverModal.fromJson(jsonObject))
          .toList();
      return orders;
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
  Future<bool> requestOrderDriverController({
    BuildContext? context,
    required int orderId,
    required int deliveryDuration,
    required String deliveryDurationUnit,
    required int shippingCost,
    String language = "",
  }) async {
    var url = Uri.parse(ApiLinks.orderDeliveryRequest);
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'Accept-country': '1',
        'Accept-Language': language
      },
      body: {
        "order_id": orderId.toString(),
        "delivery_duration": deliveryDuration.toString(),
        "delivery_duration_unit": deliveryDurationUnit,
        "shipping_cost": shippingCost.toString(),
      },
    );
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
  Future<bool> requestOrderFamilyController({
    BuildContext? context,
    required int orderId,
    required String orderDuration,
    required String orderDurationUnit,
    required String familyNotes,
    String language = "",
  }) async {
    var url = Uri.parse(ApiLinks.orderFamilyConfirm);

    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'Accept-country': '1',
        'Accept-Language': language
      },
      body: {
        "order_id": orderId.toString(),
        "order_duration": orderDuration,
        "order_duration_unit": orderDurationUnit,
        "family_notes": familyNotes,
      },
    );
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
  Future<bool> rateMeOrderFamilyController({
    BuildContext? context,
    required String orderId,
    String language = "",
  }) async {
    var url = Uri.parse(ApiLinks.orderFamilyRateMe);

    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'Accept-country': '1',
        'Accept-Language': language
      },
      body: {
        "order_id": orderId,
      },
    );
    if (response.statusCode < 400) {
      if (context != null) {
        helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
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
    return false;
  }
//*********************************************************************************************

  Future<List<OrderFamilyModal>> getOrdersFamilyController(
      {BuildContext? context, String language = ''}) async {
    var url = Uri.parse(ApiLinks.getfamilyOrders);

    var response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'accept': 'application/json',
        'Accept-Language': language,
        'Accept-country': '1'
      },
    );
    if (response.statusCode < 400) {
      if (jsonDecode(response.body)['data'][0] != null) {
        var jsonArray = jsonDecode(response.body)['data'] as List;

        List<OrderFamilyModal> orders = jsonArray
            .map((jsonObject) => OrderFamilyModal.fromJson(jsonObject))
            .toList();
        return orders;
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
  Future<bool> readyOrderFamilyController({
    BuildContext? context,
    required int orderId,
    String language = "",
  }) async {
    var url = Uri.parse(ApiLinks.orderFamilReady);
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'Accept-country': '1',
        'Accept-Language': language
      },
      body: {
        "order_id": orderId.toString(),
      },
    );
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

}
