import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:producer_family_app/storage/api/app_controller.dart';
import 'package:producer_family_app/storage/models/app_modal/banners_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/faq_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/message_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/notification_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/social_media_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/statistics.dart';

class GetAboutUsGetx extends GetxController {
  String language;

  GetAboutUsGetx({this.language = 'ar'});
  RxMap<String, dynamic> aboutUs = <String, dynamic>{}.obs;
  static GetAboutUsGetx get to => Get.find();
  var isLoading = true.obs;

  @override
  void onInit() {
    getAboutUs();
    super.onInit();
  }

  Future<void> getAboutUs({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await AppController()
          .getAboutUsController(context: context, language: language);

      if (show != null) {
        aboutUs.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

class GetprivacyGetx extends GetxController {
  String language;

  GetprivacyGetx({this.language = 'ar'});

  RxMap<String, dynamic> privacies = <String, dynamic>{}.obs;
  static GetSocialGetx get to => Get.find();
  var isLoading = true.obs;

  @override
  void onInit() {
    getPrivacy();
    super.onInit();
  }

  Future<void> getPrivacy({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await AppController()
          .getPrivacyController(context: context, language: language);
      if (show != null) {
        privacies.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

class GetSocialGetx extends GetxController {
  RxList<SocialMediaModal> socials = <SocialMediaModal>[].obs;
  static GetSocialGetx get to => Get.find();
  var isLoading = true.obs;

  @override
  void onInit() {
    getSocials();
    super.onInit();
  }

  Future<void> getSocials({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await AppController().getSocialMediaController(
        context: context,
      );
      if (show != null) {
        socials.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

class GetFaqGetx extends GetxController {
  String language;

  GetFaqGetx({this.language = "ar"});

  var isLoading = true.obs;
  RxList<FaqModal> faqs = <FaqModal>[].obs;

  static GetFaqGetx get to => Get.find();
  @override
  void onInit() {
    getFaqs();
    super.onInit();
  }

  Future<void> getFaqs({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await AppController()
          .getFaqController(context: context, language: language);
      if (show != null) {
        faqs.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

class GetMessageGetx extends GetxController {
  var isLoading = true.obs;
  String language;

  GetMessageGetx({this.language = ""});

  RxList<MessagesModal> messages = <MessagesModal>[].obs;
  static GetMessageGetx get to => Get.find();
  @override
  void onInit() {
    getMessages();
    super.onInit();
  }

  Future<void> getMessages({BuildContext? context, bool? isUpdated}) async {
    isLoading(true);
    try {
      var show = await AppController().getMessageController(
          context: context, language: language, isUpdated: isUpdated);
      if (show != null) {
        messages.value = show;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> sendMessage({
    required BuildContext context,
    required String message,
  }) async {
    bool add = await AppController().postMessageController(
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      message: message,
    );

    if (add) {
      getMessages(isUpdated: true);
      // getMessages();
      // messages.refresh();
    }
  }
}

class GetstatisticsGetx extends GetxController {
  var isLoading = true.obs;

  RxMap<dynamic, dynamic> statistices = <dynamic, dynamic>{}.obs;
  static GetstatisticsGetx get to => Get.find();
  @override
  void onInit() {
    getStatistics();
    super.onInit();
  }

  Future<void> getStatistics({BuildContext? context, bool? isUpdated}) async {
    isLoading(true);
    try {
      var show =
          await AppController().getStatisticsController(context: context);
      if (show != null) {
        statistices.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

class GetCoulmnstatisticsGetx extends GetxController {
  RxList<StatisticssModal> statistices = <StatisticssModal>[].obs;
  // String currentName=getCoulmnstatisticsGetx().statistices[0].startDate;
  var isLoading = true.obs;
  static GetstatisticsGetx get to => Get.find();
  @override
  void onInit() {
    getStatistics();
    super.onInit();
  }

  Future<void> getStatistics({BuildContext? context}) async {
    isLoading(true);
    try {
      var show =
          await AppController().getColumnStatisticsController(context: context);
      if (show != null) {
        statistices.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

class GetNotificationsGetx extends GetxController {
  var isLoading = true.obs;
  RxList<NotificationsModal> notifications = <NotificationsModal>[].obs;
  static GetMessageGetx get to => Get.find();
  @override
  void onInit() {
    getMessages();
    super.onInit();
  }

  Future<void> getMessages({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await AppController().getNotificationController(
        context: context,
      );
      if (show != null) {
        notifications.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

class GetBannersGetx extends GetxController {
  var isLoading = true.obs;
  RxList<BannersModal> banners = <BannersModal>[].obs;
  static GetBannersGetx get to => Get.find();
  @override
  void onInit() {
    getBanners();
    super.onInit();
  }

  Future<void> getBanners({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await AppController().getBannersController(
        context: context,
      );
      if (show != null) {
        banners.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

class GetNetworkGetx extends GetxController {
  var connectionType = 1.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    getNetwork();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getNetwork() async {
    ConnectivityResult? result;
    try {
      result = await (_connectivity.checkConnectivity());
    } on PlatformException {
      // print(e.toString());
    }
    return _updateState(result!);
  }

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        update();

        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        update();

        break;
      case ConnectivityResult.none:
        connectionType.value = 0;

        update();

        break;
      default:
        Get.snackbar("error network", "failed");
        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }

  Future<void> refreshData() async {
    getNetwork();
  }
}
