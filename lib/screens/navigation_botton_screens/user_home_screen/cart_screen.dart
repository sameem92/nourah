import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/containers/card_cart.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/show_dialoge.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/main_screen.dart';
import 'package:producer_family_app/storage/api/order_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/cart_getx_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'orders/order_screen.dart';

class CartScreen extends StatefulWidget {
  String id;
  int totalPrice;
  int price;
  int productId;
  int productQu;
  String productName;
  String productImage;
  CartScreen(
      {this.id = "",
      this.totalPrice = 0,
      this.price = 0,
      this.productId = 0,
      this.productQu = 0,
      this.productName = "",
      this.productImage = ""});

  @override
  _CartScreenState createState() => _CartScreenState();
}

getCartOrderIdGetx controllerCart =
    Get.put(getCartOrderIdGetx(coupon: "", language: '', order_id: "1"
        // controllerMakeOrder.makeOrderId['id'].toString()
        ));

getMakeOrderIdGetx controllerMakeOrder = Get.find();

class _CartScreenState extends State<CartScreen> {
  int _currentStep = 0;
  late TextEditingController _noteCustomer;
  late TextEditingController coupon;

  String available = '1';
  int groupValue = 1;
  @override
  void initState() {
    super.initState();
    _noteCustomer = TextEditingController();
    coupon = TextEditingController();
    _noteCustomer.addListener(() => setState(() {}));
    coupon.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _noteCustomer.dispose();
    coupon.dispose();
  }

