import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';

class getProfileGetx extends GetxController {
  RxMap<String, dynamic> profile = <String, dynamic>{}.obs;
  static getProfileGetx get to => Get.find();
  var isLoading = true.obs;

  @override
  void onInit() {
    getProfile();

    super.onInit();
  }

  Future<void> getProfile({BuildContext? context}) async {
    isLoading(true);

    try {
      var show = await loginAndProfileController().getProfileController(
        context: context,
      );
      if (show != null) {
        profile.value = show;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> changeValidity({
    required BuildContext context,
    required String available,
  }) async {
    bool edit = await loginAndProfileController().changeValidityController(
      context,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      available: available,
    );

    if (edit) {
      getProfile();
    }
  }

  Future<void> updateProfile(
      {required BuildContext context,
      String? path2,
      String? path1,
      required String notes,
      required String ennotes,
      required String minimum_order,
      required String name,
      required String email,
      required String phone,
      required Function(bool status) uploadEvent}) async {
    await loginAndProfileController().updateProfileController(context,
        path2: path2,
        path1: path1,
        notes: notes,
        ennotes: ennotes,
        minimum_order: minimum_order,
        name: name,
        email: email,
        phone: phone,
        language: Localizations.localeOf(context).languageCode == "ar"
            ? "ar"
            : "en", uploadEvent: (bool status) {
      {
        return true;
      }
      ;
    });
    getProfile();
  }
}
