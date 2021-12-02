import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/containers/card_widget.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/show/policies_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/show/product_profile_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/show/reviews_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/cart_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/login_screens/login_screen.dart';
import 'package:producer_family_app/storage/providersAndGetx/home_getx.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:producer_family_app/components/containers/show_widget.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FamilyProfileScreen extends StatefulWidget {
  int id;
  String productName;
  String productImage;
  int totalPrice;
  int price;
  int productId;
  int productQu;
  FamilyProfileScreen(
      {this.price = 0,
      this.id = 0,
      this.totalPrice = 0,
      this.productQu = 0,
      this.productId = 0,
      this.productName = "",
      this.productImage = ""});
  int choiceIndex = 0;

  @override
  _FamilyProfileScreenState createState() => _FamilyProfileScreenState();
}

class _FamilyProfileScreenState extends State<FamilyProfileScreen> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // CartGetxController().cleanCart();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWhite(
          context,
          onPressed: () {},
          title: AppLocalizations.of(context)!.family,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            bottom: hCard,
          ),
          child: SingleChildScrollView(
            child: GetX<getShowFamilyGetX>(
                init: getShowFamilyGetX(
                    language:
                        Localizations.localeOf(context).languageCode == "ar"
                            ? "ar"
                            : "en",
                    category: "${widget.choiceIndex}",
                    id: "${widget.id}"),
                builder: (getShowFamilyGetX _getShowFamilyGetX) {
                  if (_getShowFamilyGetX.isLoading.value) {
                    return Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.scaleHeight(360),
                        ),
                        Center(child: indicator_nourah_loading()),
                      ],
                    );
                  } else {
                    return SingleChildScrollView(
                      child: GetX<getShowFamilyGetXMap>(
                          init: getShowFamilyGetXMap(
                              language: Localizations.localeOf(context)
                                          .languageCode ==
                                      "ar"
                                  ? "ar"
                                  : "en",
                              id: "${widget.id}"),
                          builder:
                              (getShowFamilyGetXMap _getShowFamilyGetXMap) {
                            return _getShowFamilyGetXMap.isLoading.value
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: SizeConfig.scaleHeight(360),
                                      ),
                                      Center(child: indicator_nourah_loading()),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: SizeConfig.scaleHeight(240),
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              height:
                                                  SizeConfig.scaleHeight(200),
                                              width: double.infinity,
                                              child: image_container(
                                                  _getShowFamilyGetXMap
                                                                  .showfamily[
                                                              "family"]
                                                          ["cover_image"] ??
                                                      ''),
                                            ),
                                            PositionedDirectional(
                                              bottom: 0,
                                              start: 0,
                                              end: 0,
                                              child: Container(
                                                height:
                                                    SizeConfig.scaleHeight(160),
                                                width:
                                                    SizeConfig.scaleWidth(170),
                                                decoration: BoxDecoration(
                                                  color: kBackgroundColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                            PositionedDirectional(
                                              bottom:
                                                  SizeConfig.scaleHeight(09),
                                              start: 0,
                                              end: 0,
                                              child: image_circle(
                                                imageString:
                                                    _getShowFamilyGetXMap
                                                                    .showfamily[
                                                                "family"]
                                                            ["image"] ??
                                                        '',
                                                radius: 70,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: hSpace,
                                      ),
                                      // StyleText("${CartGetxController().readItems()}"),
                                      StyleText(
                                        _getShowFamilyGetXMap
                                                .showfamily["family"]['name'] ??
                                            '',
                                        fontSize: fLargev,
                                        textColor: kSpecialColor,
                                        letterSpacing: 5,
                                        width: double.infinity,
                                      ),
                                      SizedBox(
                                        height: hSpace,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                color: kSecondaryColor,
                                                size: fIconSmall,
                                              ),
                                              StyleText(
                                                " ${_getShowFamilyGetXMap.showfamily["family"]['km'] ?? 0}",
                                                textAlign: TextAlign.start,
                                                height: 1.5,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: SizeConfig.scaleWidth(30),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: fIconSmall,
                                              ),
                                              StyleText(
                                                " ${_getShowFamilyGetXMap.showfamily["family"]['rate'] ?? 0}",
                                                textAlign: TextAlign.start,
                                                height: 1.5,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: hSpace,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          StyleText(
                                            " ${AppLocalizations.of(context)!.theminimumorder}     ",
                                          ),
                                          StyleText(
                                            "${_getShowFamilyGetXMap.showfamily["family"]["minimum_order"] ?? 0}",
                                            textColor: kSpecialColor,
                                            textDecoration:
                                                TextDecoration.underline,
                                          ),
                                          StyleText(
                                            "  ${AppLocalizations.of(context)!.reyal}",
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: hSpace,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: wSpace, right: wSpace),
                                        child: ContainerApp(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: hSpace, bottom: hSpace),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PoliciesScreen(
                                                                id: "${_getShowFamilyGetXMap.showfamily["family"]['id']}",
                                                              )),
                                                    );
                                                  },
                                                  child: StyleText(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .policies,
                                                    textColor: kSpecialColor,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ReviewsScreen(
                                                                id: "${_getShowFamilyGetXMap.showfamily["family"]['id']}",
                                                              )),
                                                    );
                                                  },
                                                  child: StyleText(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .reviews,
                                                    textColor: kSpecialColor,
                                                  ),
                                                ),
                                                StyleText(
                                                  "${_getShowFamilyGetXMap.showfamily["family"]['available'] == "1" ? "${AppLocalizations.of(context)!.unavailable}" : "${AppLocalizations.of(context)!.available}"}",
                                                  textColor: Colors.green,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                            left: wPadding,
                                            right: wPadding,
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: hSpace,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: wPadding,
                                                  right: wPadding,
                                                  top: hPadding,
                                                  bottom: hPadding,
                                                ),
                                                child: StyleText(
                                                  Localizations.localeOf(
                                                                  context)
                                                              .languageCode ==
                                                          "ar"
                                                      ? "${_getShowFamilyGetXMap.showfamily["family"]['notes'] ?? 'لا يوجد وصف عن الأسرة'}"
                                                      : "${_getShowFamilyGetXMap.showfamily["family"]['ennotes'] ?? 'no discription about the family'}",
                                                  textAlign: TextAlign.center,
                                                  maxLines: 10,
                                                ),
                                              ),
                                              divider_app(),
                                              _getShowFamilyGetXMap.showfamily[
                                                              "family"]
                                                          ['available'] ==
                                                      1
                                                  ? Column(
                                                      children: [
                                                        _getShowFamilyGetX
                                                                    .specialproducts
                                                                    .value
                                                                    .data
                                                                    .length !=
                                                                0
                                                            ? CarouselSlider
                                                                .builder(
                                                                    itemCount: _getShowFamilyGetX
                                                                        .specialproducts
                                                                        .value
                                                                        .data
                                                                        .length,
                                                                    options:
                                                                        CarouselOptions(
                                                                      viewportFraction:
                                                                          1,
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      autoPlay:
                                                                          true,
                                                                      reverse:
                                                                          true,
                                                                      enlargeCenterPage:
                                                                          true,
                                                                      enlargeStrategy:
                                                                          CenterPageEnlargeStrategy
                                                                              .height,
                                                                      autoPlayCurve:
                                                                          Curves
                                                                              .easeInOutBack,
                                                                    ),
                                                                    itemBuilder: (context,
                                                                            index,
                                                                            realIndex) =>
                                                                        GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (context) => ProductProfileScreen(
                                                                                          product_id: "${_getShowFamilyGetX.specialproducts.value.data[index].id}",
                                                                                        )),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Show_family_widget(
                                                                              Column(),
                                                                              product_id: "${_getShowFamilyGetX.specialproducts.value.data[index].id}",
                                                                              productName: Localizations.localeOf(context).languageCode == "ar" ? "${_getShowFamilyGetX.specialproducts.value.data[index].arname}" : "${_getShowFamilyGetX.specialproducts.value.data[index].enname}",
                                                                              familyLocation: "${_getShowFamilyGetX.specialproducts.value.data[index].km} ",
                                                                              price: "${_getShowFamilyGetX.specialproducts.value.data[index].offerPrice} ${AppLocalizations.of(context)!.reyal}",
                                                                              priceBefore: "${_getShowFamilyGetX.specialproducts.value.data[index].price}",
                                                                              discount: "%${_getShowFamilyGetX.specialproducts.value.data[index].offerDiscount}",
                                                                              time: "${_getShowFamilyGetX.specialproducts.value.data[index].durationUnit}${_getShowFamilyGetX.specialproducts.value.data[index].durationTo}-${_getShowFamilyGetX.specialproducts.value.data[index].durationFrom}",
                                                                              rate: " ${_getShowFamilyGetX.specialproducts.value.data[index].familyrate}",
                                                                              state: 10,
                                                                              discountBool: true,
                                                                              image: "${_getShowFamilyGetX.specialproducts.value.data[index].images}",
                                                                            )))
                                                            : Column(
                                                                children: [
                                                                  noContent(
                                                                      context,
                                                                      "  ${AppLocalizations.of(context)!.thereIsnoSales}",
                                                                      height:
                                                                          20),
                                                                  SizedBox(
                                                                    height:
                                                                        hSpace,
                                                                  )
                                                                ],
                                                              ),
                                                        divider_app(),
                                                        _getShowFamilyGetX
                                                                    .familycategories
                                                                    .length !=
                                                                0
                                                            ? SizedBox(
                                                                height: SizeConfig
                                                                    .scaleWidth(
                                                                        50),
                                                                child: Row(
                                                                  children: [
                                                                    _getShowFamilyGetX
                                                                            .familycategories
                                                                            .value
                                                                            .isNotEmpty
                                                                        ? Expanded(
                                                                            child: ListView.builder(
                                                                                scrollDirection: Axis.horizontal,
                                                                                shrinkWrap: true,
                                                                                itemCount: _getShowFamilyGetX.familycategories.length + 1,
                                                                                itemBuilder: (context, indexFilter) {
                                                                                  return indexFilter == 0
                                                                                      ? Row(
                                                                                          children: [
                                                                                            ChoiceChip(
                                                                                              label: StyleText(
                                                                                                AppLocalizations.of(context)!.all,
                                                                                                textColor: kSecondaryColor,
                                                                                              ),
                                                                                              elevation: 3,
                                                                                              selectedColor: kSpecialColor.withOpacity(.8),
                                                                                              backgroundColor: kBackgroundColor,
                                                                                              onSelected: (bool isSelected) {
                                                                                                setState(() {
                                                                                                  widget.choiceIndex = isSelected ? indexFilter : widget.choiceIndex;
                                                                                                  print(indexFilter);
                                                                                                  getShowFamilyGetX.to.filterProductsFamilyByCategory(categoryId: indexFilter);

                                                                                                });
                                                                                              },
                                                                                              selected: widget.choiceIndex == indexFilter,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: wSpaceSmall,
                                                                                            )
                                                                                          ],
                                                                                        )
                                                                                      : Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                                          children: [
                                                                                            ChoiceChip(
                                                                                                label: StyleText(
                                                                                                  Localizations.localeOf(context).languageCode == "ar" ? _getShowFamilyGetX.familycategories[indexFilter - 1].arname : _getShowFamilyGetX.familycategories[indexFilter - 1].enname,
                                                                                                  textColor: kSecondaryColor,
                                                                                                ),
                                                                                                elevation: 3,
                                                                                                selectedColor: kSpecialColor.withOpacity(.8),
                                                                                                backgroundColor: kBackgroundColor,
                                                                                                onSelected: (bool isSelected) {
                                                                                                  setState(() {
                                                                                                    widget.choiceIndex = isSelected ? indexFilter : widget.choiceIndex;
                                                                                                    print(indexFilter);
                                                                                                    print(widget.choiceIndex);

                                                                                                    getShowFamilyGetX.to.filterProductsFamilyByCategory(categoryId: indexFilter);
                                                                                                  });
                                                                                                },
                                                                                                selected: widget.choiceIndex == indexFilter),
                                                                                            SizedBox(
                                                                                              width: wSpaceSmall,
                                                                                            )
                                                                                          ],
                                                                                        );
                                                                                }),
                                                                          )
                                                                        : Column(),
                                                                  ],
                                                                ),
                                                              )
                                                            : Column(),

                                                        SizedBox(
                                                          height: hSpaceSmall,
                                                        ),
                                                        _getShowFamilyGetX
                                                                    .products
                                                                    .value
                                                                    .data
                                                                    .length !=
                                                                0
                                                            ? ListView.builder(
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    NeverScrollableScrollPhysics(),
                                                                itemCount:
                                                                    _getShowFamilyGetX
                                                                        .products
                                                                        .value
                                                                        .data
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      Navigator
                                                                          .pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                ProductProfileScreen(
                                                                                  product_id: "${_getShowFamilyGetX.products.value.data[index].id}",
                                                                                )),
                                                                      );
                                                                    },
                                                                    child:
                                                                        CardWidget(
                                                                      Column(),
                                                                      productName: Localizations.localeOf(context).languageCode ==
                                                                              "ar"
                                                                          ? "${_getShowFamilyGetX.products.value.data[index].arname}"
                                                                          : "${_getShowFamilyGetX.products.value.data[index].enname}",
                                                                      familyLocation:
                                                                          "${_getShowFamilyGetX.products.value.data[index].km} ",
                                                                      price:
                                                                          "${_getShowFamilyGetX.products.value.data[index].offerPrice} ${AppLocalizations.of(context)!.reyal}",
                                                                      priceBefore:
                                                                          "${_getShowFamilyGetX.products.value.data[index].price}",
                                                                      discount:
                                                                          "%${_getShowFamilyGetX.products.value.data[index].offerDiscount}",
                                                                      time:
                                                                          "${_getShowFamilyGetX.products.value.data[index].durationUnit}${_getShowFamilyGetX.products.value.data[index].durationTo}-${_getShowFamilyGetX.products.value.data[index].durationFrom}",
                                                                      rate:
                                                                          " ${_getShowFamilyGetX.products.value.data[index].familyrate}",
                                                                      page:
                                                                          "${_getShowFamilyGetX.products.value.data[index].id}",
                                                                      familyScreens:
                                                                          true,
                                                                      discountBoolCard:
                                                                          true,
                                                                      state: 10,
                                                                      image:
                                                                          "${_getShowFamilyGetX.products.value.data[index].images}",
                                                                    ),
                                                                  );
                                                                },
                                                              )
                                                            : Column(
                                                                children: [
                                                                  divider_app(),
                                                                  noContent(
                                                                      context,
                                                                      "  ${AppLocalizations.of(context)!.thereIsnoProducts}",
                                                                      height:
                                                                          30),
                                                                ],
                                                              ),
                                                      ],
                                                    )
                                                  : noContent(context,
                                                      "  ${AppLocalizations.of(context)!.theFamilyIsNotAvailableNow}",
                                                      height: 100),
                                            ],
                                          ))
                                    ],
                                  );
                          }),
                    );
                  }
                }),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: widget.totalPrice != 0
            ? SizedBox(
          width: 180,
              child: StyleButton(
              "${AppLocalizations.of(context)!.cart}",
                  onPressed: () async {
                    await SharedPreferencesController().isLoggedInUser
                        ? Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen(
                                      totalPrice: widget.totalPrice,
                                      id: "${widget.id}",
                                      productQu: widget.productQu,
                                      productId: widget.productId,
                                      productName: widget.productName,
                                      productImage: widget.productImage,
                                      price: widget.price,
                                    )))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                      totalPrice: widget.totalPrice,
                                      id: "${widget.id}",
                                      productQu: widget.productQu,
                                      productId: widget.productId,
                                      productName: widget.productName,
                                      productImage: widget.productImage,
                                      price: widget.price,
                                    )));
                    },
                  width: SizeConfig.scaleWidth(400),
                  height: SizeConfig.scaleHeight(65),
                  backgroundColor: kSpecialColor,
                  sideColor: kSpecialColor,
                ),
            )
            : Column());
  }
}
