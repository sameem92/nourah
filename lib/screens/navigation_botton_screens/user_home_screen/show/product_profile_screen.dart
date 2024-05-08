import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_dialoge.dart';
import 'package:producer_family_app/storage/models/cart.dart';
import 'package:producer_family_app/storage/providersAndGetx/cart_getx_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/home_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

import 'family_profile_screen.dart';

class ProductProfileScreen extends StatefulWidget {
  final int productId;
  final bool justShow;
  const ProductProfileScreen({required this.productId, this.justShow = false});

  @override
  _ProductProfileScreenState createState() => _ProductProfileScreenState();
}

class _ProductProfileScreenState extends State<ProductProfileScreen> {
  int _countProduct = 1;
  @override
  void initState() {
    super.initState();
    // Get.delete<HomeGetx>();
  }

  CartGetxController controller = Get.put(CartGetxController());
  @override
  Widget build(BuildContext context) {
    // getShowImageProductGetX controllerImage=Get.put(getShowImageProductGetX(id: widget.product_id,));

    return GetX<GetShowProductGetX>(
        init: GetShowProductGetX(
            id: widget.productId,
            language: Localizations.localeOf(context).languageCode == "ar"
                ? "ar"
                : "en"),
        builder: (GetShowProductGetX controller) {
          return Scaffold(
            appBar: appBarWhite(
              context,
              onPressed: () {},
              title: AppLocalizations.of(context)!.product,
            ),
            body: SafeArea(
                child: controller.isLoading.value
                    ? Center(child: indicatorNourahLoadingSpecial())
                    : Padding(
                        padding:
                            EdgeInsets.only(bottom: hSpaceLarge, top: hSpace),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              GetX<GetShowImageProductGetX>(
                                  init: GetShowImageProductGetX(
                                      id: widget.productId),
                                  builder:
                                      (GetShowImageProductGetX controller2) {
                                    return controller2.isLoading.value
                                        ? Center(
                                            child: indicatorNourahLoading())
                                        : GestureDetector(
                                            onTap: () {
                                              imageDialoge(context,
                                                  imageProduct: controller2
                                                          .showImageproduct
                                                          .isNotEmpty
                                                      ? controller.showProduct[
                                                                  'images'][0]
                                                              ['image'] ??
                                                          "" ??
                                                          ''
                                                      : null);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: wSpace,
                                                right: wSpace,
                                              ),
                                              child: controller2
                                                      .showImageproduct
                                                      .isNotEmpty
                                                  ? Container(
                                                      width:
                                                          SizeConfig.scaleWidth(
                                                              350),
                                                      padding: EdgeInsets.zero,
                                                      margin: EdgeInsets.zero,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: kGrey
                                                                  .withOpacity(
                                                                      .1),
                                                              blurRadius: 2,
                                                              spreadRadius: 1)
                                                        ],
                                                        backgroundBlendMode:
                                                            BlendMode
                                                                .luminosity,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                borderRadius),
                                                        color: Colors.white,
                                                      ),
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          borderRadius),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          borderRadius),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          borderRadius),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          borderRadius),
                                                                ),
                                                                child: ImageContainer(
                                                                    controller2
                                                                        .showImageproduct[
                                                                            0]
                                                                        .image,
                                                                    height: 310,
                                                                    width:
                                                                        350)),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      height: SizeConfig
                                                          .scaleHeight(200),
                                                    ),
                                            ));
                                  }),
                              //
                              SizedBox(
                                height: hSpaceLarge,
                              ),
                              StyleText(
                                Localizations.localeOf(context).languageCode ==
                                        "ar"
                                    ? "${controller.showProduct['arname'] ?? ''}"
                                    : "${controller.showProduct['enname'] ?? ''}",
                                width: double.infinity,
                                fontSize: fLargev,
                                textColor: kSpecialColor,
                              ),
                              SizedBox(
                                height: hSpace,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    StyleText(
                                      " ${controller.showProduct['rate'] ?? 0}",
                                      textAlign: TextAlign.start,
                                      height: 1.5,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: fIconSmall,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: hSpaceLarge,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: wSpace, right: wSpace),
                                child: ContainerApp(
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: hSpace, bottom: hSpace),
                                      child: controller.showProduct[
                                                      "duration_unit"] !=
                                                  null &&
                                              controller.showProduct[
                                                      "duration_unit"] !=
                                                  ""
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                StyleText(AppLocalizations.of(
                                                        context)!
                                                    .processingTime),
                                                StyleText(
                                                  "${controller.showProduct['duration_from'] ?? 0}  -  ${controller.showProduct['duration_to'] ?? 0} ${controller.showProduct["duration_unit"] == "h" ? AppLocalizations.of(context)!.hour : controller.showProduct["duration_unit"] == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                                ),
                                              ],
                                            )
                                          : const StyleText("")),
                                ),
                              ),
                              Container(
                                  // height: SizeConfig.scaleHeight(150),
                                  padding: EdgeInsetsDirectional.only(
                                    start: wPadding,
                                    end: wPadding,
                                    top: hPadding,
                                    bottom: hPadding,
                                  ),
                                  alignment: Alignment.center,
                                  child: StyleText(
                                    Localizations.localeOf(context)
                                                .languageCode ==
                                            "ar"
                                        ? "${controller.showProduct['ardesc'] ?? ''}"
                                        : "${controller.showProduct['endesc'] ?? ''}",
                                    width: SizeConfig.scaleWidth(380),
                                    height: 2,
                                    wordSpacing: 1,
                                    maxLines: 30,
                                  )),

                              Container(
                                margin: EdgeInsets.only(
                                    left: wSpace, right: wSpace),
                                child: ContainerApp(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: hSpace, bottom: hSpace),
                                    child: controller
                                                .showProduct['offer_status'] ==
                                            1
                                        ? Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  StyleText(
                                                    controller.showProduct[
                                                                'offer_price'] !=
                                                            null
                                                        ? "${controller.showProduct['offer_price'] ?? 0} ${AppLocalizations.of(context)!.reyal}"
                                                        : "",
                                                    textColor: kSpecialColor,
                                                  ),
                                                  StyleText(
                                                    "${controller.showProduct['price'] ?? 0} ${AppLocalizations.of(context)!.reyal}",
                                                    textDecoration:
                                                        TextDecoration
                                                            .lineThrough,
                                                  ),
                                                  StyleText(
                                                    '|',
                                                    textColor: kSpecialColor,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: fLargev,
                                                  ),
                                                  StyleText(
                                                    "${controller.showProduct['offer_discount'] ?? 0} %",
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: hSpaceLargev,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  StyleText(
                                                    "${AppLocalizations.of(context)!.discountLeft} :",
                                                  ),
                                                  StyleText(
                                                    "${controller.showProduct['offertime']['days'] * 24 + controller.showProduct['offertime']['hours']}:${controller.showProduct['offertime']['minutes']}:${controller.showProduct['offertime']['seconds']}",
                                                    textColor: kSpecialColor,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : StyleText(
                                            "${controller.showProduct['price'] ?? 0}   ${AppLocalizations.of(context)!.reyal}",
                                            // fontSize:fLarge ,
                                          ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: hSpaceLargev,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: kSpecialColor.withOpacity(.9),
                                      size: fIconLarge,
                                    ),
                                    disabledColor: Colors.grey,
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {
                                      if (!mounted) {
                                      } else {
                                        setState(() {
                                          if (_countProduct != 1) {
                                            _countProduct -= 1;
                                          }
                                        });
                                      }
                                    },
                                  ),
                                  StyleText(
                                    _countProduct.toString(),
                                    fontWeight: FontWeight.w700,
                                    fontSize: fLargev,
                                    textColor: kSpecialColor.withOpacity(.9),
                                    height: 1.4,
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.add_circle_outlined,
                                        color: kSpecialColor.withOpacity(.9),
                                        size: fIconLarge,
                                      ),
                                      disabledColor: Colors.grey,
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {
                                        if (!mounted) {
                                        } else {
                                          setState(() {
                                            _countProduct += 1;
                                          });
                                        }
                                      }),
                                  SizedBox(
                                    width: wSpace,
                                  ),
                                  StyleButton(
                                    controller.showProduct['offer_status'] == 1
                                        ? '   ${AppLocalizations.of(context)!.add}    ${_countProduct * controller.showProduct['offer_price']}  ${AppLocalizations.of(context)!.reyal}'
                                        : controller.showProduct['price'] !=
                                                null
                                            ? '   ${AppLocalizations.of(context)!.add}    ${_countProduct * controller.showProduct['price']}  ${AppLocalizations.of(context)!.reyal}'
                                            : "",
                                    width: SizeConfig.scaleWidth(270),
                                    sideColor: kSpecialColor,
                                    backgroundColor: kSpecialColor,
                                    widthText: SizeConfig.scaleWidth(200),
                                    onPressed: () {
                                      if (widget.justShow != true) {
                                        CartGetxController.to
                                            .createItem(cart: cart);
                                        CartGetxController.to.addTotalPrice(
                                            cart.intialPrice!.toDouble() *
                                                _countProduct);

                                        CartGetxController.to.addCounterCustom(
                                                _countProduct) ??
                                            0;

                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FamilyProfileScreen(
                                                    productQu: _countProduct,
                                                    userId: controller
                                                        .showProduct['user_id'],
                                                    justShow: false,
                                                  )),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
          );
        });
  }

  Cart get cart {
    GetShowProductGetX controller = Get.find();
    Cart cart = Cart();
    cart.id = controller.showProduct['id'] ?? 0;
    cart.total = controller.showProduct['offer_status'] == 1
        ? controller.showProduct['offer_price'] * _countProduct
        : controller.showProduct['price'] * _countProduct;
    cart.userId = controller.showProduct['user_id'] ?? 0;
    cart.productName = "${controller.showProduct['arname'] ?? ""}";
    cart.productId = controller.showProduct['id'] ?? 0;
    cart.qty = _countProduct;
    cart.offerStatus = controller.showProduct['offer_status'] == 1 ? 1 : 0;
    cart.intialPrice = controller.showProduct['offer_status'] == 1
        ? controller.showProduct['offer_price']
        : controller.showProduct['price'];
    cart.productImage = controller.showProduct['images'].isNotEmpty
        ? "${controller.showProduct['images'][0]["image"]}"
        : '';

    return cart;
  }
}
