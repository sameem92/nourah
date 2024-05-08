import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:producer_family_app/storage/api/home_controller.dart';
import 'package:producer_family_app/storage/models/home_modal/categories_modal.dart';
import 'package:producer_family_app/storage/models/home_modal/home_modal.dart';
import 'package:producer_family_app/storage/models/show_modal/show_family.dart';
import 'package:producer_family_app/storage/models/show_modal/show_product_modal.dart';

class HomeGetx extends GetxController {
  RxList<Categories> categories = <Categories>[].obs;
  RxList<Coupons> coupons = <Coupons>[].obs;

  Rx<Data<Products>> specialproducts = Data<Products>().obs;
  Rx<Data<Products>> products = Data<Products>().obs;
  Rx<Data<Families>> specialfamilies = Data<Families>().obs;
  Rx<Data<Families>> families = Data<Families>().obs;
  Rx<Data<Offers>> specialoffers = Data<Offers>().obs;
  Rx<Data<Offers>> offers = Data<Offers>().obs;

  //for categories and search
  List<Categories> categoriesList = <Categories>[];
  List<Coupons> couponsList = <Coupons>[];

  List<Products> productsList = <Products>[];
  // List<Products> productsListNew = <Products>[];
  List<Families> familiesList = <Families>[];
  List<Offers> offersList = <Offers>[];

  static HomeGetx get to => Get.find();
  var isLoading = true.obs;
  String language;
  String lat;
  String lng;
  int category;
  int page;
  BuildContext context;
  HomeGetx(
      {this.language = '',
      this.lat = '',
      this.lng = '',
      this.category = 0,
      this.page = 1,
      required this.context});

  @override
  void onInit() {
    getHomeData();
    super.onInit();
  }

