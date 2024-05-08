import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:producer_family_app/components/containers/card_widget.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/containers/show_widget.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/show/product_profile_screen.dart';
import 'package:producer_family_app/storage/providersAndGetx/home_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:provider/provider.dart';

import '../../../../storage/models/home_modal/home_modal.dart';

class SalesTab extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<SalesTab> {
  List<Offers> sales = [];
  List<Offers> newSales = [];
  final controller = ScrollController();
  int page = 2;
  bool hasMore = true;
  bool noSales = false;

  @override
  void initState() {
    super.initState();
    fetch();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        // print('ready');
        fetch();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    ScrollController().dispose();

    super.dispose();
  }

  Future fetch() async {
    // page > 1 && products.length < total!
    // int? total = HomeGetx.to.offers.value.total;
    if (page > 1 && hasMore == true && noSales == false) {
      // print("total: $total");
      var url = Uri.parse("https://nourah.store/api/v2/home?page=$page");
      var response = await http.post(url, headers: {
        'accept': 'application/json',
        'Accept-Language': 'ar',
        'Accept-country': '1'
      }, body: {
        "keyword": '',
        "category":
            Provider.of<intCategoryId>(context, listen: false).categoryId != 0
                ? Provider.of<intCategoryId>(context, listen: false)
                    .categoryId
                    .toString()
                : 0.toString(),
        "lat": "${Provider.of<LatNotiferUser>(context, listen: false).latUser}",
        'lng':
            "${Provider.of<LongNotiferUser>(context, listen: false).longUser}",
      });
      if (response.statusCode < 400) {
        if (!mounted) {
        } else {
          setState(() {
            page++;
          });
        }
        var jsonArray =
            jsonDecode(response.body)['data']['offers']['data'] as List;
        newSales =
            jsonArray.map((jsonObject) => Offers.fromJson(jsonObject)).toList();
        // print("newProducts.isEmpty : ${newSales.isEmpty}");
        if (!mounted) {
        } else {
          setState(() {
            sales.addAll(newSales);

            // if (sales.length == total) {
            //   hasMore = false;
            // }
            if (newSales.isEmpty) {
              noSales = true;
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int choiceIndex =
        Provider.of<intCategoryId>(context, listen: false).categoryId != 0
            ? Provider.of<intCategoryId>(context, listen: false).categoryId
            : 0;

    return GetX<HomeGetx>(
        init: HomeGetx(
          context: context,
        ),
        builder: (HomeGetx homeGetx) {
          sales = homeGetx.offers.value.data;
          Future<void> getData() async {
            await homeGetx.refreshData();
            if (!mounted) {
            } else {
              setState(() {
                page = 2;
                hasMore = true;
                sales.clear();
              });
            }
          }

          return RefreshIndicator(
              onRefresh: getData,
              child: Padding(
                padding: EdgeInsets.only(
                  left: wPadding,
                  right: wPadding,
                  bottom: hSpace,
                ),
                child: SingleChildScrollView(
                  controller: controller,
                  child: homeGetx.isLoading.value
                      ? Column(
                          children: [
                            SizedBox(
                              height: SizeConfig.scaleHeight(360),
                            ),
                            Center(child: indicatorNourahLoadingSpecial()),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //     specialoffers
                            // ****************************************************************************************************************************************
                            if (homeGetx.coupons.value.isNotEmpty)
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Expanded(child: SizedBox()),
                                      Expanded(
                                          flex: 15,
                                          child: StyleText(
                                            AppLocalizations.of(context)!
                                                .copyCoupon,
                                            textColor: kSpecialColor,
                                          )),
                                      Expanded(
                                        flex: 10,
                                        child: CarouselSlider.builder(
                                            itemCount: homeGetx
                                                .coupons.value.length,
                                            options: CarouselOptions(
                                              viewportFraction: 1,
                                              height:
                                                  SizeConfig.scaleHeight(50),
                                              scrollDirection: Axis.horizontal,
                                              autoPlay: homeGetx.coupons.value
                                                          .length !=
                                                      1
                                                  ? true
                                                  : false,
                                              scrollPhysics: homeGetx.coupons
                                                          .value.length !=
                                                      1
                                                  ? const BouncingScrollPhysics()
                                                  : const NeverScrollableScrollPhysics(),
                                              aspectRatio: 2 / 20,
                                              reverse: false,
                                              pageSnapping: false,
                                              enlargeCenterPage: true,
                                              enlargeStrategy:
                                                  CenterPageEnlargeStrategy
                                                      .scale,
                                              autoPlayCurve: Curves.linear,
                                            ),
                                            itemBuilder:
                                                (context, index, realIndex) =>
                                                    homeGetx.coupons.value
                                                                .isNotEmpty &&
                                                            homeGetx
                                                                .coupons
                                                                .value
                                                                .isNotEmpty
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              // print(
                                                              //     "coupon  : ${homeGetx.coupons.value[index].coupon}");
                                                              Clipboard.setData(ClipboardData(
                                                                  text: homeGetx
                                                                      .coupons
                                                                      .value[
                                                                          index]
                                                                      .coupon));
                                                              helper(
                                                                  context:
                                                                      context,
                                                                  message: AppLocalizations.of(
                                                                          context)!
                                                                      .couponcopied,
                                                                  error: true);
                                                            },
                                                            child: ContainerApp(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  StyleText(homeGetx
                                                                          .coupons
                                                                          .value[
                                                                              index]
                                                                          .coupon ??
                                                                      ''),
                                                                ],
                                                              ),
                                                            ))
                                                        : Column()),
                                      ),
                                      const Expanded(child: SizedBox())
                                    ],
                                  ),
                                  dividerApp(),
                                ],
                              )
                            else
                              Column(),

                            homeGetx.specialoffers.value.data.isNotEmpty
                                ? homeGetx.specialoffers.value.data[0]
                                            .offerstatus ==
                                        1
                                    ? Column(
                                        children: [
                                          CarouselSlider.builder(
                                              itemCount: homeGetx.specialoffers
                                                  .value.data.length,
                                              options: CarouselOptions(
                                                viewportFraction: homeGetx
                                                            .specialoffers
                                                            .value
                                                            .data
                                                            .length !=
                                                        1
                                                    ? .7
                                                    : .9,
                                                scrollPhysics: homeGetx
                                                            .specialoffers
                                                            .value
                                                            .data
                                                            .length !=
                                                        1
                                                    ? const BouncingScrollPhysics()
                                                    : const NeverScrollableScrollPhysics(),
                                                height: homeGetx
                                                            .specialoffers
                                                            .value
                                                            .data
                                                            .length !=
                                                        1
                                                    ? SizeConfig.scaleHeight(
                                                        280)
                                                    : SizeConfig.scaleHeight(
                                                        330),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                autoPlay: homeGetx
                                                            .specialoffers
                                                            .value
                                                            .data
                                                            .length !=
                                                        1
                                                    ? true
                                                    : false,
                                                aspectRatio: 2 / 20,
                                                reverse: true,
                                                pageSnapping: false,
                                                enlargeCenterPage: true,
                                                enlargeStrategy:
                                                    CenterPageEnlargeStrategy
                                                        .scale,
                                                autoPlayCurve:
                                                    Curves.easeInOutBack,
                                              ),
                                              itemBuilder:
                                                  (context, index, realIndex) =>
                                                      homeGetx
                                                                  .specialoffers
                                                                  .value
                                                                  .data
                                                                  .isNotEmpty &&
                                                              homeGetx
                                                                  .specialoffers
                                                                  .value
                                                                  .data
                                                                  .isNotEmpty
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                // print(
                                                                //     "product_id${homeGetx.specialoffers.value.data[index].id}");
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              ProductProfileScreen(
                                                                                productId: homeGetx.specialoffers.value.data[index].id,
                                                                              )),
                                                                );
                                                              },
                                                              child: homeGetx.specialoffers.value.data[index].offerstatus ==
                                                                      1
                                                                  ? ShowFamilyWidget(
                                                                      Column(),
                                                                      productName: Localizations.localeOf(context).languageCode ==
                                                                              "ar"
                                                                          ? homeGetx
                                                                              .specialoffers
                                                                              .value
                                                                              .data[
                                                                                  index]
                                                                              .arname
                                                                          : homeGetx.specialoffers.value.data[index].enname !=
                                                                                  ''
                                                                              ? homeGetx
                                                                                  .specialoffers
                                                                                  .value
                                                                                  .data[
                                                                                      index]
                                                                                  .enname
                                                                              : homeGetx
                                                                                  .specialoffers
                                                                                  .value
                                                                                  .data[
                                                                                      index]
                                                                                  .arname,
                                                                      familyLocation:
                                                                          "${homeGetx.specialoffers.value.data[index].km}",
                                                                      price:
                                                                          "${homeGetx.specialoffers.value.data[index].offerPrice != 0 ? homeGetx.specialoffers.value.data[index].offerPrice : homeGetx.specialoffers.value.data[index].price} ${AppLocalizations.of(context)!.reyal}",
                                                                      priceBefore:
                                                                          "${homeGetx.specialoffers.value.data[index].price}",
                                                                      discountBool: homeGetx.specialoffers.value.data[index].offerPrice != 0
                                                                          ? true
                                                                          : false,
                                                                      discount:
                                                                          "${homeGetx.specialoffers.value.data[index].offerDiscount} %",
                                                                      time:
                                                                          "${homeGetx.specialoffers.value.data[index].durationTo}-${homeGetx.specialoffers.value.data[index].durationFrom} "
                                                                          "${homeGetx.specialoffers.value.data[index].durationUnit == "h" ? AppLocalizations.of(context)!.hour : homeGetx.specialoffers.value.data[index].durationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                                                      rate:
                                                                          " ${homeGetx.specialoffers.value.data[index].familyrate}",
                                                                      timer:
                                                                          "${homeGetx.specialoffers.value.data[index].offertime['days'] * 24 + homeGetx.specialoffers.value.data[index].offertime['hours']}:${homeGetx.specialoffers.value.data[index].offertime['minutes']}:${homeGetx.specialoffers.value.data[index].offertime['seconds']}",
                                                                      state: 10,
                                                                      image: homeGetx
                                                                          .specialoffers
                                                                          .value
                                                                          .data[
                                                                              index]
                                                                          .images)
                                                                  : Column(),
                                                            )
                                                          : Column()),
                                          dividerApp(),
                                        ],
                                      )
                                    : Column()
                                : Column(),

                            //     Categories
                            // ****************************************************************************************************************************************

                            SizedBox(
                              height: SizeConfig.scaleHeight(60),
                              child: Row(
                                children: [
                                  homeGetx.categories.value.isNotEmpty
                                      ? Expanded(
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount:
                                                  homeGetx.categories.length +
                                                      1,
                                              // +1,
                                              itemBuilder:
                                                  (context, indexFilter) {
                                                return indexFilter == 0
                                                    ? Row(
                                                        children: [
                                                          ChoiceChip(
                                                            label: StyleText(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .all,
                                                                textColor: choiceIndex ==
                                                                        indexFilter
                                                                    ? Colors
                                                                        .white
                                                                    : kTextColor),
                                                            elevation: 3,
                                                            selectedColor:
                                                                kSpecialColor,
                                                            backgroundColor:
                                                                kBackgroundColor,
                                                            onSelected: (bool
                                                                isSelected) {
                                                              setState(() {
                                                                choiceIndex = isSelected
                                                                    ? indexFilter
                                                                    : choiceIndex;
                                                                Provider.of<intCategoryId>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .changeCategoryId(
                                                                        0);
                                                                // print(
                                                                //     "indexFilter :  $indexFilter ");
                                                              });

                                                              homeGetx.filterProductsByName(
                                                                  context:
                                                                      context,
                                                                  categoryId: 0,
                                                                  name: Provider.of<
                                                                              stringNotiferSearch>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .search);
                                                            },
                                                            selected:
                                                                choiceIndex ==
                                                                    indexFilter,
                                                          ),
                                                          SizedBox(
                                                            width: wSpaceSmall,
                                                          )
                                                        ],
                                                      )
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          ChoiceChip(
                                                              label: StyleText(
                                                                  Localizations.localeOf(context).languageCode ==
                                                                          "ar"
                                                                      ? homeGetx
                                                                          .categories[indexFilter -
                                                                              1]
                                                                          .arname
                                                                      : homeGetx
                                                                          .categories[indexFilter -
                                                                              1]
                                                                          .enname,
                                                                  textColor: choiceIndex ==
                                                                          indexFilter
                                                                      ? Colors
                                                                          .white
                                                                      : kTextColor),
                                                              elevation: 3,
                                                              selectedColor:
                                                                  kSpecialColor,
                                                              backgroundColor:
                                                                  kBackgroundColor,
                                                              onSelected: (bool
                                                                  isSelected) {
                                                                setState(() {
                                                                  choiceIndex =
                                                                      isSelected
                                                                          ? indexFilter
                                                                          : choiceIndex;

                                                                  //save category id
                                                                  Provider.of<intCategoryId>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .changeCategoryId(homeGetx
                                                                          .categories[indexFilter -
                                                                              1]
                                                                          .id);

                                                                  // print(
                                                                  //     "indexFilter :  $indexFilter ");
                                                                });

                                                                Provider.of<stringNotiferSearch>(context, listen: false)
                                                                            .search !=
                                                                        ""
                                                                    ? homeGetx.filterProductsByName(
                                                                        context:
                                                                            context,
                                                                        categoryId: homeGetx
                                                                            .categories[indexFilter -
                                                                                1]
                                                                            .id,
                                                                        name: Provider.of<stringNotiferSearch>(context, listen: false)
                                                                            .search)
                                                                    : homeGetx.filterProductsByCategory(
                                                                        categoryId: homeGetx
                                                                            .categories[indexFilter -
                                                                                1]
                                                                            .id,
                                                                        name: Provider.of<stringNotiferSearch>(context, listen: false)
                                                                            .search);
                                                              },
                                                              selected:
                                                                  choiceIndex ==
                                                                      indexFilter),
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
                            SizedBox(
                              height: hSpaceSmall,
                            ),

                            //     search
                            // ****************************************************************************************************************************************

                            if (Provider.of<stringNotiferSearch>(context)
                                    .search !=
                                "")
                              Column(
                                children: [
                                  SizedBox(
                                    height: hSpace,
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          StyleText(
                                            "${AppLocalizations.of(context)!.theResultsFromSearchAre} : ",
                                            textAlign: TextAlign.right,
                                          ),
                                          StyleText(
                                            Provider.of<stringNotiferSearch>(
                                                    context)
                                                .search,
                                            textAlign: TextAlign.right,
                                            textColor: kSpecialColor,
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: hSpace,
                                  )
                                ],
                              ),

                            //     offers
                            // ****************************************************************************************************************************************

                            sales.isNotEmpty || sales.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: sales.length + 1,
                                    itemBuilder: (context, index) {
                                      return index < sales.length
                                          ? GestureDetector(
                                              onTap: () {
                                                // print(
                                                //     "product_id${sales[index].id}");
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductProfileScreen(
                                                            productId:
                                                                sales[index].id,
                                                          )),
                                                );
                                              },
                                              child: sales[index].offerstatus ==
                                                      1
                                                  ? CardWidget(
                                                      Column(),
                                                      productName: Localizations
                                                                      .localeOf(
                                                                          context)
                                                                  .languageCode ==
                                                              "ar"
                                                          ? sales[index].arname
                                                          : sales[index]
                                                                      .enname !=
                                                                  ''
                                                              ? sales[index]
                                                                  .enname
                                                              : sales[index]
                                                                  .arname,
                                                      familyLocation:
                                                          "${sales[index].km}",
                                                      price:
                                                          "${sales[index].offerPrice != 0 ? sales[index].offerPrice : sales[index].price} ${AppLocalizations.of(context)!.reyal}",
                                                      priceBefore:
                                                          "${sales[index].price}",
                                                      discountBoolCard: sales[
                                                                      index]
                                                                  .offerPrice !=
                                                              0
                                                          ? true
                                                          : false,
                                                      discount:
                                                          "${sales[index].offerDiscount} %",
                                                      time:
                                                          "${sales[index].durationTo}-${sales[index].durationFrom} "
                                                          "${sales[index].durationUnit == "h" ? AppLocalizations.of(context)!.hour : sales[index].durationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                                      rate:
                                                          " ${sales[index].familyrate}",
                                                      timer:
                                                          "${sales[index].offertime['days'] * 24 + sales[index].offertime['hours']}:${sales[index].offertime['minutes']}:${sales[index].offertime['seconds']}",
                                                      state: 10,
                                                      image:
                                                          sales[index].images,
                                                    )
                                                  : Column(),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10, top: 5),
                                              child: hasMore == true &&
                                                      noSales == false
                                                  ? sales.length > 6
                                                      ? Center(
                                                          child:
                                                              indicatorNourahLoadingSpecial())
                                                      : const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 0,
                                                                  top: 0),
                                                          child: StyleText("")
                                                          // AppLocalizations.of(
                                                          //     context)!
                                                          //     .endContent,
                                                          // fontSize: 15),
                                                          )
                                                  : const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 0, top: 0),
                                                      child: StyleText("")
                                                      // AppLocalizations.of(
                                                      //     context)!
                                                      //     .endContent,
                                                      // fontSize: 15),
                                                      ),
                                            );
                                    },
                                  )
                                : noContent(context,
                                    AppLocalizations.of(context)!.thereIsNoSale,
                                    height: 140)
                          ],
                        ),
                ),
              ));
        });
  }
}
