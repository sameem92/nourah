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
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/show/family_profile_screen.dart';
import 'package:producer_family_app/storage/models/home_modal/home_modal.dart';
import 'package:producer_family_app/storage/providersAndGetx/home_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:provider/provider.dart';

class FamilyTab extends StatefulWidget {
  @override
  _FamilyTabState createState() => _FamilyTabState();
}

class _FamilyTabState extends State<FamilyTab> {
  List<Families> families = [];
  List<Families> newFamilies = [];
  final controller = ScrollController();
  int page = 2;
  bool hasMore = true;
  bool noFamilies = false;

  @override
  void initState() {
    // TODO: implement initState
    fetch();

    super.initState();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
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
    // print('fetch');
    // print(controller.position.minScrollExtent);
    // page > 1 && products.length < total!
    // int? total = HomeGetx.to.families.value.total;
    // && hasMore == true && noFamilies == false
    if (page > 1) {
      // print('ok');
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
            jsonDecode(response.body)['data']['families']['data'] as List;
        newFamilies = jsonArray
            .map((jsonObject) => Families.fromJson(jsonObject))
            .toList();
        // print("newFamilies.isEmpty : ${newFamilies.isEmpty}");

        if (!mounted) {
        } else {
          setState(() {
            families.addAll(newFamilies);

            // if (families.length == total) {
            //   hasMore = false;
            // }
            if (newFamilies.isEmpty) {
              noFamilies = true;
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
          families = homeGetx.families.value.data;
          Future<void> getData() async {
            await homeGetx.refreshData();
            if (!mounted) {
            } else {
              setState(() {
                page = 2;
                hasMore = true;
                families.clear();
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
                child: homeGetx.isLoading.value
                    ? Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.scaleHeight(360),
                          ),
                          Center(child: indicatorNourahLoadingSpecial()),
                        ],
                      )
                    : SingleChildScrollView(
                        controller: controller,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              children: [
                                homeGetx.coupons.value.isNotEmpty
                                    ? Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Expanded(child: SizedBox()),
                                              Expanded(
                                                  flex: 15,
                                                  child: StyleText(
                                                    AppLocalizations.of(
                                                            context)!
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
                                                      height: SizeConfig
                                                          .scaleHeight(50),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      autoPlay: homeGetx
                                                                  .coupons
                                                                  .value
                                                                  .length !=
                                                              1
                                                          ? true
                                                          : false,
                                                      scrollPhysics: homeGetx
                                                                  .coupons
                                                                  .value
                                                                  .length !=
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
                                                      autoPlayCurve:
                                                          Curves.linear,
                                                    ),
                                                    itemBuilder: (context,
                                                            index, realIndex) =>
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
                                                                      error:
                                                                          true);
                                                                },
                                                                child:
                                                                    ContainerApp(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      StyleText(homeGetx
                                                                              .coupons
                                                                              .value[index]
                                                                              .coupon ??
                                                                          ""),
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
                                    : Column(),
                                // homeGetx.specialfamilies.value.data.isNotEmpty
                                //     ? Column(
                                //         children: [
                                //           CarouselSlider.builder(
                                //               itemCount: homeGetx
                                //                   .specialfamilies
                                //                   .value
                                //                   .data
                                //                   .length,
                                //               options: CarouselOptions(
                                //                 viewportFraction: homeGetx
                                //                             .specialfamilies
                                //                             .value
                                //                             .data
                                //                             .length !=
                                //                         1
                                //                     ? .7
                                //                     : .9,
                                //                 scrollPhysics: homeGetx
                                //                             .specialfamilies
                                //                             .value
                                //                             .data
                                //                             .length !=
                                //                         1
                                //                     ? const BouncingScrollPhysics()
                                //                     : const NeverScrollableScrollPhysics(),
                                //                 height: homeGetx
                                //                             .specialfamilies
                                //                             .value
                                //                             .data
                                //                             .length !=
                                //                         1
                                //                     ? SizeConfig.scaleHeight(
                                //                         280)
                                //                     : SizeConfig.scaleHeight(
                                //                         330),
                                //                 scrollDirection:
                                //                     Axis.horizontal,
                                //                 autoPlay: homeGetx
                                //                             .specialfamilies
                                //                             .value
                                //                             .data
                                //                             .length !=
                                //                         1
                                //                     ? true
                                //                     : false,
                                //                 aspectRatio: 2 / 20,
                                //                 reverse: true,
                                //                 pageSnapping: false,
                                //                 enlargeCenterPage: true,
                                //                 enlargeStrategy:
                                //                     CenterPageEnlargeStrategy
                                //                         .scale,
                                //                 autoPlayCurve:
                                //                     Curves.easeInOutBack,
                                //               ),
                                //               itemBuilder: (context, index,
                                //                       realIndex) =>
                                //                   homeGetx
                                //                               .specialfamilies
                                //                               .value
                                //                               .data
                                //                               .isNotEmpty &&
                                //                           homeGetx
                                //                               .specialfamilies
                                //                               .value
                                //                               .data
                                //                               .isNotEmpty
                                //                       ? GestureDetector(
                                //                           onTap: () {
                                //                             // print(
                                //                             //     "user_id${homeGetx.specialfamilies.value.data[index].id}");
                                //                             Navigator.push(
                                //                               context,
                                //                               MaterialPageRoute(
                                //                                 builder:
                                //                                     (context) =>
                                //                                         FamilyProfileScreen(
                                //                                   userId: homeGetx
                                //                                       .specialfamilies
                                //                                       .value
                                //                                       .data[
                                //                                           index]
                                //                                       .id,
                                //                                   justShow:
                                //                                       false,
                                //                                 ),
                                //                               ),
                                //                             );
                                //                           },
                                //                           child:
                                //                               ShowFamilyWidget(
                                //                                   SingleChildScrollView(
                                //                                     child:
                                //                                         Center(
                                //                                       child:
                                //                                           Column(
                                //                                         mainAxisSize:
                                //                                             MainAxisSize.min,
                                //                                         children: [
                                //                                           SizedBox(
                                //                                             width:
                                //                                                 SizeConfig.scaleWidth(300),
                                //                                             height:
                                //                                                 SizeConfig.scaleHeight(23),
                                //                                             child:
                                //                                                 Center(
                                //                                               child: ListView.builder(
                                //                                                   reverse: true,
                                //                                                   shrinkWrap: true,
                                //                                                   scrollDirection: Axis.horizontal,
                                //                                                   itemCount: homeGetx.specialfamilies.value.data[index].categories.length,
                                //                                                   itemBuilder: (context, indexx) {
                                //                                                     return Container(
                                //                                                       padding: EdgeInsets.zero,
                                //                                                       width: SizeConfig.scaleWidth(104),
                                //                                                       alignment: Alignment.center,
                                //                                                       child: StyleText(
                                //                                                         Localizations.localeOf(context).languageCode == "ar" ? homeGetx.specialfamilies.value.data[index].categories[indexx].arname : homeGetx.specialfamilies.value.data[index].categories[indexx].enname,
                                //                                                         textColor: kTextColor,
                                //                                                         maxLines: 6,
                                //                                                         textAlign: TextAlign.center,
                                //                                                         fontWeight: FontWeight.w400,
                                //                                                       ),
                                //                                                     );
                                //                                                   }),
                                //                                             ),
                                //                                           ),
                                //                                         ],
                                //                                       ),
                                //                                     ),
                                //                                   ),
                                //                                   family: true,
                                //                                   familyName: homeGetx
                                //                                       .specialfamilies
                                //                                       .value
                                //                                       .data[
                                //                                           index]
                                //                                       .name,
                                //                                   familyLocation:
                                //                                       "${homeGetx.specialfamilies.value.data[index].mile}",
                                //                                   rate:
                                //                                       " ${homeGetx.specialfamilies.value.data[index].rate}",
                                //                                   state: homeGetx
                                //                                       .specialfamilies
                                //                                       .value
                                //                                       .data[
                                //                                           index]
                                //                                       .available,
                                //                                   image: homeGetx
                                //                                       .specialfamilies
                                //                                       .value
                                //                                       .data[
                                //                                           index]
                                //                                       .image),
                                //                         )
                                //                       : Column()),
                                //           dividerApp(),
                                //         ],
                                //       )
                                //     : Column(),
                              ],
                            ),
                            Column(
                              children: [
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
                                                  itemCount: homeGetx
                                                          .categories.length +
                                                      1,
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
                                                                    setState(
                                                                        () {
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
                                                                  }

                                                                  homeGetx.filterProductsByName(
                                                                      context:
                                                                          context,
                                                                      categoryId:
                                                                          0,
                                                                      name: Provider.of<stringNotiferSearch>(
                                                                              context,
                                                                              listen: false)
                                                                          .search);

                                                                  // name: _homeGetx.categories[indexFilter].arname);
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
                                                                        //     "indexFilter :  $indexFilter");
                                                                      });
                                                                      Provider.of<stringNotiferSearch>(context, listen: false).search !=
                                                                              ""
                                                                          ? homeGetx.filterProductsByName(
                                                                              context: context,
                                                                              categoryId: homeGetx.categories[indexFilter - 1].id,
                                                                              name: Provider.of<stringNotiferSearch>(context, listen: false).search)
                                                                          : homeGetx.filterProductsByCategory(categoryId: homeGetx.categories[indexFilter - 1].id, name: Provider.of<stringNotiferSearch>(context, listen: false).search);
                                                                    }
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
                                families.isNotEmpty && families.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: families.length + 1,
                                        itemBuilder: (context, index) {
                                          return index < families.length
                                              ? GestureDetector(
                                                  onTap: () {
                                                    Get.put(GetShowFamilyGetX(
                                                        id: families[index]
                                                            .id));
                                                    // print(
                                                    //     "user_id${families[index].id}");
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            FamilyProfileScreen(
                                                          userId:
                                                              families[index]
                                                                  .id,
                                                          justShow: false,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: CardWidget(
                                                      SingleChildScrollView(
                                                        child: Center(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                width: SizeConfig
                                                                    .scaleWidth(
                                                                        300),
                                                                height: SizeConfig
                                                                    .scaleHeight(
                                                                        23),
                                                                child: Center(
                                                                  child: ListView
                                                                      .builder(
                                                                          reverse:
                                                                              true,
                                                                          shrinkWrap:
                                                                              true,
                                                                          scrollDirection: Axis
                                                                              .horizontal,
                                                                          itemCount: families[index]
                                                                              .categories
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, indexx) {
                                                                            return Container(
                                                                              width: SizeConfig.scaleWidth(105),
                                                                              alignment: Alignment.center,
                                                                              child: StyleText(
                                                                                Localizations.localeOf(context).languageCode == "ar" ? families[index].categories[indexx].arname : families[index].categories[indexx].enname,
                                                                                textColor: kTextColor,
                                                                                maxLines: 5,
                                                                                textAlign: TextAlign.center,
                                                                                fontWeight: FontWeight.w400,
                                                                              ),
                                                                            );
                                                                          }),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      family: true,
                                                      familyName:
                                                          families[index].name,
                                                      familyLocation:
                                                          "${families[index].mile}",
                                                      rate:
                                                          " ${families[index].rate}",
                                                      state: families[index]
                                                          .available,
                                                      image: families[index]
                                                          .image))
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10, top: 5),
                                                  child: hasMore == true &&
                                                          noFamilies == false
                                                      ? families.length > 6
                                                          ? Center(
                                                              child:
                                                                  indicatorNourahLoadingSpecial())
                                                          : const Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom: 0,
                                                                      top: 0),
                                                              child:
                                                                  StyleText("")
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
                                            .thereIsnoFamiliesInThislocation,
                                        height: 140)
                              ],
                            ),
                          ],
                        ),
                      ),
              ));
        });
  }
}
