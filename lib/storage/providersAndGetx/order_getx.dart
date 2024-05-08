import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/api/order_controller.dart';
import 'package:producer_family_app/storage/models/orders_modal/get_order_delivery_requests_modal.dart';
import 'package:producer_family_app/storage/models/orders_modal/new_order_driver_modal.dart';
import 'package:producer_family_app/storage/models/orders_modal/order_driver_model.dart';
import 'package:producer_family_app/storage/models/orders_modal/order_family_modal.dart';
import 'package:producer_family_app/storage/models/orders_modal/order_user_modal.dart';

import '../../components/show_helper.dart';

class getOrderGetX extends GetxController {
  String language;
  getOrderGetX({this.language = ""});
  RxList<GetUserOrdersModal> orders = <GetUserOrdersModal>[].obs;
  var isLoading = true.obs;
  static getOrderGetX get to => Get.find();
  @override
  void onInit() {
    getvalues();
    super.onInit();
  }

  Future<void> getvalues({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await OrderController()
          .getOrdersController(context: context, language: language);
      if (show != null) {
        orders.value = show;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> cancelOrder(
      {required BuildContext context, required int id}) async {
    bool canceled = await OrderController().cancelOrderUserController(
        context: context,
        orderId: id.toString(),
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en");

    if (canceled) {
      getvalues();
    }
  }

  Future<void> confirmDeliveryOrder(
      {required BuildContext context, required int id}) async {
    bool confirm = await OrderController().confirmDeliveryOrderUserController(
        context: context,
        id: id,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en");

    if (confirm) {
      getvalues();
    }
  }

  Future<void> refreshData() async {
    await getvalues();
  }

  Future<void> payment(
      {required BuildContext context,
      required int order_id_page,
      required int coupon,
      required int groupValue,
      required double order_cost,
      required double total_cost}) async {
    bool paymentOrder = await OrderController().paymentOrderUserController(
        context: context,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
        orderId: order_id_page,
        coupon: coupon,
        paymentMethod: groupValue,
        orderCost: order_cost,
        totalCost: total_cost);
    if (paymentOrder) {
      getvalues();
      // if (context != null) {
      helper(
          context: context,
          message: Localizations.localeOf(context).languageCode == "ar"
              ? "تم تأكيد الدفع من جهة العميل بنجاح"
              : "Client Confirmed payment Successfully",
          error: true);
      // }

      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => const MainScreen(
      //               currentIndex: 1,
      //               orderIndex: 0,
      //             )));
    }
  }

  Future<void> Delivered(
      {required BuildContext context, required int order_id}) async {
    bool Delivered =
        await OrderController().deliveredDeliveryOrderUserController(
      context: context,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      orderId: order_id,
    );
    if (Delivered) getvalues();
  }
}

//**************************************************************************
class GetOrderDeliveryRequestsGetX extends GetxController {
  String language;
  int order_id;
  GetOrderDeliveryRequestsGetX({this.language = "", required this.order_id});
  RxList<GetOrderDeliveryRequestsModal> delivers =
      <GetOrderDeliveryRequestsModal>[].obs;
  var isLoading = true.obs;
  static GetOrderDeliveryRequestsGetX get to => Get.find();
  @override
  void onInit() {
    getvalues();
    super.onInit();
  }

  Future<void> getvalues({
    BuildContext? context,
  }) async {
    isLoading(true);
    try {
      var show = await OrderController().getOrderDeliveryRequestsController(
          context: context, language: language, orderId: order_id);
      if (show != null) {
        delivers.value = show;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> confirmDeliveryOrder(
      {required BuildContext context, required int id}) async {
    bool confirm = await OrderController().confirmDeliveryOrderUserController(
        context: context,
        id: id,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en");

    if (confirm) {
      getvalues();
    }
  }

  Future<void> refreshData() async {
    getvalues();
  }
}

//**************************************************************************

// class getOrderFollowGetX extends GetxController {
//   RxList<GetUserFollowOrdersModal> orders = <GetUserFollowOrdersModal>[].obs;
//   static getOrderFollowGetX get to => Get.find();
//   var isLoading = true.obs;
//   @override
//   void onInit() {
//     getvalues();
//     super.onInit();
//   }
//
//   Future<void> getvalues({BuildContext? context}) async {
//     isLoading(true);
//     try {
//       var show = await OrderController().getOrdersFollowController(
//         context: context,
//       );
//       if (show != null) {
//         orders.value = show;
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
// }

//**************************************************************************
class getOrderDriverGetX extends GetxController {
  RxList<OrderDriverModal> orders = <OrderDriverModal>[].obs;
  String language;
  getOrderDriverGetX({this.language = ""});
  var isLoading = true.obs;
  static getOrderDriverGetX get to => Get.find();
  @override
  void onInit() {
    getvalues();
    super.onInit();
  }

  Future<void> getvalues({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await OrderController()
          .getOrdersDriverController(context: context, language: language);
      if (show != null) {
        orders.value = show;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshValues() async {
    // print("refreshhh");
    await getvalues();
  }

  Future<void> updateProfile(
      {BuildContext? context,
      String? path2,
      String? path1,
      String notes = '',
      String ennotes = '',
      String minimum_order = '',
      String name = '',
      dynamic lat,
      dynamic lng,
      String address = '',
      String email = '',
      String phone = '',
      Function(bool status)? uploadEvent}) async {
    await LoginAndProfileController().updateProfileController(context,
        path2: path2,
        path1: path1,
        notes: notes,
        ennotes: ennotes,
        minimumOrder: minimum_order,
        name: name,
        lat: lat,
        lng: lng,
        address: address,
        email: email,
        phone: phone,
        language: context != null
            ? Localizations.localeOf(context).languageCode == "ar"
                ? "ar"
                : "en"
            : "ar", uploadEvent: (bool status) {
      {
        return true;
      }
    });
    // print(updateIt );
    // if(updateIt){
    getvalues();
    //   print(updateIt );
    // }
  }
}

//**************************************************************************
class getNewOrderDriverGetX extends GetxController {
  RxList<NewOrderDriverModal> newOrders = <NewOrderDriverModal>[].obs;
  String language;
  getNewOrderDriverGetX({this.language = ""});
  var isLoading = true.obs;
  static getNewOrderDriverGetX get to => Get.find();
  @override
  void onInit() {
    getvalues();
    super.onInit();
  }

  Future<void> getvalues({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await OrderController()
          .getNewOrdersDriverController(context: context, language: language);
      if (show != null) {
        newOrders.value = show;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshValues() async {
    // print("refreshhh");
    getvalues();
  }

  Future<void> requestOrder({
    required BuildContext context,
    required String delivery_duration_unit,
    required int order_id,
    // ignore: non_constant_identifier_names
    required int delivery_duration,
    required int shipping_cost,
  }) async {
    bool requestIt = await OrderController().requestOrderDriverController(
      context: context,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      orderId: order_id,
      deliveryDurationUnit: delivery_duration_unit,
      shippingCost: shipping_cost,
      deliveryDuration: delivery_duration,
    );
    // print(requestIt);
    if (requestIt) {
      getvalues();
    }
  }
}

//**************************************************************************
class getOrderFamilyGetX extends GetxController {
  RxList<OrderFamilyModal> orders = <OrderFamilyModal>[].obs;
  var isLoading = true.obs;
  String language;
  getOrderFamilyGetX({this.language = ""});
  static getOrderFamilyGetX get to => Get.put(getOrderFamilyGetX());
  @override
  void onInit() {
    getvalues();
    super.onInit();
  }

  Future<void> getvalues({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await OrderController()
          .getOrdersFamilyController(context: context, language: language);
      if (show != null) {
        orders.value = show;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshData() async {
    await getvalues();
  }

  Future<void> deleteData({required int id}) async {
    orders.removeWhere((element) => element.id == id);
    // await getvalues();
  }

  Future<void> requestOrder({
    required BuildContext context,
    required String family_notes,
    required String order_duration_unit,
    required String order_duration,
    required int order_id,
  }) async {
    bool requestIt = await OrderController().requestOrderFamilyController(
      context: context,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      orderId: order_id,
      familyNotes: family_notes,
      orderDurationUnit: order_duration_unit,
      orderDuration: order_duration,
    );
    // print(requestIt);
    if (requestIt) {
      getvalues();
    }
  }

  Future<void> readyOrder({
    required BuildContext context,
    required int order_id,
  }) async {
    bool readyOrder = await OrderController().readyOrderFamilyController(
      context: context,
      orderId: order_id,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
    );
    // print(readyOrder);
    if (readyOrder) {
      getvalues();
    }
    getvalues();
  }
}

//**************************************************************************
class getMakeOrderIdGetx extends GetxController {
  RxMap<dynamic, dynamic> makeOrderId = <dynamic, dynamic>{}.obs;
  static getMakeOrderIdGetx get to => Get.find();
  var isLoading = true.obs;
  String language;
  int family_id;
  String shipping_to;
  List order_details;
  String shipping_lng;
  String shipping_lat;
  String client_notes;
  getMakeOrderIdGetx(
      {this.language = '',
      required this.family_id,
      this.shipping_lat = '',
      required this.order_details,
      this.client_notes = '',
      this.shipping_lng = '',
      this.shipping_to = ''});
  @override
  void onInit() {
    getMakeOrderId();
    super.onInit();
  }

  Future<void> getMakeOrderId({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await OrderController().makeOrderIdUserController(
        context: context,
        language: language,
        familyId: family_id,
        orderDetails: order_details,
        shippingTo: shipping_to,
        shippingLng: shipping_lng,
        shippingLat: shipping_lat,
        clientNotes: client_notes,
      );
      if (show != null) {
        makeOrderId.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

//**************************************************************************
class getCartOrderIdGetx extends GetxController {
  RxMap<dynamic, dynamic> getCartOrder = <dynamic, dynamic>{}.obs;
  static getCartOrderIdGetx get to => Get.find();
  var isLoading = true.obs;
  String language;
  int order_id;
  String coupon;

  getCartOrderIdGetx(
      {this.language = 'ar', this.coupon = '', this.order_id = 0});
  @override
  void onInit() {
    getCart(order_idd: order_id);
    super.onInit();
  }

  Future<void> getCart({BuildContext? context, required int order_idd}) async {
    isLoading(true);
    try {
      var show = await OrderController().getCartUserController(
          context: context,
          language: language,
          orderId: order_idd,
          coupon: coupon);
      if (show != null) {
        getCartOrder.value = show;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshValues({required int order_id_2}) async {
    // print("refreshhh");
    getCart(order_idd: order_id_2);
  }

  // Future<void> confirmDeliveryOrder(
  //     {required BuildContext context, required int id,required int order_id_2}) async {
  //   bool confirm = await OrderController().ConfirmDeliveryOrderUserController(
  //       context: context,
  //       id: id,
  //       language:
  //       Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en");
  //
  //   if (confirm) {
  //     getCart(order_idd: order_id_2);
  //   }
  // }

  Future<void> ConfirmCopounController(
      {required BuildContext context,
      required double order_cost,
      required int order_id_2,
      required String coupon}) async {
    await OrderController().confirmCopounController(
      context: context,
      orderId: order_id_2,
      orderCost: order_cost,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      coupon: coupon,
    );

    // if (confirm) {
    getCart(order_idd: order_id_2);
    // }
  }
}

//**************************************************************************
// class confirmCopounGetx extends GetxController {
//   RxMap<String, dynamic> confirmCopoun = <String, dynamic>{}.obs;
//   static confirmCopounGetx get to => Get.find();
//   var isLoading = true.obs;
//   String language;
//   double order_cost;
//   int coupon;
//
//   confirmCopounGetx(
//       {required this.language, required this.coupon, required this.order_cost});
//   @override
//   void onInit() {
//     super.onInit();
//     getConfirmCopoun();
//   }
//
//   Future<void> getConfirmCopoun({BuildContext? context}) async {
//     isLoading(true);
//     try {
//       var show = await OrderController().ConfirmCopounController(
//           context: context,
//           language: language,
//           order_cost: order_cost,
//           coupon: coupon);
//       if (show != null) {
//         confirmCopoun.value = show;
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
//   // Future<void> getCopoun({required BuildContext context,
//   //   required String coupon,
//   //   required String order_id,
//   //   required  String order_cost,
//   // }) async {
//   //   await OrderController().ConfirmCopounController(
//   //     context: context,
//   //       language: Localizations.localeOf(context).languageCode == "ar"
//   //           ? "ar"
//   //           : "en",
//   //         coupon: coupon,
//   //     order_cost: order_cost
//   //
//   //       );
//   // getConfirmCopoun();
//   //   getCartOrderIdGetx(coupon: coupon,order_id: order_id,language: language).getCart;
//   // }
// }
