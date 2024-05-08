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

class ProductsTab extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<ProductsTab> {
  List<Products> products = [];
  List<Products> newProducts = [];
  final controller = ScrollController();
  int page = 2;
  bool hasMore = true;
  bool noProducts = false;

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
    // int? total = HomeGetx.to.products.value.total;
    if (page > 1 && hasMore == true && noProducts == false) {
      // print("total: $total");
      var url = Uri.parse("https://nourah.store/api/v2/home?page=$page");
      var response = await http.post(url, headers: {
        'accept': 'application/json',
        'Accept-Language': "ar",
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
            jsonDecode(response.body)['data']['products']['data'] as List;
        newProducts = jsonArray
            .map((jsonObject) => Products.fromJson(jsonObject))
            .toList();
        // print("newProducts.isEmpty : ${newProducts.isEmpty}");
        if (!mounted) {
        } else {
          setState(() {
            products.addAll(newProducts);

            // if (products.length == total) {
            //   hasMore = false;
            // }
            if (newProducts.isEmpty) {
              noProducts = true;
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
          products = homeGetx.products.value.data;
          Future<void> getData() async {
            await homeGetx.refreshData();
            if (!mounted) {
            } else {
              setState(() {
                page = 2;
                hasMore = true;
                products.clear();
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
                              //     copouns
                              // ****************************************************************************************************************************************

                              if (homeGetx.coupons.value.isNotEmpty)
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              itemCount:
                                                  homeGetx.coupons.value.length,
                                              options: CarouselOptions(
                                                viewportFraction: 1,
                                                height:
                                                    SizeConfig.scaleHeight(45),
                                                scrollDirection:
                                                    Axis.horizontal,
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
                                              itemBuilder: (context, index,
                                                      realIndex) =>
                                                  homeGetx.coupons.value
                                                              .isNotEmpty &&
                                                          homeGetx.coupons.value
                                                              .isNotEmpty
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            // print(
                                                            //     "coupon  : ${homeGetx.coupons.value[index].coupon}");
                                                            Clipboard.setData(
                                                                ClipboardData(
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

                              //     specialproducts
                              // ****************************************************************************************************************************************

                              // homeGetx.specialproducts.value.data.isNotEmpty
                              //     ? homeGetx.specialproducts.value.data[0]
                              //                 .offerStatus ==
                              //             1
                              //         ? Column()
                              //         : Column(
                              //             children: [
                              //               CarouselSlider.builder(
                              //                   itemCount: homeGetx
                              //                       .specialproducts
                              //                       .value
                              //                       .data
                              //                       .length,
                              //                   options: CarouselOptions(
                              //                     viewportFraction: homeGetx
                              //                                 .specialproducts
                              //                                 .value
                              //                                 .data
                              //                                 .length !=
                              //                             1
                              //                         ? .7
                              //                         : .9,
                              //                     scrollPhysics: homeGetx
                              //                                 .specialproducts
                              //                                 .value
                              //                                 .data
                              //                                 .length !=
                              //                             1
                              //                         ? const BouncingScrollPhysics()
                              //                         : const NeverScrollableScrollPhysics(),
                              //                     height: homeGetx
                              //                                 .specialproducts
                              //                                 .value
                              //                                 .data
                              //                                 .length !=
                              //                             1
                              //                         ? SizeConfig.scaleHeight(
                              //                             280)
                              //                         : SizeConfig.scaleHeight(
                              //                             330),
                              //                     scrollDirection:
                              //                         Axis.horizontal,
                              //                     autoPlay: homeGetx
                              //                                 .specialproducts
                              //                                 .value
                              //                                 .data
                              //                                 .length !=
                              //                             1
                              //                         ? true
                              //                         : false,
                              //                     aspectRatio: 2 / 20,
                              //                     reverse: true,
                              //                     pageSnapping: false,
                              //                     enlargeCenterPage: true,
                              //                     enlargeStrategy:
                              //                         CenterPageEnlargeStrategy
                              //                             .scale,
                              //                     autoPlayCurve:
                              //                         Curves.easeInOutBack,
                              //                   ),
                              //                   itemBuilder: (context, index, realIndex) => homeGetx
                              //                               .specialproducts
                              //                               .value
                              //                               .data
                              //                               .isNotEmpty &&
                              //                           homeGetx
                              //                               .specialproducts
                              //                               .value
                              //                               .data
                              //                               .isNotEmpty
                              //                       ? GestureDetector(
                              //                           onTap: () {
                              //                             // print(
                              //                             //     "product_id${homeGetx.specialproducts.value.data[index].id}");
                              //                             Navigator.push(
                              //                               context,
                              //                               MaterialPageRoute(
                              //                                   builder:
                              //                                       (context) =>
                              //                                           ProductProfileScreen(
                              //                                             productId: homeGetx
                              //                                                 .specialproducts
                              //                                                 .value
                              //                                                 .data[index]
                              //                                                 .id,
                              //                                           )),
                              //                             );
                              //                           },
                              //                           child:
                              //                               // _homeGetx.specialproducts.value.data[index].offerStatus==1?Column():
                              //                               // controller.productsFamily[reverseIndex].offerStatus==1?
                              //                               ShowFamilyWidget(
                              //                                   Column(),
                              //                                   productName: Localizations.localeOf(context)
                              //                                               .languageCode ==
                              //                                           "ar"
                              //                                       ? homeGetx.specialproducts.value.data[index].arname !=
                              //                                               ''
                              //                                           ? homeGetx.specialproducts.value.data[index].arname
                              //                                           : homeGetx.specialproducts.value.data[index].enname
                              //                                       : homeGetx.specialproducts.value.data[index].enname,
                              //                                   familyLocation: "${homeGetx.specialproducts.value.data[index].km}",
                              //                                   price: "${homeGetx.specialproducts.value.data[index].price} ${AppLocalizations.of(context)!.reyal}",
                              //                                   priceBefore: "${homeGetx.specialproducts.value.data[index].price}",
                              //                                   discountBool: false,
                              //                                   discount: "${homeGetx.specialproducts.value.data[index].offerDiscount} %",
                              //                                   time: "${homeGetx.specialproducts.value.data[index].durationTo}-${homeGetx.specialproducts.value.data[index].durationFrom} "
                              //                                       "${homeGetx.specialproducts.value.data[index].durationUnit == "h" ? AppLocalizations.of(context)!.hour : homeGetx.specialproducts.value.data[index].durationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                              //                                   rate: " ${homeGetx.specialproducts.value.data[index].familyrate}",
                              //                                   state: homeGetx.specialproducts.value.data[index].familystatus,
                              //                                   image: homeGetx.specialproducts.value.data[index].images))
                              //                       : Column()),
                              //               dividerApp(),
                              //             ],
                              //           )
                              //     : Column(),
                              // // : Column(),

                              //     Categories
                              // ****************************************************************************************************************************************

                              SizedBox(
                                height: SizeConfig.scaleHeight(60),
                                child: Row(
                                  children: [
                                    homeGetx.categories.value.isNotEmpty
                                        ? Expanded(
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
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
                                                                if (!mounted) {
                                                                } else {
                                                                  setState(() {
                                                                    choiceIndex =
                                                                        isSelected
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
                                                                }

                                                                homeGetx.filterProductsByName(
                                                                    context:
                                                                        context,
                                                                    categoryId:
                                                                        0,
                                                                    name: Provider.of<stringNotiferSearch>(
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
                                                              width:
                                                                  wSpaceSmall,
                                                            )
                                                          ],
                                                        )
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ChoiceChip(
                                                                label:
                                                                    StyleText(
                                                                  Localizations.localeOf(context)
                                                                              .languageCode ==
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
                                                                      : kTextColor,
                                                                ),
                                                                elevation: 3,
                                                                selectedColor:
                                                                    kSpecialColor,
                                                                backgroundColor:
                                                                    kBackgroundColor,
                                                                onSelected: (bool
                                                                    isSelected) async {
                                                                  if (!mounted) {
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      choiceIndex = isSelected
                                                                          ? indexFilter
                                                                          : choiceIndex;

                                                                      Provider.of<intCategoryId>(context, listen: false).changeCategoryId(homeGetx
                                                                          .categories[indexFilter -
                                                                              1]
                                                                          .id);

                                                                      // print(
                                                                      //     "indexFilter :  $indexFilter ");
                                                                      // print(
                                                                      //     "id ${homeGetx.categories[indexFilter - 1].id}");
                                                                    });
                                                                  }
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
                                                                          name:
                                                                              Provider.of<stringNotiferSearch>(context, listen: false).search);

                                                                  // print(
                                                                  //     "products.length : ${products.length}");
                                                                  // print(
                                                                  //     "choiceIndex $choiceIndex");
                                                                },
                                                                selected:
                                                                    choiceIndex ==
                                                                        indexFilter),
                                                            SizedBox(
                                                              width:
                                                                  wSpaceSmall,
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

                              //     products
                              // ****************************************************************************************************************************************
                              products.isNotEmpty
                                  ? ListView.builder(
                                      // controller: controller,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: products.length + 1,
                                      itemBuilder: (context, index) {
                                        // productsNourah
                                        return index < products.length
                                            ? GestureDetector(
                                                onTap: () {
                                                  // print(
                                                  //     "product_id${products[index].id}");
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductProfileScreen(
                                                              productId:
                                                                  products[
                                                                          index]
                                                                      .id,
                                                            )),
                                                  );
                                                },
                                                child: products[index]
                                                            .offerStatus ==
                                                        1
                                                    ? Column()
                                                    :


                                                CardWidget(
                                                        Column(),
                                                        productName: Localizations
                                                                        .localeOf(
                                                                            context)
                                                                    .languageCode ==
                                                                "ar"
                                                            ? products[index]
                                                                .arname
                                                            : products[index]
                                                                        .enname !=
                                                                    ''
                                                                ? products[
                                                                        index]
                                                                    .enname
                                                                : products[
                                                                        index]
                                                                    .arname,
                                                        familyLocation:
                                                            "${products[index].km}",
                                                        price:
                                                            "${products[index].price} ${AppLocalizations.of(context)!.reyal}",
                                                        priceBefore:
                                                            "${products[index].price}",
                                                        discountBoolCard: false,
                                                        discount:
                                                            "${products[index].offerDiscount} %",
                                                        time:
                                                            "${products[index].durationTo}-${products[index].durationFrom} "
                                                            "${products[index].durationUnit == "h" ? AppLocalizations.of(context)!.hour : products[index].durationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                                        rate:
                                                            " ${products[index].familyrate}",
                                                        state: products[index]
                                                            .familystatus,
                                                        image: products[index]
                                                            .images,
                                                      ),
                                              )
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10, top: 5),
                                                child: hasMore == true &&
                                                        noProducts == false
                                                    ? products.length > 6
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
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 0,
                                                                top: 0),
                                                        child: StyleText("")
                                                        // AppLocalizations.of(
                                                        //     context)!
                                                        //     .endContent,
                                                        // fontSize: 15),
                                                        ),
                                              );
                                      },
                                    )
                                  : noContent(
                                      context,
                                      AppLocalizations.of(context)!
                                          .thereIsnoProductsInThislocation,
                                      height: 140)
                            ],
                          )),
              ));
        });
  }
}