  Future<void> getHomeData({
    bool? isUpdated,
  }) async {
    isLoading(true);
    try {
      var response = await HomeController().getHome(
          context: context,
          keyword: '',
          category: category.toString(),
          language: language,
          isUpdated: isUpdated,
          lat: lat,
          lng: lng,
          page: page);

      if (response != null) {
        specialproducts.value = response.specialproducts;
        products.value = response.products;

        specialfamilies.value = response.specialfamilies;
        families.value = response.families;

        specialoffers.value = response.specialoffers;
        offers.value = response.offers;

        categories.value = response.categories;
        coupons.value = response.coupons;
      }
      productsList = products.value.data;
      familiesList = families.value.data;
      offersList = offers.value.data;
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshOffer({
    bool? isUpdated,
  }) async {
    isLoading(true);
    try {
      var response = await HomeController().getHome(
          context: context,
          keyword: '',
          category: category.toString(),
          language: language,
          isUpdated: isUpdated,
          lat: lat,
          lng: lng);
      if (response != null) {
        offers.value = response.offers;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshData() async {
    await getHomeData(isUpdated: true);
  }

  void filterProductsByName(
      {String name = '', required BuildContext context, int categoryId = 0}) {
    if (name.isNotEmpty) {
      // products / products / products / products / products / products / products / products /
      Localizations.localeOf(context).languageCode == "ar"
          //ar

          ? products.value.data = categoryId != 0
              ? productsList
                  .where((element) => element.arname.contains(name))
                  .toList()
                  .where((element) => element.brand == categoryId)
                  .toList()
              : productsList
                  .where((element) => element.arname.contains(name))
                  .toList()
          //en
          : products.value.data = categoryId != 0
              ? productsList
                  .where((element) => element.enname.contains(name))
                  .toList()
                  .where((element) => element.brand == categoryId)
                  .toList()
              : productsList
                  .where((element) => element.enname.contains(name))
                  .toList();

      // offers / offers / offers / offers / offers / offers / offers / offers / offers / offers /
      Localizations.localeOf(context).languageCode == "ar"
          //ar
          ? offers.value.data = categoryId != 0
              ? offersList
                  .where((element) => element.arname.contains(name))
                  .toList()
                  .where((element) => element.brand == categoryId)
                  .toList()
              : offersList
                  .where((element) => element.arname.contains(name))
                  .toList()

          //en
          : offers.value.data = categoryId != 0
              ? offersList
                  .where((element) => element.enname.contains(name))
                  .toList()
                  .where((element) => element.brand == categoryId)
                  .toList()
              : offersList
                  .where((element) => element.enname.contains(name))
                  .toList();

// families /families /families /families /families /families /families /families /families /families /families /families /families /
      families.value.data = categoryId != 0
          ? familiesList
              .where((element) => element.name.contains(name))
              .toList()
              .where((element) => element.categories[0].id == categoryId)
              .toList()
              .toList()
          : familiesList
              .where((element) => element.name.contains(name))
              .toList();
    } else {
      products.value.data = productsList;
      offers.value.data = offersList;
      families.value.data = familiesList;
    }
    specialproducts.refresh();
    specialfamilies.refresh();
    specialoffers.refresh();
  }

  void filterProductsByCategory({required int categoryId, String name = ''}) {
    if (categoryId != 0) {
      // products / products / products / products / products / products / products / products /
      products.value.data = name.isNotEmpty
          ? productsList
              .where((element) => element.brand == categoryId)
              .toList()
              .where((element) =>
                  Localizations.localeOf(context).languageCode == "ar"
                      ? element.arname.contains(name)
                      : element.enname.contains(name))
              .toList()
          : productsList
              .where((element) => element.brand == categoryId)
              .toList();
      // offers / offers / offers / offers / offers / offers / offers / offers / offers / offers /
      offers.value.data = name.isNotEmpty
          ? offersList
              .where((element) => element.brand == categoryId)
              .toList()
              .where((element) =>
                  Localizations.localeOf(context).languageCode == "ar"
                      ? element.arname.contains(name)
                      : element.enname.contains(name))
              .toList()
          : offersList.where((element) => element.brand == categoryId).toList();
      // families / families / families / families / families / families / families / families /

      families.value.data = name.isNotEmpty
          ? familiesList
              .where((element) => element.categories[0].id == categoryId)
              .toList()
              .where((element) => element.name.contains(name))
              .toList()
          : familiesList.where((element) {
              return element.categories[0].id == categoryId;
            }).toList();
    } else {
      products.value.data = productsList;
      offers.value.data = offersList;
      families.value.data = familiesList;
    }
    specialproducts.refresh();
    specialfamilies.refresh();
    specialoffers.refresh();
  }
}

//*************************************************************************
//
class CategoriesGetX extends GetxController {
  var isLoading = true.obs;

  RxList<CategoriesModal> categories = <CategoriesModal>[].obs;

  static CategoriesGetX get to => Get.find();

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  Future<void> getCategories({BuildContext? context}) async {
    isLoading(true);
    try {
      var show =
          await HomeController().getCategoriesController(context: context);
      if (show != null) {
        categories.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

//*************************************************************************

class GetShowProductGetX extends GetxController {
  GetShowProductGetX({required this.id, this.language = ""});
  int id;
  String language;
  var isLoading = true.obs;
  RxMap<String, dynamic> showProduct = <String, dynamic>{}.obs;

  static GetShowProductGetX get to => Get.find();
  @override
  void onInit() {
    getvalues();
    super.onInit();
  }

  Future<void> getvalues({
    BuildContext? context,
  }) async {
    isLoading(true);
    try {
      var show = await HomeController().showProductController(
          context: context, productId: id, language: language);
      if (show != null) {
        showProduct.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

//*************************************************************************
class GetShowFamilyGetX extends GetxController {
  RxList<Familycategories> familycategories = <Familycategories>[].obs;
  Rx<DataFamily<ProductsFamily>> specialproducts =
      DataFamily<ProductsFamily>().obs;
  Rx<DataFamily<ProductsFamily>> products = DataFamily<ProductsFamily>().obs;

  List<Familycategories> familyCategoriesList = <Familycategories>[];
  List<ProductsFamily> productsList = <ProductsFamily>[];

  GetShowFamilyGetX(
      {required this.id,
      this.language = "",
      this.category = "0",
      this.lat = '',
      this.lng = ''});
  int id;
  String language;
  String category;
  String lat;
  String lng;
  var isLoading = true.obs;
  static GetShowFamilyGetX get to => Get.find();
  @override
  void onInit() {
    getShowFamily();
    super.onInit();
  }

  Future<void> getShowFamily({
    BuildContext? context,
  }) async {
    isLoading(true);
    try {
      var response = await HomeController().showFamilyController(
        context: context,
        id: id,
        language: language,
        category: category,
        lng: lng,
        lat: lat,
      );
      if (response != null) {
        familycategories.value = response.familycategories;
        specialproducts.value = response.specialproducts;
        products.value = response.products;
        productsList = products.value.data;
      }
    } finally {
      isLoading(false);
    }
  }

  void filterProductsFamilyByCategory({int categoryId = 0}) {
    if (categoryId != 0) {
      products.value.data = productsList
          .where((element) => element.category == categoryId)
          .toList();
    } else {
      products.value.data = productsList;
    }
    specialproducts.refresh();
    products.refresh();
  }
}

//*************************************************************************
class GetShowFamilyGetXMap extends GetxController {
  GetShowFamilyGetXMap(
      {required this.id, this.language = '', this.lat = '', this.lng = ''});
  int id;
  String language;
  String lat;
  String lng;
  var isLoading = true.obs;

  RxMap<String, dynamic> showfamily = <String, dynamic>{}.obs;
  static GetShowFamilyGetXMap get to => Get.find();
  @override
  void onInit() {
    getvalues();
    super.onInit();
  }

  Future<void> getvalues({
    BuildContext? context,
  }) async {
    isLoading(true);
    try {
      var show = await HomeController().showFamilyControllerMap(
        context: context,
        id: id,
        language: language,
        lng: lng,
        lat: lat,
      );
      if (show != null) {
        showfamily.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

//*************************************************************************
class GetShowImageProductGetX extends GetxController {
  GetShowImageProductGetX({required this.id});
  int id;
  var isLoading = true.obs;
  RxList<ImagesProduct> showImageproduct = <ImagesProduct>[].obs;
  static GetShowImageProductGetX get to => Get.find();
  @override
  void onInit() {
    getvalues();
    super.onInit();
  }

  Future<void> getvalues({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await HomeController()
          .showImagesProductController(context: context, productId: id);
      if (show != null) {
        showImageproduct.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}
