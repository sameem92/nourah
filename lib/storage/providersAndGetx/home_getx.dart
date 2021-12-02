import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:producer_family_app/storage/api/home_controller.dart';
import 'package:producer_family_app/storage/models/home_modal/categories_modal.dart';
import 'package:producer_family_app/storage/models/home_modal/home_modal.dart';
import 'package:producer_family_app/storage/models/show_modal/show_family.dart';
import 'package:producer_family_app/storage/models/show_modal/show_product_modal.dart';

class HomeGetx extends GetxController {
  Rx<Data<Products>> specialproducts = Data<Products>().obs;
  Rx<Data<Products>> products = Data<Products>().obs;
  Rx<Data<Families>> specialfamilies = Data<Families>().obs;
  Rx<Data<Families>> families = Data<Families>().obs;
  Rx<Data<Offers>> specialoffers = Data<Offers>().obs;
  Rx<Data<Offers>> offers = Data<Offers>().obs;

  //for categories and search
  List<Products> productsList = <Products>[];
  List<Families> familiesList = <Families>[];
  List<Offers> offersList = <Offers>[];

  static HomeGetx get to => Get.find();
  var isLoading = true.obs;
  String language;
  String lat;
  String lng;
  String category;


  HomeGetx({this.language = '', this.lat = '', this.lng = '',this.category="0"});

  @override
  void onInit() {
    getHomeData();
    super.onInit();
  }

  Future<void> getHomeData({BuildContext? context,}) async {
    isLoading(true);
    try {
      var response = await HomeController().getHome(
          context: context,
          keyword: '',
          category: category,
          language: language,
          lat: lat,
          lng: lng);
      if (response != null) {
        specialproducts.value = response.specialproducts;
        products.value = response.products;

        specialfamilies.value = response.specialfamilies;
        families.value = response.families;

        specialoffers.value = response.specialoffers;
        offers.value = response.offers;


        productsList = products.value.data;
        familiesList = families.value.data;
        offersList = offers.value.data;
      }
    } finally {
      isLoading(false);
    }
  }

  void filterProductsByName({String name = '', BuildContext? context}) {
    if (name.isNotEmpty) {
      Localizations.localeOf(context!).languageCode == "ar"
          ? products.value.data = productsList
              .where((element) => element.arname.contains(name))
              .toList()
          : products.value.data = productsList
              .where((element) => element.enname.contains(name))
              .toList();

      Localizations.localeOf(context).languageCode == "ar"
          ? offers.value.data = offersList
              .where((element) => element.arname.contains(name))
              .toList()
          : offers.value.data = offersList
              .where((element) => element.enname.contains(name))
              .toList();

      families.value.data =
          familiesList.where((element) => element.name.contains(name)).toList();
    } else {
      products.value.data = productsList;
      offers.value.data = offersList;
      families.value.data = familiesList;
    }
    specialproducts.refresh();
    specialfamilies.refresh();
    specialoffers.refresh();
  }

  void filterProductsByCategory({int categoryId = 0,String name = ''}) {
    if (categoryId != 0 ) {
      products.value.data = productsList.where((element) => element.category == categoryId).toList();
      offers.value.data = offersList.where((element) => element.category == categoryId).toList();
      // families.value.data = familiesList.where((element) => element.categories![categoryId].arname.contains(name)).toList();
    } else {
      products.value.data = productsList;
      offers.value.data = offersList;
      families.value.data = familiesList;
    }


    products.refresh();

    families.refresh();
    offers.refresh();
  }
}

//*************************************************************************

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
        update();
      }
    } finally {
      isLoading(false);
    }
  }
}

//*************************************************************************

class getShowProductGetX extends GetxController {
  getShowProductGetX({this.id = "", this.language = ""});
  String id;
  String language;
  var isLoading = true.obs;
  RxMap<String, dynamic> Showproduct = <String, dynamic>{}.obs;

  static getShowProductGetX get to => Get.find();
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
      var show = await HomeController().ShowProductController(
          context: context, product_id: id, language: language);
      if (show != null) {
        Showproduct.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

//*************************************************************************
class getShowFamilyGetX extends GetxController {
  RxList<Familycategories> familycategories = <Familycategories>[].obs;
  Rx<DataFamily<ProductsFamily>> specialproducts = DataFamily<ProductsFamily>().obs;
  Rx<DataFamily<ProductsFamily>> products = DataFamily<ProductsFamily>().obs;

  List<Familycategories> Familycategorieslist = <Familycategories>[];
  List<ProductsFamily> productsList = <ProductsFamily>[];

  getShowFamilyGetX({this.id = "", this.language = "",this.category="0"});
  String id;
  String language;
  String category;
  bool familyMap=false;
  var isLoading = true.obs;
  static getShowFamilyGetX get to => Get.find();
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
      var response= await HomeController()
          .ShowFamilyController(context: context, id: id, language: language,category:category );
      if (response != null ) {
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
      products.value.data = productsList.where((element) => element.category == categoryId).toList();
       } else {
      products.value.data = productsList;
     }
    specialproducts.refresh();
    products.refresh();
  }
}
//*************************************************************************
class getShowFamilyGetXMap extends GetxController {
  getShowFamilyGetXMap({this.id = "",this.language=''});
  String id;
  String language;
  var isLoading = true.obs;

  RxMap<String, dynamic> showfamily = <String, dynamic>{}.obs;
  static getShowFamilyGetXMap get to => Get.find();
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
      var show = await HomeController()
          .ShowFamilyControllerMap(context: context, id: id,language: language);
      if (show != null) {
        showfamily.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}
//*************************************************************************
class getShowImageProductGetX extends GetxController {
  getShowImageProductGetX({this.id = ""});
  String id;
  var isLoading = true.obs;
  RxList<ImagesProduct> ShowImageproduct = <ImagesProduct>[].obs;
  static getShowImageProductGetX get to => Get.find();
  @override
  void onInit() {
    getvalues();
    super.onInit();
  }

  Future<void> getvalues({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await HomeController()
          .ShowImagesProductController(context: context, product_id: id);
      if (show != null) {
        ShowImageproduct.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}