  List<Step> _mySteps() {
    getMakeOrderIdGetx controllerMakeOrder = Get.put(getMakeOrderIdGetx(
      client_notes: _noteCustomer.text,
      family_id: widget.id,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      shipping_lat:
          "${Provider.of<LongNotiferUser>(context, listen: false).longUser}",
      shipping_lng:
          "${Provider.of<LatNotiferUser>(context, listen: false).latUser}",
      shipping_to:
          Provider.of<stringNotiferUser>(context, listen: false).addressUser,
      order_details: "${[
        {
          "product_id": '3'.toString(),
          "qty": '2'.toString(),
          "total": '1'.toString()
        },
      ]}",
    ));
    confirmCopounGetx controllerCopoun = Get.put(confirmCopounGetx(
      order_id: controllerCart.getCartOrder['id'].toString(),
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      coupon: coupon.text,
      order_cost: controllerCart.getCartOrder['order_cost'].toString(),
    ));
    List<Step> _steps = [
      Step(
        state: StepState.indexed,
        title: StyleText(
          AppLocalizations.of(context)!.neworder,
        ),
        content: Container(
            padding: EdgeInsetsDirectional.only(
                top: hPadding,
                bottom: hPadding,
                end: wPadding,
                start: wPadding),
            margin: EdgeInsets.only(
              bottom: hSpaceLarge,
            ),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: kSecondaryColor.withOpacity(.1),
                      blurRadius: 4,
                      spreadRadius: 2)
                ],
                borderRadius: BorderRadius.circular(
                  SizeConfig.scaleHeight(borderRadius),
                ),
                color: kBackgroundColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                card_cart(
                    productPrice: widget.totalPrice,
                    image: widget.productImage,
                    productName: widget.productName,
                    price: widget.price,
                    productQu: widget.productQu),
                SizedBox(
                  height: hSpaceLargevv,
                ),
                StyleField(
                  title: AppLocalizations.of(context)!.additionalnotes,
                  controller: _noteCustomer,
                  maxLines: 4,
                  padding: 10,
                  width: double.infinity,
                  height: SizeConfig.scaleHeight(180),
                ),
              ],
            )),
        isActive: _currentStep >= 0,
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
                    color: kSecondaryColor.withOpacity(.1),
                    blurRadius: 4,
                    spreadRadius: 2)
              ],
              borderRadius: BorderRadius.circular(
                SizeConfig.scaleHeight(borderRadius),
              ),
              color: kBackgroundColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              card_cart(
                confirm: true,
                productPrice: widget.totalPrice,
                image: widget.productImage,
                productName: widget.productName,
                price: widget.price,
                productQu: widget.productQu,
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
              notes(
                note: _noteCustomer.text,
              ),
              SizedBox(
                height: hSpaceLargevv,
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
              StyleText(
                "${AppLocalizations.of(context)!.processingTime}",
                textColor: kSpecialColor,
              ),
              SizedBox(
                height: hSpace,
              ),
              notes(),
            ],
          ),
        ),
        isActive: _currentStep >= 1,
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
                activeColor: kConfirm,
                groupValue: groupValue,
                onChanged: (int? val) {
                  groupValue = val!;
                  print(groupValue);
                  setState(() {});
                },
              ),
              RadioListTile(
                title: StyleText(AppLocalizations.of(context)!.credit),
                activeColor: kConfirm,
                dense: true,
                value: 2,
                groupValue: groupValue,
                onChanged: (int? val) {
                  groupValue = val!;
                  print(groupValue);
                  setState(() {});
                },
              ),
              divider_app(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StyleText(
                    AppLocalizations.of(context)!.totalCost,
                  ),
                  StyleText(
                      "${controllerCart.getCartOrder['order_cost']}  ${AppLocalizations.of(context)!.reyal}"),
                ],
              ),
              divider_app(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        title: "",
                        controller: coupon,
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
              SizedBox(
                width: SizeConfig.scaleWidth(150),
                child:
                    StyleButton(AppLocalizations.of(context)!.verifyfromaccount,
                        onPressed: () async {
                  await confirmCopoun();
                },
                        backgroundColor: kSpecialColor.withOpacity(.9),
                        sideColor: kSpecialColor),
              ),
              divider_app(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StyleText(
                    AppLocalizations.of(context)!.coupon,
                  ),
                  StyleText(
                      "${controllerCopoun.confirmCopoun['data'] ?? 0}  ${AppLocalizations.of(context)!.reyal}"),
                ],
              ),
              divider_app(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StyleText(
                    AppLocalizations.of(context)!.finalCost,
                  ),
                  StyleText(
                      "${controllerCart.getCartOrder['total_cost']}  ${AppLocalizations.of(context)!.reyal}"),
                ],
              ),
              SizedBox(
                height: hSpace,
              )
            ],
          ),
        ),
        isActive: _currentStep >= 2,
      ),
    ];
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWhite(context,
          iconBack: null,
          title: AppLocalizations.of(context)!.shoppingcart, onPressed: () {
        ShowDialoge(context,
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
            colorButton2: kConfirm, onPressed: () {
          CartGetxController().cleanCart();
          Navigator.pushReplacementNamed(context, "/mainScreen");
        }, button2: AppLocalizations.of(context)!.no);
      }, icon: Icons.delete_outline),
      body: Stepper(
        onStepTapped: (Step) {
          setState(() {
            _currentStep = _currentStep;
          });
        },
        steps: _mySteps(),
        currentStep: _currentStep,
        elevation: 1,
        type: StepperType.horizontal,
        controlsBuilder: (context, {onStepCancel, onStepContinue}) {
          return Column(
            children: [
              SizedBox(
                height: hSpace,
              ),
              StyleButton(
                "${AppLocalizations.of(context)!.confirm}",
                width: double.infinity,
                onPressed: () async {
                  if (_currentStep == _mySteps().length - 3) {
                    return ShowDialoge(
                      context,
                      message3: Column(),
                      message1: AppLocalizations.of(context)!.confirmrequest,
                      message2: AppLocalizations.of(context)!
                          .youwillrecieveanotificationofthetimeneededtofinishyourorder,
                      iconMeassge: Icon(
                        Icons.next_plan_sharp,
                        color: kConfirm,
                        size: SizeConfig.scaleTextFont(50),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        setState(() {
                          _currentStep = _currentStep + 1;
                        });
                        await makeOrder(
                          product_id: widget.productId,
                          qty: widget.productQu,
                          total: "${widget.totalPrice}",
                          family_id: "${widget.id}",
                        );
                      },
                      button1: AppLocalizations.of(context)!.confirm,
                      button2: AppLocalizations.of(context)!.cancel,
                      colorButton1: kConfirm,
                      colorButton2: kSecondaryColor,
                    );
                  } else if (_currentStep == _mySteps().length - 2) {
                    await confirmOrder();

                    setState(() {
                      _currentStep = _currentStep + 1;
                    });
                  } else {
                    await paymentOrder();

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  }
                },
                backgroundColor: kConfirm,
                sideColor: kConfirm,
              ),
            ],
          );
        },

        // },
      ),
    );
  }

  Future makeOrder({
    int product_id = 0,
    int qty = 0,
    String total = "",
    String family_id = "",
  }) async {
    await OrderController().MakeOrderUserController(
      context: context,
      client_notes: _noteCustomer.text,
      family_id: family_id,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      shipping_lat:
          "${Provider.of<LongNotiferUser>(context, listen: false).longUser}",
      shipping_lng:
          "${Provider.of<LatNotiferUser>(context, listen: false).latUser}",
      shipping_to:
          Provider.of<stringNotiferUser>(context, listen: false).addressUser,
      order_details: "${[
        {
          "product_id": product_id.toString(),
          "qty": qty.toString(),
          "total": total.toString()
        },
      ]}",
    );
  }

  Future confirmOrder() async {
    await OrderController().ConfirmOrderUserController(
        context: context,
        order_id: controllerCart.getCartOrder['id'].toString(),
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en");
    print("order_id: ${controllerCart.getCartOrder['id'].toString()}");
  }

  Future paymentOrder() async {
    await OrderController().PaymentOrderUserController(
      context: context,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      order_id: controllerCart.getCartOrder['id'].toString(),
      coupon: coupon.text,
      order_cost: controllerCart.getCartOrder['order_cost'].toString(),
      payment_method: "$groupValue",
      total_cost: controllerCart.getCartOrder['total_cost'].toString(),
    );
    print("order_id: ${controllerCart.getCartOrder['id'].toString()}");
    print(
        "order_cost: ${controllerCart.getCartOrder['order_cost'].toString()}");
    print(
        "total_cost: ${controllerCart.getCartOrder['total_cost'].toString()}");
  }

  Future confirmCopoun() async {
    confirmCopounGetx controllerCopoun = Get.put(confirmCopounGetx(
      order_id: controllerCart.getCartOrder['id'].toString(),
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      coupon: coupon.text,
      order_cost: controllerCart.getCartOrder['order_cost'].toString(),
    ));
    await controllerCopoun.getCopoun(
      context: context,
      order_cost: controllerCart.getCartOrder['order_cost'].toString(),
      coupon: coupon.text,
    );
  }
}
