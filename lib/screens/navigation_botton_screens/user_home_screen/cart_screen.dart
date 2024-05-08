import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/containers/card_waiting_delivery_user_order.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_dialoge.dart';
import 'package:producer_family_app/storage/api/order_controller.dart';
import 'package:producer_family_app/storage/database/db_provider.dart';
import 'package:producer_family_app/storage/models/cart.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/cart_getx_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:provider/provider.dart';

import '../../../components/show_helper.dart';
import '../../../storage/payment_gate/payment_screen.dart';
import 'main_screen.dart';

class CartScreen extends StatefulWidget {
  int userId;
  int currentStep;
  int? orderIdPage;
  int? proccessTime;
  int? noteFamily;
  bool disapearButtom = false;
  bool deliveryBool = false;
  getCartOrderIdGetx? controllerCartt;
  GetOrderDeliveryRequestsGetX? controllerDelivery;
  CartGetxController? myCart = Get.put(CartGetxController());

  CartScreen({
    this.userId = 0,
    this.orderIdPage,
    this.myCart,
    this.currentStep = 0,
    this.disapearButtom = false,
    this.deliveryBool = false,
    this.controllerCartt,
    this.controllerDelivery,
  });
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  getOrderGetX cont = Get.put(getOrderGetX());
  final _database = DbProvider().database;
  late TextEditingController coupon;
  String available = '1';
  int groupValue = 1;
  String shippingCost = '';
  late TextEditingController noteCustomer;

  @override
  void initState() {
    super.initState();
    managenotificationAction(context);
    noteCustomer = TextEditingController();
    coupon = TextEditingController();
    noteCustomer.addListener(() => setState(() {}));
    coupon.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    noteCustomer.dispose();
    coupon.dispose();

    didChangeDependencies();

    super.dispose();
  }

