import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationService {


  Future<LocationData> getLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    // للحصول عالموقع مرة واحدة
    LocationData locationData;
    // locationData.longitude;




    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        SystemNavigator.pop();      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        SystemNavigator.pop();
      }
    }
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   print("${currentLocation.latitude.toString()}+ '''''''' +${currentLocation.latitude.toString()}");
    // });
    // للحصول عالموقع مرة واحدة
    locationData = await location.getLocation();
      print("${locationData.latitude.toString()}+ '''''''' +${locationData.longitude.toString()}");
return locationData;
  }



}


