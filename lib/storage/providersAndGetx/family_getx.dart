import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:producer_family_app/storage/api/family_controller/categories_family_controller.dart';
import 'package:producer_family_app/storage/api/family_controller/family_controller.dart';
import 'package:producer_family_app/storage/api/family_controller/products_family_controller.dart';
import 'package:producer_family_app/storage/models/family_modal/get_categories_modal.dart';
import 'package:producer_family_app/storage/models/family_modal/products_family.dart';

class GetFamilyPolicyGetx extends GetxController {
  var isLoading = true.obs;

  RxMap<dynamic, dynamic> policies = <dynamic, dynamic>{}.obs;

  static GetFamilyPolicyGetx get to => Get.find();

  @override
  void onInit() {
    getPolicy();
    super.onInit();
  }

  Future<void> getPolicy({BuildContext? context, bool? isUpdated}) async {
    isLoading(true);
    try {
      var show = await FamilyController()
          .getFamilyPoliciesController(context: context, isUpdated: isUpdated);
      if (show != null) {
        policies.value = show;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> addPolicies({
    required BuildContext context,
    required String arPolicy,
    required String enPolicy,
  }) async {
    bool add = await FamilyController().addPoliciesFamilyController(
      context,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      enPolicy: enPolicy,
      arPolicy: arPolicy,
    );

    if (add) {
      getPolicy(isUpdated: true);
    }
  }
}
//***********************************************************

class GetCategoriesFamilyGetx extends GetxController {
  var isLoading = true.obs;

  RxList<CategoriesModalFamily> categoriesFamily =
      <CategoriesModalFamily>[].obs;

  static GetCategoriesFamilyGetx get to => Get.find();

  @override
  void onInit() {
    getCategory();
    super.onInit();
  }

  Future<void> getCategory({BuildContext? context, bool? isUpdated}) async {
    isLoading(true);
    try {
      var show = await CategoriesFamilyController()
          .getFamilyCategoriesController(
              context: context, isUpdated: isUpdated);
      if (show != null) {
        categoriesFamily.value = show;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshData() async {
    getCategory(isUpdated: true);
  }

  Future<void> addCategories(
      {required BuildContext context,
      required String arname,
      required String enname,
      required int id}) async {
    bool add = await CategoriesFamilyController().addCategoriesFamilyController(
        context,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
        arname: arname,
        enname: enname,
        id: id);

    if (add) {
      // categoriesFamily.add(CategoriesModalFamily(arname: arname,enname: enname,id: id));
      getCategory(isUpdated: true);
    }
  }

  Future<void> deleteCategories(
      {required BuildContext context, required int categoryId}) async {
    bool delete =
        await CategoriesFamilyController().deleteCategoriesFamilyController(
      categoryId: categoryId.toString(),
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      context: context,
    );

    if (delete) {
      // categoriesFamily.removeWhere((element) => element.id == category_id);

      getCategory(isUpdated: true);
    }
  }

  Future<void> updateCategories(
      {required BuildContext context,
      required String arname,
      required String enname,
      required int categoryId}) async {
    bool update =
        await CategoriesFamilyController().updateCategoriesFamilyController(
      context,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      enname: enname,
      arname: arname,
      categoryId: categoryId.toString(),
    );

    if (update) {
      // categoriesFamily.removeWhere((element) => element.id == category_id);
      //
      // categoriesFamily.add(CategoriesModalFamily(arname: arname,enname: enname,id: category_id));
      getCategory(isUpdated: true);
    }
  }
}
//***********************************************************

class GetProductsFamilyGetx extends GetxController {
  var isLoading = true.obs;
  String language = '';
  RxList<ProductsModalFamily> productsFamily = <ProductsModalFamily>[].obs;
  GetProductsFamilyGetx({this.language = ''});
  static GetProductsFamilyGetx get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    getProductFamily();
  }

  Future<void> getProductFamily(
      {BuildContext? context, bool? isUpdated}) async {
    isLoading(true);
    try {
      var show = await ProductFamilyController().getFamilyProductsController(
          context: context, language: language, isUpdated: isUpdated);
      if (show != null) {
        productsFamily.value = show;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshData() async {
    await getProductFamily(isUpdated: true);
  }

  Future<void> deleteProduct(
      {required BuildContext context, required int id}) async {
    bool deleted = await ProductFamilyController()
        .deleteProductFamilyController(
            context: context,
            language: Localizations.localeOf(context).languageCode == "ar"
                ? "ar"
                : "en",
            productId: id.toString());

    if (deleted) {
      // productsFamily.removeWhere((element) => element.id == id);
      getProductFamily(isUpdated: true);
    }
  }

  Future<void> editProduct(BuildContext context,
      {String? path1 = "",
      required int productId,
      required int imageId,
      required int category,
      String arname = '',
      String enname = '',
      int price = 0,
      int offerStatus = 0,
      required int brand,
      int durationFrom = 0,
      int durationTo = 0,
      String durationUnit = '',
      int offerDuration = 0,
      String offerDurationUnit = '',
      String language = '',
      required double offerPrice,
      String ardesc = '',
      String endesc = '',
      required Function(bool status) uploadEvent}) async {
    await ProductFamilyController().editProductController(
      context,
      uploadEvent: uploadEvent,
      language: language,
      productId: productId,
      category: category,
      enname: enname,
      arname: arname,
      ardesc: ardesc,
      brand: brand,
      durationFrom: durationFrom,
      durationTo: durationTo,
      durationUnit: durationUnit,
      endesc: endesc,
      imageId: imageId,
      offerDuration: offerDuration,
      offerDurationUnit: offerDurationUnit,
      offerPrice: offerPrice,
      offerStatus: offerStatus,
      path1: path1,
      price: price,
    );

    getProductFamily(isUpdated: true);
  }

  Future<void> editProductWithouSale(
    BuildContext context, {
    String? path1 = "",
    required int productId,
    required int imageId,
    required int category,
    String arname = '',
    String enname = '',
    int price = 0,
    required int brand,
    int durationFrom = 0,
    int durationTo = 0,
    String durationUnit = '',
    String language = '',
    String ardesc = '',
    String endesc = '',
    required Function(bool status) uploadEvent,
  }) async {
    await ProductFamilyController().editProductWithoutSaleController(
      context,
      uploadEvent: uploadEvent,
      language: language,
      productId: productId,
      category: category,
      enname: enname,
      brand: brand,
      arname: arname,
      ardesc: ardesc,
      durationFrom: durationFrom,
      durationTo: durationTo,
      durationUnit: durationUnit,
      endesc: endesc,
      imageId: imageId,
      path1: path1,
      price: price,
    );

    getProductFamily(isUpdated: true);
  }

  Future<void> addProduct(BuildContext context,
      {String? path1 = "",
      String imageId = '',
      required int category,
      String arname = '',
      String enname = '',
      int price = 0,
      int offerStatus = 0,
      required int brand,
      int durationFrom = 0,
      int durationTo = 0,
      String durationUnit = '',
      required int offerDuration,
      String offerDurationUnit = '',
      required int offerPrice,
      int offerDiscount = 0,
      int productId = 0,
      String ardesc = '',
      String endesc = '',
      required Function(bool status) uploadEvent}) async {
    await ProductFamilyController().adddProductController(context,
        uploadEvent: uploadEvent,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
        category: category,
        enname: enname,
        arname: arname,
        ardesc: ardesc,
        brand: brand,
        durationFrom: durationFrom,
        durationTo: durationTo,
        durationUnit: durationUnit,
        endesc: endesc,
        imageId: imageId,
        offerDuration: offerDuration,
        offerDurationUnit: offerDurationUnit,
        offerPrice: offerPrice,
        path1: path1,
        offerStatus: offerStatus,
        price: price);
    getProductFamily(isUpdated: true);
  }

  Future<void> addProductWithoutSale(BuildContext context,
      {String? path1 = "",
      String imageId = '',
      required int category,
      String arname = '',
      String enname = '',
      int price = 0,
      required int brand,
      int durationFrom = 0,
      int durationTo = 0,
      String durationUnit = '',
      int productId = 0,
      String ardesc = '',
      String endesc = '',
      required Function(bool status) uploadEvent}) async {
    await ProductFamilyController().adddProductWithoutSaleController(context,
        uploadEvent: uploadEvent,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
        category: category,
        enname: enname,
        arname: arname,
        ardesc: ardesc,
        durationFrom: durationFrom,
        durationTo: durationTo,
        durationUnit: durationUnit,
        endesc: endesc,
        imageId: imageId,
        brand: brand,
        path1: path1,
        price: price);
    getProductFamily(isUpdated: true);
  }
}

//***********************************************************
class GetOneProductFamilyGetx extends GetxController {
  RxMap<String, dynamic> oneProduct = <String, dynamic>{}.obs;

  static GetOneProductFamilyGetx get to => Get.find();

  @override
  void onInit() {
    getProductFamily();
    super.onInit();
  }

  Future<void> getProductFamily({BuildContext? context}) async {
    oneProduct.value = await ProductFamilyController()
        .getFamilyOneProductsController(context: context);
  }
}

//***********************************************************

class GetMainCategoriesFamilyGetx extends GetxController {
  var isLoading = true.obs;
  String language = '';
  RxList<MainCategoriesModalFamily> mainCategoriesFamily =
      <MainCategoriesModalFamily>[].obs;
  GetMainCategoriesFamilyGetx({this.language = ''});
  static GetMainCategoriesFamilyGetx get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    getMainProductFamily();
  }

  Future<void> getMainProductFamily({
    BuildContext? context,
  }) async {
    isLoading(true);
    try {
      var show =
          await ProductFamilyController().getFamilyMainCategoriesController(
        context: context,
      );
      if (show != null) {
        mainCategoriesFamily.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}
