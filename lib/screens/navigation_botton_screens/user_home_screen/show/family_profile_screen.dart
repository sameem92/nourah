import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:http/http.dart' as http;
import 'package:producer_family_app/components/containers/card_widget.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/containers/show_widget.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_dialoge.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/cart_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/login_screens/login_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/show/policies_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/show/product_profile_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/show/reviews_screen.dart';
import 'package:producer_family_app/storage/providersAndGetx/cart_getx_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/home_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:provider/provider.dart';

import '../../../../storage/models/show_modal/show_family.dart';

class FamilyProfileScreen extends StatefulWidget {
  final int userId;
  final int productQu;
  final bool justShow;
  FamilyProfileScreen({
    required this.userId,
    this.productQu = 0,
    required this.justShow,
  });
  int choiceIndex = 0;

  @override
  _FamilyProfileScreenState createState() => _FamilyProfileScreenState();
}

class _FamilyProfileScreenState extends State<FamilyProfileScreen> {
  List<ProductsFamily> products = [];
  List<ProductsFamily> newProducts = [];
  final controller = ScrollController();
  int page = 2;
  bool hasMore = true;
  bool noProducts = false;
  @override
  void initState() {
    // getProfileGetx cont = Get.put(getProfileGetx());
    Get.put(GetShowFamilyGetX(id: widget.userId));
    super.initState();

    // Get.put(GetShowFamilyGetX(id: widget.userId));
    fetch();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        print('ready');
        fetch();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();

    if (widget.productQu == 0) {
      Get.delete<GetShowFamilyGetX>();
      Get.delete<GetShowFamilyGetXMap>();
    } else {
      // print("there is no delete for gets profile family");
    }
    super.dispose();
  }