  List orderDetailsPage = [];
  List<Step> _mySteps() {
    List<Step> steps = [
      Step(
        state: StepState.indexed,
        title: StyleText(
          AppLocalizations.of(context)!.neworder,
        ),
        content: Container(
          padding: EdgeInsetsDirectional.only(
              top: hPadding, bottom: hPadding, end: wPadding, start: wPadding),
          margin: EdgeInsets.only(
            bottom: hSpaceLarge,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: kGrey.withOpacity(.1),
                    blurRadius: 2,
                    spreadRadius: 1)
              ],
              borderRadius: BorderRadius.circular(
                SizeConfig.scaleHeight(borderRadius),
              ),
              color: kBackgroundColor),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GetX<CartGetxController>(
                    init: CartGetxController(),
                    builder: (CartGetxController controller) {
                      return controller.isLoading.value
                          ? Center(child: indicatorNourahLoading())
                          : Column(
                              children: [
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    dragStartBehavior: DragStartBehavior.start,
                                    shrinkWrap: true,
                                    itemCount: controller.cartProducts.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          left: wCard,
                                          right: wCard,
                                          top: hCard,
                                          bottom: hSpaceLarge,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: ImageCircle(
                                                  imageString: controller
                                                      .cartProducts[index]
                                                      .productImage!,
                                                  size:
                                                      SizeConfig.scaleTextFont(
                                                          90)),
                                            ),
                                            SizedBox(
                                              width: wSpaceSmall,
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        SizeConfig.scaleWidth(
                                                            265),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 13,
                                                          child: StyleText(
                                                            controller
                                                                .cartProducts[
                                                                    index]
                                                                .productName!,
                                                            textAlign:
                                                                TextAlign.start,
                                                            textColor:
                                                                kSpecialColor,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 12,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              StyleText(
                                                                "${controller.cartProducts[index].total!}  ",
                                                                textColor:
                                                                    kSpecialColor,
                                                                height: 1.5,
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                width: SizeConfig
                                                                    .scaleWidth(
                                                                        70),
                                                              ),
                                                              StyleText(
                                                                " ${AppLocalizations.of(context)!.reyal}",
                                                                textColor:
                                                                    kSpecialColor,
                                                                height: 1.5,
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                fontSize:
                                                                    fLarge,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: hSpace,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      StyleText(
                                                        controller
                                                                    .cartProducts[
                                                                        index]
                                                                    .offerStatus ==
                                                                1
                                                            ? AppLocalizations
                                                                    .of(context)!
                                                                .sale
                                                            : "        ",
                                                        textColor: kConfirm,
                                                      ),
                                                      SizedBox(
                                                        width: SizeConfig
                                                            .scaleWidth(20),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          SizedBox(
                                                            child: SizedBox(
                                                              width: SizeConfig
                                                                  .scaleWidth(
                                                                      150),
                                                              height: SizeConfig
                                                                  .scaleHeight(
                                                                      50),
                                                              child:
                                                                  ContainerApp(
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .remove_circle,
                                                                          color: controller.cartProducts[index].qty != 0
                                                                              ? kSpecialColor.withOpacity(.9)
                                                                              : kRefuse,
                                                                          size:
                                                                              fIcon,
                                                                        ),
                                                                        disabledColor:
                                                                            kSpecialColor,
                                                                        padding:
                                                                            const EdgeInsets.all(0),
                                                                        onPressed:
                                                                            () async {
                                                                          if (controller.cartProducts[index].qty! ==
                                                                              0) {
                                                                            await controller.deleteItem(id: controller.cartProducts[index].id!);
                                                                          }
                                                                          if (controller.cartProducts[index].qty! >
                                                                              0) {
                                                                            await CartGetxController.to.removeCounter();
                                                                            await controller.removeTotalPrice(controller.cartProducts[index].intialPrice!.toDouble());

                                                                            int quantity =
                                                                                controller.cartProducts[index].qty!;
                                                                            dynamic
                                                                                price =
                                                                                controller.cartProducts[index].intialPrice!;
                                                                            quantity--;

                                                                            dynamic
                                                                                newPrice =
                                                                                price * quantity;

                                                                            await controller.updateItem(
                                                                                updatedCart: Cart(
                                                                              productId: controller.cartProducts[index].productId!,
                                                                              qty: quantity,
                                                                              offerStatus: controller.cartProducts[index].offerStatus,
                                                                              intialPrice: controller.cartProducts[index].intialPrice!,
                                                                              productName: controller.cartProducts[index].productName!,
                                                                              total: newPrice,
                                                                              userId: controller.cartProducts[index].userId!,
                                                                              id: controller.cartProducts[index].id!,
                                                                              productImage: controller.cartProducts[index].productImage!,
                                                                            ));
                                                                            // print("getCounter  ${CartGetxController.to.getCounter()}");
                                                                            //
                                                                            // print("getTotalPrice  ${CartGetxController.to.getTotalPrice()}");
                                                                            setState(() {
                                                                              newPrice = 0;
                                                                              quantity = 0;
                                                                            });
                                                                          }
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 3,
                                                                      child:
                                                                          StyleText(
                                                                        "${controller.cartProducts[index].qty!}",
                                                                        textColor: controller.cartProducts[index].qty! !=
                                                                                0
                                                                            ? kSpecialColor
                                                                            : kRefuse,
                                                                        height:
                                                                            1.5,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child: IconButton(
                                                                          icon: Icon(
                                                                            Icons.add_circle_outlined,
                                                                            color:
                                                                                kSpecialColor.withOpacity(.9),
                                                                            size:
                                                                                fIcon,
                                                                          ),
                                                                          padding: const EdgeInsets.all(0),
                                                                          onPressed: () async {
                                                                            int quantity =
                                                                                controller.cartProducts[index].qty!;
                                                                            dynamic
                                                                                price =
                                                                                controller.cartProducts[index].intialPrice!;
                                                                            quantity++;

                                                                            dynamic
                                                                                newPrice =
                                                                                price * quantity;

                                                                            await controller.updateItem(
                                                                                updatedCart: Cart(
                                                                              productId: controller.cartProducts[index].productId!,
                                                                              qty: quantity,
                                                                              offerStatus: controller.cartProducts[index].offerStatus,
                                                                              intialPrice: controller.cartProducts[index].intialPrice!,
                                                                              productName: controller.cartProducts[index].productName!,
                                                                              total: newPrice,
                                                                              userId: controller.cartProducts[index].userId!,
                                                                              id: controller.cartProducts[index].id!,
                                                                              productImage: controller.cartProducts[index].productImage!,
                                                                            ));
                                                                            await controller.addCounter();
                                                                            await controller.addTotalPrice(controller.cartProducts[index].intialPrice!.toDouble());
                                                                            // print("getCounter  ${controller.getCounter()}");
                                                                            //
                                                                            // print("getTotalPrice  ${controller.getTotalPrice()}");
                                                                            setState(() {
                                                                              newPrice = 0;
                                                                              quantity = 0;
                                                                            });
                                                                          }),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: SizeConfig
                                                            .scaleWidth(10),
                                                      ),
                                                      IconButton(
                                                        onPressed: () async {
                                                          int quantity =
                                                              controller
                                                                  .cartProducts[
                                                                      index]
                                                                  .qty!;
                                                          dynamic
                                                              priceToRemove =
                                                              controller
                                                                      .cartProducts[
                                                                          index]
                                                                      .intialPrice! *
                                                                  quantity;
                                                          await controller
                                                              .removeTotalPrice(
                                                                  priceToRemove);
                                                          await controller
                                                              .removeCounterCustom(
                                                                  quantity);
                                                          await controller
                                                              .deleteItem(
                                                                  id: controller
                                                                      .cartProducts[
                                                                          index]
                                                                      .id!);
                                                        },
                                                        icon: const Icon(
                                                            Icons.clear),
                                                        color: kRefuse,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  height: hSpaceLarge,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        StyleText(
                                          "${AppLocalizations.of(context)!.count}  :",
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          width: wSpace,
                                        ),
                                        StyleText(
                                          "${controller.getCounter()}",
                                          textColor: kSpecialColor,
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        StyleText(
                                          "${controller.getTotalPrice()}   ",
                                          textColor: kSpecialColor,
                                          textAlign: TextAlign.end,
                                          width: 100,
                                        ),
                                        StyleText(
                                          "  ${AppLocalizations.of(context)!.reyal} ",
                                          textColor: kSpecialColor,
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                    }),
                SizedBox(
                  height: hSpaceLarge,
                ),
                StyleField(
                  title: AppLocalizations.of(context)!.additionalnotes,
                  controller: noteCustomer,
                  maxLines: 4,
                  padding: 10,
                  width: double.infinity,
                  height: SizeConfig.scaleHeight(180),
                ),
              ],
            ),
          ),
        ),
        isActive: widget.currentStep >= 0,
      ),
      Step(
        title: StyleText(
          AppLocalizations.of(context)!.confirm,
        ),
        content: Container(
          padding: EdgeInsetsDirectional.only(
            top: hPadding,
            start: wPadding,
            end: wPadding,
            bottom: hPadding,
          ),
          margin: EdgeInsets.only(
            bottom: hSpaceLarge,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: kGrey.withOpacity(.1),
                    blurRadius: 2,
                    spreadRadius: 1)
              ],
              borderRadius: BorderRadius.circular(
                SizeConfig.scaleHeight(borderRadius),
              ),
              color: kBackgroundColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GetX<CartGetxController>(
                  init: CartGetxController(),
                  builder: (CartGetxController controller) {
                    return controller.isLoading.value
                        ? Center(child: indicatorNourahLoading())
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.cartProducts.length,
                            itemBuilder: (context, index) {
                              return controller.cartProducts[index].qty == 0
                                  ? const SizedBox()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                        left: wCard,
                                        right: wCard,
                                        top: hCard,
                                        bottom: hSpaceLarge,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: ImageCircle(
                                                imageString: controller
                                                    .cartProducts[index]
                                                    .productImage!,
                                                size: SizeConfig.scaleTextFont(
                                                    90)),
                                          ),
                                          SizedBox(
                                            width: wSpaceSmall,
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: SizeConfig.scaleWidth(
                                                      265),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 13,
                                                            child: StyleText(
                                                              controller
                                                                  .cartProducts[
                                                                      index]
                                                                  .productName!,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              textColor:
                                                                  kSpecialColor,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 12,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                StyleText(
                                                                  " ${controller.cartProducts[index].total!}  ",
                                                                  textColor:
                                                                      kSpecialColor,
                                                                  height: 1.5,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  width: SizeConfig
                                                                      .scaleWidth(
                                                                          70),
                                                                ),
                                                                StyleText(
                                                                  " ${AppLocalizations.of(context)!.reyal}",
                                                                  textColor:
                                                                      kSpecialColor,
                                                                  height: 1.5,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  fontSize:
                                                                      fLarge,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: hSpace,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 13,
                                                            child: StyleText(
                                                                controller
                                                                            .cartProducts[
                                                                                index]
                                                                            .offerStatus ==
                                                                        1
                                                                    ? AppLocalizations.of(
                                                                            context)!
                                                                        .sale
                                                                    : "        ",
                                                                textColor:
                                                                    kConfirm,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start),
                                                          ),
                                                          Expanded(
                                                            flex: 8,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                StyleText(
                                                                  "${AppLocalizations.of(context)!.quantity} :  ",
                                                                  textColor:
                                                                      kSpecialColor,
                                                                  height: 1.5,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                ),
                                                                StyleText(
                                                                  "${controller.cartProducts[index].qty!}",
                                                                  textColor:
                                                                      kSpecialColor,
                                                                  height: 1.5,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  fontSize:
                                                                      fLarge,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: hSpace,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                            });
                  }),
              // SizedBox(
              //   height: hSpace,
              // ),
              Row(
                children: [
                  Row(
                    children: [
                      StyleText(
                        "${AppLocalizations.of(context)!.count}  :",
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        width: wSpace,
                      ),
                      StyleText(
                        "${CartGetxController.to.getCounter()}",
                        textColor: kSpecialColor,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      StyleText(
                        "${CartGetxController.to.getTotalPrice()} ",
                        textColor: kSpecialColor,
                        textAlign: TextAlign.end,
                        width: SizeConfig.scaleWidth(100),
                      ),
                      StyleText(
                        " ${AppLocalizations.of(context)!.reyal} ",
                        textColor: kSpecialColor,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: hSpaceLarge,
              ),
              SizedBox(
                width: double.infinity,
                child: StyleText(
                  AppLocalizations.of(context)!.userNotes,
                  textAlign: TextAlign.start,
                  textColor: kSpecialColor,
                ),
              ),
              SizedBox(
                height: hSpace,
              ),
              Notes(
                note: Provider.of<stringNoteCustomer>(context, listen: false)
                    .noteCustomer,
              ),
              SizedBox(
                height: hSpaceLargev,
              ),
              SizedBox(
                width: double.infinity,
                child: StyleText(
                  AppLocalizations.of(context)!.familyNotes,
                  textAlign: TextAlign.start,
                  textColor: kSpecialColor,
                ),
              ),
              SizedBox(
                height: hSpaceLarge,
              ),
              widget.orderIdPage == null
                  ? const SizedBox()
                  : GetX<getCartOrderIdGetx>(
                      init: getCartOrderIdGetx(
                        coupon: coupon.text.isNotEmpty
                            ? coupon.text.toString()
                            : "0",
                        language: 'ar',
                        order_id: widget.orderIdPage!,
                      ),
                      builder: (getCartOrderIdGetx controllerCart) {
                        controllerCart = widget.controllerCartt != null
                            ? widget.controllerCartt!
                            : controllerCart;
                        return controllerCart.isLoading.value
                            ? Center(child: indicatorNourahLoading())
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      StyleText(
                                        "${AppLocalizations.of(context)!.processingTime}  :",
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        width: wSpace,
                                      ),
                                      StyleText(
                                        "${controllerCart.getCartOrder["order_duration"] ?? ''}  ${controllerCart.getCartOrder["order_duration_unit"] == "h" ? AppLocalizations.of(context)!.hour : "${controllerCart.getCartOrder["order_duration_unit"]}" == "m" ? AppLocalizations.of(context)!.minute : "${controllerCart.getCartOrder["order_duration_unit"]}" == "m" ? AppLocalizations.of(context)!.day : ''} ",
                                        textColor: kSpecialColor,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: hSpace,
                                  ),
                                  Notes(
                                    note:
                                        "${controllerCart.getCartOrder["family_notes"] ?? ''}",
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.scaleWidth(200),
                                    child: StyleButton(
                                      AppLocalizations.of(context)!.refresh,
                                      width: double.infinity,
                                      backgroundColor: kSpecialColor,
                                      sideColor: kSpecialColor,
                                      onPressed: () async {
                                        // print(
                                        //     'order_id_page  ${widget.orderIdPage}');
                                        await controllerCart.refreshValues(
                                            order_id_2: widget.orderIdPage!);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.scaleWidth(350),
                                    child: StyleButton(
                                      controllerCart.getCartOrder[
                                                  "order_duration"] !=
                                              null
                                          ? AppLocalizations.of(context)!
                                              .confirm
                                          : AppLocalizations.of(context)!
                                              .waitingForTheFamilyResponse,
                                      width: double.infinity,
                                      backgroundColor:
                                          controllerCart.getCartOrder[
                                                      "order_duration"] !=
                                                  null
                                              ? kConfirm
                                              : Colors.grey,
                                      sideColor: controllerCart.getCartOrder[
                                                  "order_duration"] !=
                                              null
                                          ? kConfirm
                                          : Colors.grey,
                                      onPressed: () async {
                                        // print(
                                        //     'order_id_page  ${widget.orderIdPage}');
                                        // print('confirmOrder');
                                        controllerCart.getCartOrder[
                                                    "order_duration"] !=
                                                null
                                            ? await confirmOrder()
                                            : print('no response yet');
                                        // print(
                                        //     "_currentStep ${widget.currentStep}");
                                      },
                                    ),
                                  )
                                ],
                              );
                      }),
            ],
          ),
        ),
        isActive: widget.currentStep >= 1,
      ),
      Step(
        title: StyleText(
          AppLocalizations.of(context)!.driver,
        ),
        content: Container(
            padding: EdgeInsetsDirectional.only(
              top: hPadding,
              start: wPadding,
              end: wPadding,
              bottom: hPadding,
            ),
            margin: EdgeInsets.only(
              bottom: hSpaceLarge,
            ),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: kGrey.withOpacity(.1),
                      blurRadius: 2,
                      spreadRadius: 1)
                ],
                borderRadius: BorderRadius.circular(
                  SizeConfig.scaleHeight(borderRadius),
                ),
                color: kBackgroundColor),
            child: Column(
              children: [
                SizedBox(
                  height: hSpace,
                ),
                widget.orderIdPage == null || widget.deliveryBool == false
                    ? const SizedBox()
                    : GetX<GetOrderDeliveryRequestsGetX>(
                        init: GetOrderDeliveryRequestsGetX(
                            language:
                                Localizations.localeOf(context).languageCode ==
                                        "ar"
                                    ? "ar"
                                    : "en",
                            order_id: widget.orderIdPage!),
                        builder: (GetOrderDeliveryRequestsGetX controller) {
                          controller = widget.controllerDelivery != null
                              ? widget.controllerDelivery!
                              : controller;
                          return Column(
                            children: [
                              controller.isLoading.value
                                  ? Center(child: indicatorNourahLoading())
                                  : controller.delivers.isNotEmpty
                                      ? ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: controller.delivers.length,
                                          itemBuilder: (context, index) {
                                            return CardNewDelivery(
                                              id: controller.delivers[index].id,
                                              driverCost:
                                                  "${controller.delivers[index].shippingCost}",
                                              driverImage: controller
                                                  .delivers[index]
                                                  .deliveryimage,
                                              driverName: controller
                                                  .delivers[index].deliveryname,
                                              driverRate: controller
                                                  .delivers[index].deliveryrate,
                                              driverTime: controller
                                                  .delivers[index]
                                                  .deliveryDuration,
                                              driverTimeUnit: controller
                                                  .delivers[index]
                                                  .deliveryDurationUnit,
                                              onPressed: () async {
                                                setState(() {
                                                  widget.currentStep =
                                                      widget.currentStep + 1;
                                                  shippingCost =
                                                      "${controller.delivers[index].shippingCost}";
                                                });
                                                // print(
                                                //     "id ${widget.orderIdPage}confirmed delivery id ${controller.delivers[index].id}");
                                                getOrderGetX()
                                                    .confirmDeliveryOrder(
                                                        context: context,
                                                        id: controller
                                                            .delivers[index]
                                                            .id);

                                                // print(
                                                //     "_currentStep ${widget.currentStep}");
                                              },
                                            );
                                          })
                                      : noContent(
                                          context,
                                          AppLocalizations.of(context)!
                                              .thereIsnoDriversUntilNow,
                                          height: 0),
                              SizedBox(
                                height: hSpaceLarge,
                              ),
                              SizedBox(
                                width: SizeConfig.scaleWidth(200),
                                child: StyleButton(
                                  AppLocalizations.of(context)!.refresh,
                                  width: double.infinity,
                                  backgroundColor: kSpecialColor,
                                  sideColor: kSpecialColor,
                                  onPressed: () async {
                                    await refreshOrder();
                                    await controller.refreshData();
                                  },
                                ),
                              )
                            ],
                          );
                        }),
              ],
            )),
        isActive: widget.currentStep >= 2,
      ),
      Step(
        title: StyleText(
          AppLocalizations.of(context)!.pay,
        ),
        content: ContainerApp(
          child: Column(
            children: [
              SizedBox(
                height: hSpace,
              ),
              RadioListTile(
                title: StyleText(
                  AppLocalizations.of(context)!.walletInfo,
                ),
                value: 1,
                dense: true,
                activeColor: kSpecialColor,
                groupValue: groupValue,
                onChanged: (int? val) {
                  groupValue = val!;
                  // print(groupValue);
                  setState(() {});
                },
              ),
              RadioListTile(
                title: StyleText(AppLocalizations.of(context)!.credit),
                activeColor: kSpecialColor,
                dense: true,
                value: 2,
                groupValue: groupValue,
                onChanged: (int? val) {
                  groupValue = val!;
                  // print(groupValue);
                  setState(() {});
                },
              ),
              dividerApp(height: 60),
              widget.orderIdPage == null
                  ? const SizedBox()
                  : GetX<getCartOrderIdGetx>(
                      init: getCartOrderIdGetx(
                        coupon: coupon.text.isNotEmpty
                            ? coupon.text.toString()
                            : "0",
                        language: 'ar',
                        order_id: widget.orderIdPage!,
                      ),
                      builder: (getCartOrderIdGetx controllerCart) {
                        return controllerCart.isLoading.value
                            ? Center(child: indicatorNourahLoading())
                            : Column(
                                children: [
                                  //order_cost
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      StyleText(
                                        "${AppLocalizations.of(context)!.orderCost}  :   ",
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        width: wSpaceLarge,
                                      ),
                                      StyleText(
                                        "${controllerCart.getCartOrder['order_cost']}   ${AppLocalizations.of(context)!.reyal}",
                                        textColor: kSpecialColor,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: hSpace,
                                  ),
                                  //shipping_cost
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      StyleText(
                                        "${AppLocalizations.of(context)!.deliveryCost}  :   ",
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        width: wSpaceLarge,
                                      ),
                                      StyleText(
                                        shippingCost != ''
                                            ? "$shippingCost  ${AppLocalizations.of(context)!.reyal}"
                                            : "${controllerCart.getCartOrder['shipping_cost']}   ${AppLocalizations.of(context)!.reyal}",
                                        textColor: kSpecialColor,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  dividerApp(height: 60),
                                  //copon field
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: StyleText(
                                          AppLocalizations.of(context)!.coupon,
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: SizeConfig.scaleHeight(50),
                                          child: StyleField(
                                            textAlign: TextAlign.center,
                                            controller: coupon,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: wSpace,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),

                                  //copon button
                                  SizedBox(
                                    width: SizeConfig.scaleWidth(150),
                                    child: StyleButton(
                                      AppLocalizations.of(context)!
                                          .verifyfromaccount,
                                      backgroundColor:
                                          kSpecialColor.withOpacity(.9),
                                      sideColor: kSpecialColor,
                                      onPressed: () async {
                                        if (coupon.text.isNotEmpty) {
                                          shippingCost != ''
                                              ? await controllerCart
                                                  .ConfirmCopounController(
                                                      context: context,
                                                      order_cost: CartGetxController
                                                              .to
                                                              .getTotalPrice() +
                                                          double.parse(
                                                              shippingCost),
                                                      order_id_2:
                                                          widget.orderIdPage!,
                                                      coupon:
                                                          coupon.text.isNotEmpty
                                                              ? coupon.text
                                                              : "0")
                                              : print("shippingCost=0");
                                        }
                                      },
                                    ),
                                  ),
                                  dividerApp(height: 60),
                                  //copon
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      StyleText(
                                        "${AppLocalizations.of(context)!.coupon}  :   ",
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        width: wSpaceLarge,
                                      ),
                                      StyleText(
                                        "${controllerCart.getCartOrder['coupon']}",
                                        textColor: kSpecialColor,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  dividerApp(height: 40),
                                  shippingCost != ''
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            StyleText(
                                              "${AppLocalizations.of(context)!.finalCost}  :   ",
                                              textAlign: TextAlign.start,
                                            ),
                                            SizedBox(
                                              width: wSpaceLarge,
                                            ),
                                            StyleText(
                                              "${controllerCart.getCartOrder['order_cost'] + double.parse(shippingCost) - controllerCart.getCartOrder['coupon']}   ${AppLocalizations.of(context)!.reyal}",
                                              textColor: kSpecialColor,
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        )
                                      : Column(),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  // button
                                  SizedBox(
                                    width: SizeConfig.scaleWidth(270),
                                    child: StyleButton(
                                        AppLocalizations.of(context)!.confirm,
                                        width: double.infinity,
                                        backgroundColor: kSpecialColor,
                                        sideColor: kSpecialColor,
                                        onPressed: () async {
                                      controllerCart.refreshValues(
                                          order_id_2: widget.orderIdPage!);

                                      if (groupValue == 1) {
                                        bool walletPay = await paymentOrder(
                                          copounPage: controllerCart
                                              .getCartOrder['coupon'],
                                          familyId: widget.userId,
                                        );
                                        if (walletPay) {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MainScreen(
                                                        currentIndex: 1,
                                                        orderIndex: 0,
                                                      )));
                                        }
                                      } else if (groupValue == 2) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentScreen(
                                                        // builder: (context) => mainApplePay(
                                                        amt:
                                                            "${controllerCart.getCartOrder['order_cost'] + double.parse(shippingCost) - controllerCart.getCartOrder['coupon']}",
                                                        orderId:
                                                            widget.orderIdPage!,
                                                        userId: widget.userId,
                                                        copounPage: controllerCart
                                                                .getCartOrder[
                                                            'coupon'],
                                                        // shippingCostString:"${controllerCart.getCartOrder['shipping_cost']}تكلفة التوصيل :" ,
                                                        // orderCostString:"${controllerCart.getCartOrder['order_cost']}تكلفة الطلب :" ,
                                                        // couponString:"${controllerCart.getCartOrder['coupon']}قيمة الكوبون :" ,
                                                        // shipping_to:"${controllerCart.getCartOrder['shipping_to']}تم التوصيل ل :" ,
                                                        familyId: widget.userId,
                                                        groupValue: groupValue,
                                                        order_cost:
                                                            CartGetxController
                                                                .to
                                                                .getTotalPrice(),
                                                        total_cost: CartGetxController
                                                                .to
                                                                .getTotalPrice() -
                                                            controllerCart
                                                                    .getCartOrder[
                                                                'coupon'])));
                                      } else {
                                        await CartGetxController.to.cleanCart();
                                        print('fail to pay');
                                      }
                                    }),
                                  ),
                                  SizedBox(
                                    height: hSpace,
                                  ),
                                ],
                              );
                      }),
            ],
          ),
        ),
        isActive: widget.currentStep >= 3,
      ),
    ];
    return steps;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: appBarWhite(context,
            iconBack: null,
            back: false,
            backOk: false,
            onPressedBackBool: false,
            main: true,
            title: AppLocalizations.of(context)!.shoppingcart, onPressed: () {
          showDialoge(context,
              message3: Column(),
              message1: AppLocalizations.of(context)!.cancelrequest,
              message2: AppLocalizations.of(context)!
                  .areyousureaboutcancelingtherequest,
              iconMeassge: Icon(
                Icons.warning_amber_outlined,
                color: kRefuse,
                size: SizeConfig.scaleTextFont(80),
              ),
              button1: AppLocalizations.of(context)!.yes,
              colorButton1: kRefuse,
              colorButton2: kConfirm, onPressed: () async {
            if (widget.orderIdPage != null) {
              await cancelOrder(id: widget.orderIdPage!);
            } else {
              helper(
                  context: context,
                  message: AppLocalizations.of(context)!.theCartIsCleaned,
                  error: true);
            }

            await CartGetxController.to.cleanCart();
            await Get.delete<getCartOrderIdGetx>();
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, "/mainScreen");
          }, button2: AppLocalizations.of(context)!.no);
        }, icon: Icons.delete_outline),
        body: Stepper(
          onStepTapped: (step) {
            setState(() {
              widget.currentStep = widget.currentStep;
            });
          },
          steps: _mySteps(),
          currentStep: widget.currentStep,
          elevation: 1,
          type: StepperType.horizontal,
          controlsBuilder: (context, details) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: hSpace,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: widget.disapearButtom != true
                          ? StyleButton(
                              AppLocalizations.of(context)!.confirm,
                              width: double.infinity,
                              backgroundColor: kConfirm,
                              sideColor: kConfirm,
                              onPressed: () async {
                                if (widget.currentStep ==
                                    _mySteps().length - 4) {
                                  return showDialoge(
                                    context,
                                    message3: Column(),
                                    message1: AppLocalizations.of(context)!
                                        .confirmrequest,
                                    message2: AppLocalizations.of(context)!
                                        .youwillrecieveanotificationofthetimeneededtofinishyourorder,
                                    button1:
                                        AppLocalizations.of(context)!.confirm,
                                    button2:
                                        AppLocalizations.of(context)!.cancel,
                                    colorButton1: kConfirm,
                                    colorButton2: kSpecialColor,
                                    iconMeassge: Icon(
                                      Icons.next_plan_sharp,
                                      color: kConfirm,
                                      size: SizeConfig.scaleTextFont(50),
                                    ),
                                    onPressed: () async {
                                      // print('makeOrder');
                                      await makeOrder(
                                        familyId: widget.userId,
                                      );
                                      // print(
                                      //     "_currentStep ${widget.currentStep}");
                                    },
                                  );
                                } else if (widget.currentStep ==
                                    _mySteps().length - 3) {
                                  // print('confirmOrder');
                                  // print(widget.currentStep);
                                } else if (widget.currentStep ==
                                    _mySteps().length - 2) {
                                  // print("choose driver");
                                  // print(widget.currentStep);
                                } else if (widget.currentStep ==
                                    _mySteps().length - 1) {
                                  // print('paymentOrder');
                                  // print(widget.currentStep);
                                }
                              },
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future makeOrder({
    required int familyId,
  }) async {
    List orderDetails = await _database.query('cart');
    getMakeOrderIdGetx controllerMakeOrder = Get.put(getMakeOrderIdGetx(
      client_notes: noteCustomer.text,
      family_id: widget.userId,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      shipping_lat:
          "${Provider.of<LongNotiferUser>(context, listen: false).longUser}",
      shipping_lng:
          "${Provider.of<LatNotiferUser>(context, listen: false).latUser}",
      shipping_to:
          "${Provider.of<stringNotiferUser>(context, listen: false).addressUser}",
      // ${Provider.of<stringNotiferUser>(context, listen: false).addressUser}
      order_details: orderDetails,
    ));
    dynamic orderId = controllerMakeOrder.makeOrderId['id'];
    // print("lat${Provider.of<LatNotiferUser>(context, listen: false).latUser}");
    // print(
    //     "lng${Provider.of<LongNotiferUser>(context, listen: false).longUser}");
    // print(
    //     "address${Provider.of<stringNotiferUser>(context, listen: false).addressUser}");
    if (orderId != null) {
      setState(() {
        widget.disapearButtom = true;
        widget.orderIdPage = orderId;
        orderDetailsPage = orderDetails;
      });
      Provider.of<intOrderToConfirmFamily>(context, listen: false)
          .changeIntOrderToConfirmFamily(orderId);

      Provider.of<stringNoteCustomer>(context, listen: false)
          .changeStringNoteCustomer(noteCustomer.text);
      // print("order_details_page  $orderDetailsPage");
      // print("order_id_page  ${widget.orderIdPage}");
      // print("widget.userId familyID ${widget.userId}");
    }
    if (widget.orderIdPage != null) {
      setState(() {
        Navigator.pop(context);
        widget.currentStep = widget.currentStep + 1;
      });
    }
  }

  Future confirmOrder() async {
    bool confirmOrder = await OrderController().confirmOrderUserController(
        context: context,
        orderId: widget.orderIdPage != null ? widget.orderIdPage! : 0,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en");
    // print(confirmOrder);

    if (confirmOrder) {
      setState(() {
        widget.currentStep = widget.currentStep + 1;

        widget.deliveryBool = true;
      });
    }
  }

  Future paymentOrder({required int familyId, required int copounPage}) async {
    await cont.payment(
        context: context,
        order_id_page: widget.orderIdPage != null ? widget.orderIdPage! : 0,
        coupon: copounPage,
        groupValue: groupValue,
        order_cost: CartGetxController.to.getTotalPrice(),
        total_cost: CartGetxController.to.getTotalPrice() - copounPage);
  }

  Future refreshOrder({orderNo}) async {
    // print(widget.orderIdPage);
    await OrderController().refreshOrderUserController(
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
        context: context,
        orderNo: widget.orderIdPage);
  }

  Future cancelOrder({required int id}) async {
    await cont.cancelOrder(
      context: context,
      id: id,
    );
  }
}
