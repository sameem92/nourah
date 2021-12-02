import 'package:producer_family_app/storage/models/login_modal.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/login_modal.dart';

class SharedPreferencesController {
  SharedPreferencesController._intenal();

  final String loggedInUser = "loggedInUser";
  final String loggedInUserGoogle = "loggedInUserGoogle";
  final String loggedInUserapple = "loggedInUserapple";
  final String loggedInFamily = "loggedInFamily";
  final String loggedInDriver = "loggedInDriver";
  final String tokenKey = "token";

  late SharedPreferences _sharedPreferences;
  static final SharedPreferencesController _instance =
      SharedPreferencesController._intenal();

  factory SharedPreferencesController() {
    return _instance;
  }

  Future<void> initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //  user log  *************************************************

  Future saveLoggedInUser() async {
    await _sharedPreferences.setBool(loggedInUser, true);
  }

  bool get isLoggedInUser => _sharedPreferences.getBool(loggedInUser) ?? false;

  //  user log  google *************************************************

  Future saveLoggedInUserGoogle() async {
    await _sharedPreferences.setBool(loggedInUserGoogle, true);
  }

  bool get isLoggedInUserGoogle =>
      _sharedPreferences.getBool(loggedInUserGoogle) ?? false;

  //  user log  apple *************************************************

  Future saveLoggedInUserapple() async {
    await _sharedPreferences.setBool(loggedInUserapple, true);
  }

  bool get isLoggedInUserapple =>
      _sharedPreferences.getBool(loggedInUserapple) ?? false;

//  family log  *************************************************

  Future saveLogiInFamily() async {
    await _sharedPreferences.setBool(loggedInFamily, true);
  }

  bool get isLoggedInFamily =>
      _sharedPreferences.getBool(loggedInFamily) ?? false;

//***********************************************************************
  //get token  && save token in loginModal
  String get token => _sharedPreferences.getString(tokenKey) ?? "";

  Future save(LoginModal loginModal) async {
    await _sharedPreferences.setString(
        tokenKey, 'Bearer ' + loginModal.accesstoken);
  }

  Future saveId(int Id) async {
    await _sharedPreferences.setString('id', Id.toString());
  }

  int getUserId() => _sharedPreferences.getInt('id') ?? 0;

//***********************************************************************

  //  Driver log  *************************************************
  Future saveLogiInDriver() async {
    await _sharedPreferences.setBool(loggedInDriver, true);
  }

  bool get isLoggedInDriver =>
      _sharedPreferences.getBool(loggedInDriver) ?? false;

//***********************************************************************
  Future logout() async {
    await _sharedPreferences.clear();
    await _sharedPreferences.setBool(loggedInUserapple, false);
    await _sharedPreferences.setBool(loggedInUserGoogle, false);
    await _sharedPreferences.setBool(loggedInDriver, false);
    await _sharedPreferences.setBool(loggedInFamily, false);
    await _sharedPreferences.setBool(loggedInUser, false);

  }

//***********************************************************************

  Future<bool> changeLanguage(String languageCode) async {
    return await _sharedPreferences.setString("language_code", languageCode);
  }

  String getlanguage() => _sharedPreferences.getString("language_code") ?? 'ar';
}
