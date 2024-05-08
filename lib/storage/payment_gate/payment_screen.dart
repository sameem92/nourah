// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:producer_family_app/components/show_dialoge.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:urwaypayment/urwaypayment.dart';

import '../../components/headers/app_bar_family.dart';
import '../../components/show_helper.dart';
import '../providersAndGetx/cart_getx_controller.dart';
import '../providersAndGetx/order_getx.dart';
import 'receipt_updated_page.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    Key? key,
    required this.amt,
    // required this.shippingCostString,
    // required this.orderCostString,
    // required this.shipping_to,
    // required this.couponString,
    required this.copounPage,
    required this.orderId,
    required this.familyId,
    required this.groupValue,
    required this.order_cost,
    required this.total_cost,
    required this.userId,
  }) : super(key: key);

  // final String title;
  final String amt;

  final int familyId;
  final int copounPage;
  final int userId;
  final int orderId;
  final int groupValue;
  final double order_cost;
  final double total_cost;


  // final String shippingCostString;
  // final String orderCostString;
  // final String couponString;
  // final String shipping_to;
  // final String amt;
  // final String amt;
  // final String amt;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Future<void> _performtrxn(BuildContext context, String transType) async {
    var lastResult = "";
    var decodeSucceeded = false;
    if (transType == "hosted") {
      // on Apple Click call other method  check with if else
      lastResult = await Payment.makepaymentService(
          context: context,
          country: "SA",
          action: "1",
          currency: "SAR",
          amt: widget.amt,
          customerEmail: 'sameem.alturk@gmail.com',
          trackid: widget.orderId.toString(),
          udf1: "",
          udf2: "",

          udf3:"",
          udf4:"",
          udf5: "",
          cardToken: "",
          address: "",
          city: "jeddah",
          state: "XYZ",
          tokenizationType: "1",
          zipCode: "",
          tokenOperation: "A/U/D");

      print('Result in Main is $lastResult');
      decodeSucceeded = true;
    } else if (transType == "applepay") {
      print("In apple pay");
      lastResult = await Payment.makeapplepaypaymentService(
          context: context,
          country: "SA",
          action: "1",
          currency: "SAR",
          amt: widget.amt,
          customerEmail: 'sameem.alturk@gmail.com',
          trackid: widget.orderId.toString(),
          udf1: "",
          udf2: "",

          udf3:"",
          udf4:"",
          udf5: "",
          tokenizationType: "1",
          merchantIdentifier: "merchant.nourah.app",
          shippingCharge: "0.00",
          companyName: "hello");
      print('Result on Apple Pay in Main is $lastResult');
      decodeSucceeded = true;
    }

    if (decodeSucceeded) {
      if (lastResult.isNotEmpty) {
        print('Show');
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ReceiptUpdatedPage(lastResult)));
        if (lastResult.contains("Successful")==true &&
            lastResult.contains("000")==true &&
            lastResult.contains("unSuccessful")!=true) {
          await paymentOrder(
            familyId: widget.userId,
          );
        } else {
          await CartGetxController.to.cleanCart();
        }
      } else {
        print('Show Blank Data');
      }
    }
    print('Payment : $lastResult');
    if (lastResult.contains("Successful")==true &&lastResult.contains("000")==true) {  print(
        'is the transaction true  }');}else{print(
        'is the transaction false  }');


    }
  }

  Future paymentOrder({
    required int familyId,
  }) async {
    getOrderGetX cont = Get.put(getOrderGetX());

    await cont.payment(
        context: context,
        order_id_page: widget.orderId,
        coupon: widget.copounPage,
        groupValue: widget.groupValue,
        order_cost: widget.order_cost,
        total_cost: widget.total_cost);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // appBar: appBarWhite(
        //   context,
        //   title: AppLocalizations.of(context)!.payment,
        //   onPressed: () async {
        //     await CartGetxController.to.cleanCart();
        //   },
        // ),
        appBar: appBarWhite(context,
            iconBack: null,
            back: false,
            backOk: false,
            onPressedBackBool: false,
            main: true,
            title: AppLocalizations.of(context)!.payment, onPressed: () {
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
            // if (widget.orderIdPage != null) {
            //   await cancelOrder(id: widget.orderIdPage!);
            // } else {
            helper(
                context: context,
                message: AppLocalizations.of(context)!.theCartIsCleaned,
                error: true);
            // }

            await CartGetxController.to.cleanCart();
            await Get.delete<getCartOrderIdGetx>();
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, "/mainScreen");
          }, button2: AppLocalizations.of(context)!.no);
        }, icon: Icons.delete_outline),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StyleText(
                AppLocalizations.of(context)!.choosePayment,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(50),
              ),
              SizedBox(
                width: SizeConfig.scaleWidth(250),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kSecondaryColor),
                  onPressed: () {
    Future.delayed(const Duration(seconds: 1), () async {
                 await   _performtrxn(context, "hosted");});
                  },
                  child:
                      const StyleText('Cards / apple Pay', textColor: Colors.white),
                ),
              ),
              // SizedBox(
              //   height: SizeConfig.scaleHeight(15),
              // ),
              // SizedBox(
              //   width: SizeConfig.scaleWidth(200),
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.grey,
              //     ),
              //     onPressed: () {
              //       _performtrxn(context, "applepay");
              //     },
              //     child: const StyleText('Apple Pay', textColor: Colors.white),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
