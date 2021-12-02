import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:producer_family_app/storage/api/order_controller.dart';
import 'package:producer_family_app/storage/models/orders_modal/order_driver_model.dart';
import 'package:producer_family_app/storage/models/orders_modal/order_family_modal.dart';
import 'package:producer_family_app/storage/models/orders_modal/order_user_modal.dart';

class getOrderGetX extends GetxController {
  String language;
  getOrderGetX({this.language=""});
  RxList<GetUserOrdersModal> orders = <GetUserOrdersModal>[].obs;
  var isLoading=true.obs;
  static getOrderGetX get to => Get.find();
  @override
  void onInit() {
    getvalues();
    super.onInit();
  }
  Future<void> getvalues({BuildContext? context}) async {
    isLoading(true);
    try{
      var show = await OrderController().getOrdersController(context: context,language:language);
      if(show != null){
        orders.value =show;}
    }
    finally {
      isLoading(false);
    }
  }
}
//**************************************************************************
class getOrderFollowGetX extends GetxController {
  RxList<GetUserFollowOrdersModal> orders = <GetUserFollowOrdersModal>[].obs;
  static getOrderFollowGetX get to => Get.find();
  var isLoading=true.obs;
  @override
  void onInit() {
    getvalues();
    super.onInit();
  }
  Future<void> getvalues({BuildContext? context}) async {
    isLoading(true);
    try{
      var show = await OrderController().getOrdersFollowController(context: context,);
      if(show != null){
        orders.value =show;}
    }
    finally {
      isLoading(false);
    }
  }
}
//**************************************************************************
class getOrderDriverGetX extends GetxController {
  RxList<OrderDriverModal> orders = <OrderDriverModal>[].obs;
  String language;
  getOrderDriverGetX({this.language=""});
  var isLoading=true.obs;
  static getOrderDriverGetX get to => Get.find();
  @override
  void onInit() {
    getvalues();
    super.onInit();
  }
  Future<void> getvalues({BuildContext? context}) async {
    isLoading(true);
    try{
      var show = await OrderController().getOrdersDriverController(context: context,language:language);
      if(show != null){
        orders.value =show;}
    }
    finally {
      isLoading(false);
    }
  }
}
//**************************************************************************
class getOrderFamilyGetX extends GetxController {
  RxList<OrderFamilyModal> orders = <OrderFamilyModal>[].obs;
  var isLoading=true.obs;
String language;
  getOrderFamilyGetX({this.language=""});
  static getOrderFamilyGetX get to => Get.find();
  @override
  void onInit() {
    getvalues();
    super.onInit();
  }
  Future<void> getvalues({BuildContext? context}) async {
    isLoading(true);
    try{
      var show = await OrderController().getOrdersFamilyController(context: context,language:language );
      if(show != null){
        orders.value =show;}
    }
    finally {
      isLoading(false);
    }
  }
  Future<void> requestOrder({
    required BuildContext context,
    required String family_notes,
    required String order_duration_unit,
    required String order_duration,
    required String order_id,
  }) async {
    // bool edit =
    await  OrderController().requestOrderFamilyController(
      context: context,
      language:
      Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      order_id: order_id,
      family_notes: family_notes,
      order_duration_unit: order_duration_unit,
      order_duration:order_duration,
    );
  }
}
//**************************************************************************
class getMakeOrderIdGetx extends GetxController {
  RxMap<String, dynamic> makeOrderId =<String, dynamic>{}.obs ;
  static getMakeOrderIdGetx get to => Get.find();
  var isLoading=true.obs;
  String language;
  String family_id;
  String shipping_to;
  String order_details;
  String shipping_lng;
  String shipping_lat;
  String client_notes;
getMakeOrderIdGetx({this.language='',this.family_id='',this.shipping_lat='',this.order_details='',this.client_notes='',this.shipping_lng='',this.shipping_to=''});
  @override
  void onInit() {
    getMakeOrderId();
    super.onInit();
  }
  Future<void> getMakeOrderId({BuildContext? context}) async {
    isLoading(true);
    try{
      var show =
      await OrderController().MakeOrderIdUserController(
        context: context,language: language,
        family_id:family_id ,
        order_details:order_details ,
        shipping_to: shipping_to,
        shipping_lng: shipping_lng,
        shipping_lat: shipping_lat,
        client_notes: client_notes,);
      if(show != null){
        makeOrderId.value =show;}
    }
    finally {
      isLoading(false);
    }
  }
}


//**************************************************************************
class getCartOrderIdGetx extends GetxController {
  RxMap<String, dynamic> getCartOrder =<String, dynamic>{}.obs ;
  static getCartOrderIdGetx get to => Get.find();
  var isLoading=true.obs;
  String language;
  String order_id;
  String coupon;

  getCartOrderIdGetx({required this.language,required this.coupon,required this.order_id});
  @override
  void onInit() {
    getCart();
    super.onInit();
  }
  Future<void> getCart({BuildContext? context}) async {
    isLoading(true);
    try{
      var show =
      await OrderController().GetCartUserController(
        context: context,language: language, order_id:order_id ,coupon: coupon
      );
      if(show != null){
        getCartOrder.value =show;}
    }
    finally {
      isLoading(false);
    }
  }
}


//**************************************************************************
class confirmCopounGetx extends GetxController {
  RxMap<String, dynamic> confirmCopoun =<String, dynamic>{}.obs ;
  static confirmCopounGetx get to => Get.find();
  var isLoading=true.obs;
  String language;
  String order_cost;
  String order_id;
  String coupon;

  confirmCopounGetx({required this.language,required this.order_id,required this.coupon,required this.order_cost});
  @override
  void onInit() {
    getConfirmCopoun();
    super.onInit();
  }
  Future<void> getConfirmCopoun({BuildContext? context}) async {
    isLoading(true);
    try{
      var show =
      await OrderController().ConfirmCopounController(
          context: context,language: language, order_cost:order_cost ,coupon: coupon
      );
      if(show != null){
        confirmCopoun.value =show;}
    }
    finally {
      isLoading(false);
    }
  }
  Future<void> getCopoun({required BuildContext context,
    required String coupon,
    required  String order_cost,
  }) async {
    await OrderController().ConfirmCopounController(
      context: context,
        language: Localizations.localeOf(context).languageCode == "ar"
            ? "ar"
            : "en",
          coupon: coupon,
      order_cost: order_cost

        );
  getConfirmCopoun();
    getCartOrderIdGetx(coupon: coupon,order_id: order_id,language: language).getCart;
  }
}