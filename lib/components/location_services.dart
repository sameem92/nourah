import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationService {


  Future<LocationData> getLocation(BuildContext context) async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    // للحصول عالموقع مرة واحدة
    LocationData locationData;
    // locationData.longitude;



    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // SystemNavigator.pop();
        // Navigator.pop(context);


      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        // SystemNavigator.pop();
        // Navigator.pop(context);


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


