import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:producer_family_app/screens/public_screens/splash.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

class MapCustom extends StatefulWidget {
  final double latCustom;
  final double lngCustom;

  const MapCustom({
    required this.latCustom,
    required this.lngCustom,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapCustom> with FbNotifications {
  String latitude = "";
  final _googleMapController = Completer();
  @override
  void initState() {
    getAddressLocation();
    _getMarker();
    super.initState();
    managenotificationAction(context);
  }

  BitmapDescriptor? icon;
  // Set<Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = {
      if (icon != null)
        Marker(
          markerId: const MarkerId("user"),
          position: LatLng(widget.lngCustom, widget.lngCustom),
          draggable: true,
          icon: icon!,
        )
    };
    final CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(widget.latCustom, widget.lngCustom),
      zoom: 18,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kSpecialColor,
            size: fIcon,
          ),
        ),
        backgroundColor: kBackgroundColor,
        title: StyleText(
          "${AppLocalizations.of(context)!.location}  :   $latitude",
          maxLines: 3,
          height: 1.7,
          textAlign: TextAlign.center,
          textColor: kSpecialColor,
        ),
        toolbarHeight: SizeConfig.scaleTextFont(100),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (GoogleMapController controller) async {
              _googleMapController.complete(controller);
            },
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            markers: markers.toSet(),
          ),
          Dot(
            radius: SizeConfig.scaleTextFont(15),
            color: kSpecialColor,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.gps_fixed,
          color: Colors.white,
        ),
        backgroundColor: kSpecialColor,
        onPressed: () async {
          _animateCamera(
            LatLng(widget.latCustom, widget.lngCustom),
          );
          // print("latCustom ${widget.latCustom}");
          // print("lngCustom ${widget.lngCustom}");
        },
      ),
    );
  }

  getAddressLocation({lat, long}) async {
    final List<Placemark> placemarks =
        await placemarkFromCoordinates(widget.latCustom, widget.lngCustom);
    if (mounted) {
      setState(() {
        latitude =
            "${placemarks[0].street!} ${placemarks[0].subLocality!} ${placemarks[0].isoCountryCode!} ${placemarks[0].name!}";
      });
    }
  }

  Future<void> _getMarker() async {
    icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/userIcon.png',
    );
  }

  Future<void> _animateCamera(LatLng currentLocation) async {
    final GoogleMapController controller = await _googleMapController.future;
    final CameraPosition cameraPosition = CameraPosition(
      target: currentLocation,
      zoom: 18.00,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