  Future fetch() async {
    // int? total = GetShowFamilyGetX.to.products.value.total;
    // if (page > 1 && hasMore == true && noProducts == false) {
    // print("total: $total");
    var url = Uri.parse("https://nourah.store/api/v2/showfamily?page=$page");
    var response = await http.post(url, headers: {
      'accept': 'application/json',
      'Accept-Language': "ar",
      'Accept-country': '1'
    }, body: {
      'family_id': widget.userId.toString(),
      'category': "${widget.choiceIndex}",
      "lat": "${Provider.of<LatNotiferUser>(context, listen: false).latUser}",
      'lng': "${Provider.of<LongNotiferUser>(context, listen: false).longUser}",
    });
    if (response.statusCode < 400) {
      // print('good');
      if (!mounted) {
      } else {
        setState(() {
          page++;
        });
      }

      var jsonArray =
          jsonDecode(response.body)['data']['products']['data'] as List;
      newProducts = jsonArray
          .map((jsonObject) => ProductsFamily.fromJson(jsonObject))
          .toList();
      // print("newProducts.length ${newProducts.length}");
      // print("products.length old ${products.length}");
      // print("newProducts.isEmpty : ${newProducts.isEmpty}");
      if (!mounted) {
      } else {
        setState(() {
          products.addAll(newProducts);
          // print("products.length new ${products.length}");

          // if (products.length == total) {
          //   hasMore = false;
          // }
          if (newProducts.isEmpty) {
            noProducts = true;
          }
        });
      }
    }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => widget.productQu != 0 ? false : true,
      child: Scaffold(
          appBar: appBarWhite(
            context,
            main: widget.justShow != true ? true : false,
            backOk: widget.productQu != 0 ? false : true,
            onPressedBackBool: widget.productQu != 0 ? true : false,
            onPressedBack: () async {
              if (widget.productQu != 0) {
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
                  widget.justShow == true
                      ? Navigator.pop(context)
                      : Navigator.pushReplacementNamed(context, "/mainScreen");
                  await CartGetxController.to.cleanCart();
                  Get.delete<GetShowFamilyGetX>();
                  Get.delete<GetShowFamilyGetXMap>();
                  helper(
                      context: context,
                      message: AppLocalizations.of(context)!.theCartIsCleaned,
                      error: true);
                }, button2: AppLocalizations.of(context)!.no);
              }
            },
            onPressed: () {},
            title: AppLocalizations.of(context)!.family,
          ),
          body: Padding(
            padding: EdgeInsets.only(
              bottom: hCard,
            ),
            child: SingleChildScrollView(
              controller: controller,
              child: GetX<GetShowFamilyGetX>(
                  init: GetShowFamilyGetX(
                    language:
                        Localizations.localeOf(context).languageCode == "ar"
                            ? "ar"
                            : "en",
                    category: "${widget.choiceIndex}",
                    id: widget.userId,
                    lat:
                        "${Provider.of<LatNotiferUser>(context, listen: false).latUser}",
                    lng:
                        "${Provider.of<LongNotiferUser>(context, listen: false).longUser}",
                  ),
                  builder: (GetShowFamilyGetX getShowFamilyGetX) {
                    products = getShowFamilyGetX.products.value.data;

                    if (getShowFamilyGetX.isLoading.value) {
                      return Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.scaleHeight(360),
                          ),
                          Center(child: indicatorNourahLoadingSpecial()),
                        ],
                      );
                    } else {
                      return SingleChildScrollView(
                        child: GetX<GetShowFamilyGetXMap>(
                            init: GetShowFamilyGetXMap(
                              language: Localizations.localeOf(context)
                                          .languageCode ==
                                      "ar"
                                  ? "ar"
                                  : "en",
                              id: widget.userId,
                              lat:
                                  "${Provider.of<LatNotiferUser>(context, listen: false).latUser}",
                              lng:
                                  "${Provider.of<LongNotiferUser>(context, listen: false).longUser}",
                            ),
                            builder:
                                (GetShowFamilyGetXMap getShowFamilyGetXMap) {
                              return getShowFamilyGetXMap.isLoading.value
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(360),
                                        ),
                                        Center(child: indicatorNourahLoading()),
                                      ],
                                    )
                                  : getShowFamilyGetXMap.showfamily["family"] !=
                                          null
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              height:
                                                  SizeConfig.scaleHeight(240),
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        SizeConfig.scaleHeight(
                                                            200),
                                                    width: double.infinity,
                                                    child: ImageContainer(getShowFamilyGetXMap
                                                                    .showfamily[
                                                                "family"] !=
                                                            null
                                                        ? getShowFamilyGetXMap
                                                                        .showfamily[
                                                                    "family"][
                                                                "cover_image"] ??
                                                            ''
                                                        : ""),
                                                  ),
                                                  PositionedDirectional(
                                                    bottom: 0,
                                                    start: 0,
                                                    end: 0,
                                                    child: Container(
                                                      height: SizeConfig
                                                          .scaleHeight(160),
                                                      width:
                                                          SizeConfig.scaleWidth(
                                                              170),
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: kBackgroundColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  ),
                                                  PositionedDirectional(
                                                    bottom:
                                                        SizeConfig.scaleHeight(
                                                            09),
                                                    start: 0,
                                                    end: 0,
                                                    child: ImageCircle(
                                                      imageString: getShowFamilyGetXMap
                                                                      .showfamily[
                                                                  "family"] !=
                                                              null
                                                          ? getShowFamilyGetXMap
                                                                          .showfamily[
                                                                      "family"]
                                                                  ["image"] ??
                                                              ''
                                                          : "",
                                                      radius: 70,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: hSpace,
                                            ),
                                            StyleText(
                                              getShowFamilyGetXMap.showfamily[
                                                          "family"] !=
                                                      null
                                                  ? getShowFamilyGetXMap
                                                              .showfamily[
                                                          "family"]['name'] ??
                                                      ''
                                                  : "",
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
                                                      Icons
                                                          .location_on_outlined,
                                                      color: kSpecialColor,
                                                      size: fIconSmall,
                                                    ),
                                                    StyleText(
                                                      " ${getShowFamilyGetXMap.showfamily["family"] != null ? getShowFamilyGetXMap.showfamily["family"]['km'] ?? 0 : ""}",
                                                      textAlign:
                                                          TextAlign.start,
                                                      height: 1.5,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width:
                                                      SizeConfig.scaleWidth(30),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      size: fIconSmall,
                                                    ),
                                                    StyleText(
                                                      " ${getShowFamilyGetXMap.showfamily["family"] != null ? getShowFamilyGetXMap.showfamily["family"]['rate'] : ""}",
                                                      textAlign:
                                                          TextAlign.start,
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
                                                  "${getShowFamilyGetXMap.showfamily["family"] != null ? getShowFamilyGetXMap.showfamily["family"]["minimum_order"] ?? 0 : ""}",
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
                                                      top: hSpace,
                                                      bottom: hSpace),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        PoliciesScreen(
                                                                          id: getShowFamilyGetXMap.showfamily["family"]
                                                                              [
                                                                              'id'],
                                                                        )),
                                                          );
                                                        },
                                                        child: StyleText(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .policies,
                                                          textColor:
                                                              kSpecialColor,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ReviewsScreen(
                                                                          id: getShowFamilyGetXMap.showfamily["family"]
                                                                              [
                                                                              'id'],
                                                                        )),
                                                          );
                                                        },
                                                        child: StyleText(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .reviews,
                                                          textColor:
                                                              kSpecialColor,
                                                        ),
                                                      ),
                                                      StyleText(
                                                        getShowFamilyGetXMap
                                                                        .showfamily[
                                                                    "family"] !=
                                                                null
                                                            ? getShowFamilyGetXMap
                                                                            .showfamily["family"]
                                                                        [
                                                                        'available'] ==
                                                                    1
                                                                ? AppLocalizations.of(
                                                                        context)!
                                                                    .available
                                                                : AppLocalizations.of(
                                                                        context)!
                                                                    .unavailable
                                                            : "",
                                                        textColor: getShowFamilyGetXMap
                                                                        .showfamily[
                                                                    "family"] !=
                                                                null
                                                            ? getShowFamilyGetXMap
                                                                            .showfamily["family"]
                                                                        [
                                                                        'available'] ==
                                                                    1
                                                                ? kConfirm
                                                                : kRefuse
                                                            : kConfirm,
                                                        textAlign:
                                                            TextAlign.center,
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
                                                    Localizations.localeOf(
                                                                    context)
                                                                .languageCode ==
                                                            "ar"
                                                        ? getShowFamilyGetXMap
                                                                        .showfamily[
                                                                    "family"] !=
                                                                null
                                                            ? getShowFamilyGetXMap
                                                                            .showfamily["family"]
                                                                        [
                                                                        'notes'] !=
                                                                    null
                                                                ? Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            hSpace,
                                                                      ),
                                                                      Padding(
                                                                          padding: EdgeInsets
                                                                              .only(
                                                                            left:
                                                                                wPadding,
                                                                            right:
                                                                                wPadding,
                                                                            top:
                                                                                hPadding,
                                                                            bottom:
                                                                                hPadding,
                                                                          ),
                                                                          child:
                                                                              StyleText(
                                                                            "${getShowFamilyGetXMap.showfamily["family"]['notes'] ?? ''}",
                                                                            height:
                                                                                SizeConfig.scaleHeight(2),
                                                                            maxLines:
                                                                                10,
                                                                          )),
                                                                    ],
                                                                  )
                                                                : const SizedBox()
                                                            : getShowFamilyGetXMap
                                                                            .showfamily[
                                                                        "family"] !=
                                                                    null
                                                                ? getShowFamilyGetXMap.showfamily["family"]
                                                                            [
                                                                            'ennotes'] !=
                                                                        null
                                                                    ? Column(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                hSpace,
                                                                          ),
                                                                          Padding(
                                                                              padding: EdgeInsets.only(
                                                                                left: wPadding,
                                                                                right: wPadding,
                                                                                top: hPadding,
                                                                                bottom: hPadding,
                                                                              ),
                                                                              child: StyleText(
                                                                                "${getShowFamilyGetXMap.showfamily["family"]['ennotes'] ?? ''}",
                                                                                height: SizeConfig.scaleHeight(2),
                                                                                maxLines: 10,
                                                                              )),
                                                                          dividerApp(),
                                                                        ],
                                                                      )
                                                                    : const SizedBox()
                                                                : const SizedBox()
                                                        : const SizedBox(),
                                                    if (getShowFamilyGetXMap
                                                                .showfamily[
                                                            "family"] !=
                                                        null)
                                                      getShowFamilyGetXMap.showfamily[
                                                                      "family"][
                                                                  'available'] ==
                                                              1
                                                          ? Column(
                                                              children: [
                                                                getShowFamilyGetX
                                                                        .specialproducts
                                                                        .value
                                                                        .data
                                                                        .isNotEmpty
                                                                    ? Column(
                                                                        children: [
                                                                          dividerApp(),
                                                                          CarouselSlider.builder(
                                                                              itemCount: getShowFamilyGetX.specialproducts.value.data.length,
                                                                              options: CarouselOptions(
                                                                                viewportFraction: 1,
                                                                                scrollDirection: Axis.horizontal,
                                                                                autoPlay: getShowFamilyGetX.specialproducts.value.data.length != 1 ? true : false,
                                                                                reverse: true,
                                                                                enlargeCenterPage: true,
                                                                                enlargeStrategy: CenterPageEnlargeStrategy.height,
                                                                                autoPlayCurve: Curves.easeInOutBack,
                                                                              ),
                                                                              itemBuilder: (context, index, realIndex) => GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                          builder: (context) => ProductProfileScreen(
                                                                                                productId: getShowFamilyGetX.specialproducts.value.data[index].id,
                                                                                                justShow: widget.justShow,
                                                                                              )),
                                                                                    );
                                                                                  },
                                                                                  child: ShowFamilyWidget(
                                                                                    Column(),
                                                                                    productId: getShowFamilyGetX.specialproducts.value.data[index].id,
                                                                                    productName: Localizations.localeOf(context).languageCode == "ar"
                                                                                        ? getShowFamilyGetX.specialproducts.value.data[index].arname
                                                                                        : getShowFamilyGetX.specialproducts.value.data[index].enname != ''
                                                                                            ? getShowFamilyGetX.specialproducts.value.data[index].enname
                                                                                            : getShowFamilyGetX.specialproducts.value.data[index].arname,
                                                                                    price: "${getShowFamilyGetX.specialproducts.value.data[index].offerStatus == 1 ? getShowFamilyGetX.specialproducts.value.data[index].offerPrice : getShowFamilyGetX.specialproducts.value.data[index].price} ${AppLocalizations.of(context)!.reyal}",
                                                                                    priceBefore: "${getShowFamilyGetX.specialproducts.value.data[index].price}",
                                                                                    discount: "%${getShowFamilyGetX.specialproducts.value.data[index].offerDiscount}",
                                                                                    time: "${getShowFamilyGetX.specialproducts.value.data[index].durationTo}-${getShowFamilyGetX.specialproducts.value.data[index].durationFrom} "
                                                                                        "${getShowFamilyGetX.specialproducts.value.data[index].durationUnit == "h" ? AppLocalizations.of(context)!.hour : getShowFamilyGetX.specialproducts.value.data[index].durationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                                                                    state: 10,
                                                                                    familyProfile: true,
                                                                                    discountBool: getShowFamilyGetX.specialproducts.value.data[index].offerStatus == 1 ? true : false,
                                                                                    image: getShowFamilyGetX.specialproducts.value.data[index].images,
                                                                                  ))),
                                                                        ],
                                                                      )
                                                                    : const SizedBox(),
                                                                getShowFamilyGetX
                                                                        .familycategories
                                                                        .isNotEmpty
                                                                    ? Column(
                                                                        children: [
                                                                          dividerApp(),
                                                                          SizedBox(
                                                                            height:
                                                                                SizeConfig.scaleWidth(50),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                getShowFamilyGetX.familycategories.value.isNotEmpty
                                                                                    ? Expanded(
                                                                                        child: ListView.builder(
                                                                                            scrollDirection: Axis.horizontal,
                                                                                            shrinkWrap: true,
                                                                                            itemCount: getShowFamilyGetX.familycategories.length + 1,
                                                                                            itemBuilder: (context, indexFilter) {
                                                                                              return indexFilter == 0
                                                                                                  ? Row(
                                                                                                      children: [
                                                                                                        ChoiceChip(
                                                                                                          label: StyleText(
                                                                                                            AppLocalizations.of(context)!.all,
                                                                                                            textColor: widget.choiceIndex == indexFilter ? Colors.white : kSpecialColor,
                                                                                                          ),
                                                                                                          elevation: 2,
                                                                                                          selectedColor: kSpecialColor.withOpacity(.8),
                                                                                                          backgroundColor: kBackgroundColor,
                                                                                                          onSelected: (bool isSelected) {
                                                                                                            setState(() {
                                                                                                              widget.choiceIndex = isSelected ? indexFilter : widget.choiceIndex;
                                                                                                              // print(indexFilter);

                                                                                                              GetShowFamilyGetX.to.filterProductsFamilyByCategory(categoryId: 0);
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
                                                                                                              Localizations.localeOf(context).languageCode == "ar"
                                                                                                                  ? getShowFamilyGetX.familycategories[indexFilter - 1].arname != ""
                                                                                                                      ? getShowFamilyGetX.familycategories[indexFilter - 1].arname
                                                                                                                      : getShowFamilyGetX.familycategories[indexFilter - 1].enname != ''
                                                                                                                          ? getShowFamilyGetX.familycategories[indexFilter - 1].enname
                                                                                                                          : getShowFamilyGetX.familycategories[indexFilter - 1].arname
                                                                                                                  : getShowFamilyGetX.familycategories[indexFilter - 1].enname != ""
                                                                                                                      ? getShowFamilyGetX.familycategories[indexFilter - 1].enname != ''
                                                                                                                          ? getShowFamilyGetX.familycategories[indexFilter - 1].enname
                                                                                                                          : getShowFamilyGetX.familycategories[indexFilter - 1].arname
                                                                                                                      : getShowFamilyGetX.familycategories[indexFilter - 1].arname,
                                                                                                              textColor: widget.choiceIndex == indexFilter ? Colors.white : kSpecialColor,
                                                                                                            ),
                                                                                                            elevation: 2,
                                                                                                            selectedColor: kSpecialColor.withOpacity(.8),
                                                                                                            backgroundColor: kBackgroundColor,
                                                                                                            onSelected: (bool isSelected) {
                                                                                                              setState(() {
                                                                                                                widget.choiceIndex = isSelected ? indexFilter : widget.choiceIndex;
                                                                                                                // print(indexFilter);
                                                                                                                // print(widget.choiceIndex);

                                                                                                                GetShowFamilyGetX.to.filterProductsFamilyByCategory(categoryId: getShowFamilyGetX.familycategories[indexFilter - 1].id);
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
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : Column(),
                                                                SizedBox(
                                                                  height:
                                                                      hSpaceSmall,
                                                                ),
                                                                products
                                                                        .isNotEmpty
                                                                    ? ListView
                                                                        .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        itemCount:
                                                                            products.length +
                                                                                1,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return index < products.length
                                                                              ? GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.push(
                                                                                      context,
                                                                                      MaterialPageRoute(
                                                                                          builder: (context) => ProductProfileScreen(
                                                                                                productId: products[index].id,
                                                                                                justShow: widget.justShow,
                                                                                              )),
                                                                                    );
                                                                                  },
                                                                                  child: CardWidget(
                                                                                    Column(),
                                                                                    familyProfile: true,
                                                                                    productName: Localizations.localeOf(context).languageCode == "ar"
                                                                                        ? products[index].arname
                                                                                        : products[index].enname != ''
                                                                                            ? products[index].enname
                                                                                            : products[index].arname,
                                                                                    price: "${products[index].offerStatus == 1 ? products[index].offerPrice : products[index].price} ${AppLocalizations.of(context)!.reyal}",
                                                                                    priceBefore: "${products[index].price}",
                                                                                    discount: "%${products[index].offerDiscount}",
                                                                                    time: "${products[index].durationTo}-${products[index].durationFrom} "
                                                                                        "${products[index].durationUnit == "h" ? AppLocalizations.of(context)!.hour : products[index].durationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                                                                    page: "${products[index].id}",
                                                                                    familyScreens: true,
                                                                                    discountBoolCard: products[index].offerStatus == 1 ? true : false,
                                                                                    state: 10,
                                                                                    image: products[index].images,
                                                                                  ),
                                                                                )
                                                                              : Padding(
                                                                                  padding: const EdgeInsets.only(bottom: 10, top: 5),
                                                                                  child: hasMore == true && noProducts == false
                                                                                      ? products.length > 6
                                                                                          ? Center(child: indicatorNourahLoadingSpecial())
                                                                                          : const Padding(padding: EdgeInsets.only(bottom: 0, top: 0), child: StyleText("")
                                                                                              // AppLocalizations.of(
                                                                                              //     context)!
                                                                                              //     .endContent,
                                                                                              // fontSize: 15),
                                                                                              )
                                                                                      : const Padding(padding: EdgeInsets.only(bottom: 0, top: 0), child: StyleText("")
                                                                                          // AppLocalizations.of(
                                                                                          //     context)!
                                                                                          //     .endContent,
                                                                                          // fontSize: 15),
                                                                                          ),
                                                                                );
                                                                        },
                                                                      )
                                                                    : Column(
                                                                        children: [
                                                                          noContent(
                                                                              context,
                                                                              "  ${AppLocalizations.of(context)!.thereIsnoProducts}",
                                                                              height: 130),
                                                                          SizedBox(
                                                                            height:
                                                                                hSpaceLargevv,
                                                                          )
                                                                        ],
                                                                      ),
                                                                if (widget
                                                                        .productQu !=
                                                                    0)
                                                                  SizedBox(
                                                                    height: SizeConfig
                                                                        .scaleHeight(
                                                                            60),
                                                                  )
                                                              ],
                                                            )
                                                          : noContent(context,
                                                              "  ${AppLocalizations.of(context)!.theFamilyIsNotAvailableNow}",
                                                              height: 100)
                                                    else
                                                      Column(),
                                                  ],
                                                ))
                                          ],
                                        )
                                      : noContent(
                                          context,
                                          AppLocalizations.of(context)!
                                              .noInternet);
                            }),
                      );
                    }
                  }),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: widget.productQu != 0
              ? SizedBox(
                  width: SizeConfig.scaleWidth(400),
                  child: StyleButton(
                    "${AppLocalizations.of(context)!.cart}   -   ${CartGetxController.to.getCounter()}   -   ${CartGetxController.to.getTotalPrice()} ${AppLocalizations.of(context)!.reyal}",
                    widthText: 350,
                    onPressed: () async {
                      GetShowFamilyGetXMap controller =
                          Get.put(GetShowFamilyGetXMap(
                        id: widget.userId,
                      ));
                      int min = int.parse(
                          controller.showfamily["family"]["minimum_order"]);
                      // print(min);
                      if (CartGetxController.to.getTotalPrice() >= min) {
                        // print(
                        //     "getTotalPrice  ${CartGetxController.to.getTotalPrice()}");
                        // print(
                        //     " getCounter  ${CartGetxController.to.getCounter()}");
                        // print("_countProduct  ${widget.productQu}");
                        SharedPreferencesController().isLoggedInUser
                            ? Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartScreen(
                                          userId: widget.userId,
                                        )),
                              )
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen(
                                          userId: widget.userId,
                                          productQu: widget.productQu,
                                        )));
                      } else {
                        if (context != null) {
                          helper(
                              context: context,
                              message:
                                  "${AppLocalizations.of(context)!.theminimumorder} = ${controller.showfamily["family"]["minimum_order"]} ${AppLocalizations.of(context)!.reyal}",
                              error: true);
                        }
                      }
                    },
                    width: SizeConfig.scaleWidth(400),
                    height: SizeConfig.scaleHeight(65),
                    backgroundColor: kSpecialColor,
                    sideColor: kSpecialColor,
                  ),
                )
              : Column()),
    );
  }
}
