import 'package:flutter/cupertino.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';

class LanguageChangeNotifer extends ChangeNotifier {
  String language =SharedPreferencesController().getlanguage() ;
  Future changeLanguage(String newLanguage) async{
    language = newLanguage;
  // await  SharedPreferencesController().changeLanguage(locale.languageCode);
    notifyListeners();
  }
}

class LatNotiferUser extends ChangeNotifier {
   double latUser =0;

  void changeLatUser(double latUser) {
    this.latUser = latUser;
    notifyListeners();
  }
}
class LongNotiferUser extends ChangeNotifier {
   double longUser =0;

  void changeLongUser(double longUser) {
    this.longUser = longUser;
    notifyListeners();
  }
}



class LatNotiferDriver extends ChangeNotifier {
  double latDriver =0;

  void changeLatDriver(double latDriver ){
    this.latDriver = latDriver;
    notifyListeners();
  }
}
class LongNotiferDriver extends ChangeNotifier {
  double longDriver=0;

  void changeLongDriver(double longDriver) {
    this.longDriver = longDriver;
    notifyListeners();
  }
}


class LatNotiferFamily extends ChangeNotifier {
  double latFamily =0;

  void changeLatFamily (double latFamily) {
    this.latFamily = latFamily;
    notifyListeners();
  }
}
class LongNotiferFamily extends ChangeNotifier {
  double longFamily =0;

  void changeLongFamily(double longFamily) {
    this.longFamily= longFamily;
    notifyListeners();
  }
}

class stringNotiferFamily extends ChangeNotifier {
  String addressFamily ="";

  void changeStringFamily(String addressFamily) {
    this.addressFamily= addressFamily;
    notifyListeners();
  }
}


class stringNotiferUser extends ChangeNotifier {
  String addressUser ="";

  void changeStringUser(String addressUser) {
    this.addressUser= addressUser;
    notifyListeners();
  }
}

class stringNotiferDriver extends ChangeNotifier {
  String addressDriver ="";

  void changeStringDriver(String addressDriver) {
    this.addressDriver= addressDriver;
    notifyListeners();
  }
}



class stringNotiferSearch extends ChangeNotifier {
  String search ="";

  void changeStringSearch(String search) {
    this.search= search;
    notifyListeners();
  }
}


class intCategoryId extends ChangeNotifier {
  int categoryId =0;

  void changeCategoryId(int categoryId) {
    this.categoryId= categoryId;
    notifyListeners();
  }
}


class intIndexTabHome extends ChangeNotifier {
  int intIndex =0;

  void changeIntIndexTabHome(int intIndex) {
    this.intIndex= intIndex;
    notifyListeners();
  }
}

class intIndexorder extends ChangeNotifier {
  int? intIndex;

  void changeIntIndexorder(int intIndex) {
    this.intIndex= intIndex;
    notifyListeners();
  }
}

class intIndexProfile extends ChangeNotifier {
  int? intIndex;

  void changeIntIndexProfile(int intIndex) {
    this.intIndex= intIndex;
    notifyListeners();
  }
}

class intOrderToConfirmFamily extends ChangeNotifier {
  int intIndex =0;

  void changeIntOrderToConfirmFamily(int intIndex) {
    this.intIndex= intIndex;
    notifyListeners();
  }
}
class stringNoteCustomer extends ChangeNotifier {
  String noteCustomer ='';

  void changeStringNoteCustomer( String noteCustomer) {
    this.noteCustomer= noteCustomer;
    notifyListeners();
  }
}

