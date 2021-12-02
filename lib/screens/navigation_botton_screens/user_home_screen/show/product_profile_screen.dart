import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:http/http.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_dialoge.dart';
import 'package:producer_family_app/storage/models/database/cart.dart';
import 'package:producer_family_app/storage/providersAndGetx/cart_getx_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/home_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'family_profile_screen.dart';

class ProductProfileScreen extends StatefulWidget {
  String product_id = '';

  ProductProfileScreen({this.product_id = ''});

  @override
  _ProductProfileScreenState createState() => _ProductProfileScreenState();
}

class _ProductProfileScreenState extends State<ProductProfileScreen> {
  int _countProduct = 1;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetX<getShowProductGetX>(
        init: getShowProductGetX(
            id: widget.product_id,
            language: Localizations.localeOf(context).languageCode == "ar"
                ? "ar"
                : "en"),
        builder: (getShowProductGetX controller) {
          return Scaffold(
            appBar: AppBarWhite(
              context,
              onPressed: () {},
              title: AppLocalizations.of(context)!.product,
            ),
            body: SafeArea(
                child: controller.isLoading.value
                    ? Center(child: indicator_nourah_loading())
                    : Padding(
                        padding:
                            EdgeInsets.only(bottom: hSpaceLarge, top: hSpace),
                        child: Column(
                          children: [
                            GetX<getShowImageProductGetX>(
                                init: getShowImageProductGetX(
                                    id: widget.product_id),
                                builder: (getShowImageProductGetX controller) {
                                  return controller.isLoading.value
                                      ? Center(
                                          child: indicator_nourah_loading())
                                      : CarouselSlider.builder(
                                          itemCount: controller
                                              .ShowImageproduct.length,
                                          options: CarouselOptions(
                                            autoPlay: true,
                                            viewportFraction: .8,
                                            scrollDirection: Axis.horizontal,
                                            reverse: true,
                                            enlargeCenterPage: true,
                                            enlargeStrategy:
                                                CenterPageEnlargeStrategy
                                                    .height,
                                            autoPlayCurve: Curves.easeInOutBack,
                                            aspectRatio: 2 / 1,
                                          ),
                                          itemBuilder: (context, index,
                                                  realIndex) =>
                                              GestureDetector(
                                                  onTap: () {
                                                    imageDialoge(context,
                                                        imageProduct: controller
                                                            .ShowImageproduct[
                                                                index]
                                                            .image);
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: wSpace,
                                                      right: wSpace,
                                                    ),
                                                    child: controller
                                                            .isLoading.value
                                                        ? Center(
                                                            child:
                                                                indicator_nourah_loading())
                                                        : controller.ShowImageproduct
                                                                    .length !=
                                                                0
                                                            ? image_container(
                                                                controller
                                                                    .ShowImageproduct[
                                                                        index]
                                                                    .image,
                                                                height: 200,
                                                                width: double
                                                                    .infinity,
                                                              )
                                                            : Column(),
                                                  )),
                                        );
                                }),
                            SizedBox(
                              height: hSpaceLargev,
                            ),
                            StyleText(
                              Localizations.localeOf(context).languageCode ==
                                      "ar"
                                  ? "${controller.Showproduct['arname'] ?? ''}"
                                  : "${controller.Showproduct['enname'] ?? ''}",
                              width: double.infinity,
                              fontSize: fLargev,
                              textColor: kSpecialColor,
                            ),
                            SizedBox(
                              height: hSpaceLarge,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  StyleText(
                                    " ${controller.Showproduct['rate'] ?? 0}",
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
                              height: hSpaceLargevv,
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: wSpace, right: wSpace),
                              child: ContainerApp(
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: hSpace, bottom: hSpace),
                                    child: controller.Showproduct[
                                                    "duration_unit"] !=
                                                null ||
                                            controller.Showproduct[
                                                    "duration_unit"] !=
                                                ""
                                        ? StyleText(
                                            "${controller.Showproduct['duration_from'] ?? 0}  -  ${controller.Showproduct['duration_to'] ?? 0} ${controller.Showproduct["duration_unit"] == "h" ? AppLocalizations.of(context)!.hour : controller.Showproduct["duration_unit"] == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                            width: double.infinity,
                                          )
                                        : StyleText("")),
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
                                      ? "${controller.Showproduct['ardesc'] ?? ''}"
                                      : "${controller.Showproduct['endesc'] ?? ''}",
                                  width: SizeConfig.scaleWidth(380),
                                  height: 2,
                                  wordSpacing: 1,
                                  maxLines: 30,
                                )),
                            SizedBox(
                              height: hSpaceLarge,
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: wSpace, right: wSpace),
                              child: ContainerApp(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: hSpace, bottom: hSpace),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      StyleText(
                                        "${controller.Showproduct['offer_price'] ?? 0} ${AppLocalizations.of(context)!.reyal}",
                                        textColor: kSpecialColor,
                                      ),
                                      StyleText(
                                        "${controller.Showproduct['price'] ?? 0} ${AppLocalizations.of(context)!.reyal}",
                                        textDecoration:
                                            TextDecoration.lineThrough,
                                      ),
                                      StyleText(
                                        '|',
                                        textColor: kSpecialColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: fLargev,
                                      ),
                                      StyleText(
                                        "${controller.Showproduct['offer_discount'] ?? 0} %",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
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
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    setState(() {
                                      if (_countProduct != 0) {
                                        _countProduct -= 1;
                                      }
                                    });
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
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      setState(() {
                                        _countProduct += 1;
                                      });
                                    }),
                                SizedBox(
                                  width: wSpace,
                                ),
                                StyleButton(
                                  controller.Showproduct['offer_price'] != null
                                      ? '   ${AppLocalizations.of(context)!.add}    ${_countProduct * controller.Showproduct['offer_price']}  ${AppLocalizations.of(context)!.reyal}'
                                      : '   ${AppLocalizations.of(context)!.add}    0  ${AppLocalizations.of(context)!.reyal}',
                                  width: SizeConfig.scaleWidth(250),
                                  sideColor: kSpecialColor,
                                  backgroundColor: kSpecialColor,
                                  onPressed: () async {
                                    CartGetxController().createItem(
                                        cart: cart);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FamilyProfileScreen(
                                                productId: controller
                                                        .Showproduct['id'] ??
                                                    "",
                                                productQu: _countProduct,
                                                totalPrice:
                                                    controller.Showproduct[
                                                            'offer_price'] *
                                                        _countProduct,
                                                price: controller
                                                    .Showproduct['offer_price'],
                                                productName:
                                                    controller.Showproduct[
                                                            'arname'] ??
                                                        "",
                                                productImage:  controller
                                                    .Showproduct['images'].isNotEmpty  ?
                                                controller
                                                    .Showproduct['images']
                                                [0]["image"]:'',
                                                id: controller.Showproduct[
                                                        'user_id'] ??
                                                    "",
                                              )),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
          );
        });
  }
  Cart get cart {
    getShowProductGetX controller = Get.find();
    Cart cart = Cart();
    cart.id = controller.Showproduct['id'];
    cart.price = controller.Showproduct['offer_price']??controller.Showproduct['price'];
    cart.userId = controller.Showproduct['user_id'];
    cart.productName = controller.Showproduct['arname'];
    cart.productId = controller.Showproduct['id'];
    cart.quantity = _countProduct;
    cart.productImage =
    controller
        .Showproduct['images'].isNotEmpty  ?
    controller
        .Showproduct['images']
    [0]["image"]:'';
    return cart;
  }
}
