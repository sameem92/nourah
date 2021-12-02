import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/storage/api/order_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../public_screens/reporting.dart';

class FollowOrderUser extends StatefulWidget {
  int index;

  FollowOrderUser({this.index = 0});

  @override
  _FollowOrderUserState createState() => _FollowOrderUserState();
}

class _FollowOrderUserState extends State<FollowOrderUser> {
  late GoogleMapController _googleMapController;

  BitmapDescriptor? iconUser;
  BitmapDescriptor? iconDriver;
  Set<Marker> _markers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMarker();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<getOrderFollowGetX>(
        init: getOrderFollowGetX(),
        builder: (getOrderFollowGetX controller) {
          LatLng currentLocation = LatLng(
              controller.orders[widget.index].shippingLat.toDouble(),
              controller.orders[widget.index].shippingLng.toDouble());

          Set<Marker> _markers = {
            if(iconUser !=null)

              Marker(
              markerId: MarkerId("user"),
              position: LatLng(
                  controller.orders[widget.index].shippingLat.toDouble(),
                  controller.orders[widget.index].shippingLng.toDouble()),
              draggable: true,
              icon: iconUser!,
            ),
            if(iconDriver !=null)

            Marker(
              markerId: MarkerId("driver"),
              infoWindow: InfoWindow(
                title: controller.orders[widget.index].deliveryname,
              ),
              position: LatLng(
                  controller.orders[widget.index].deliverylat.toDouble(),
                  controller.orders[widget.index].deliverylng.toDouble()),
              draggable: true,
              icon: iconDriver!,
            ),
          };

          return Scaffold(
              appBar: AppBarWhite(context,
                  title: AppLocalizations.of(context)!.followorder,
                  icon: Icons.call,
                  onPressed: () {}),
              body: controller.isLoading.value
                  ? Center(
                      child:  indicator_nourah_loading()
              )
                  : Stack(
                      children: [
                        GoogleMap(
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          onMapCreated: (controller) async {
                            String style = await DefaultAssetBundle.of(context)
                                .loadString('assets/map_style.json');
                            _googleMapController = controller;
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                controller.orders[widget.index].shippingLat
                                    .toDouble(),
                                controller.orders[widget.index].shippingLng
                                    .toDouble()),
                            zoom: 11.0,
                          ),
                          onCameraMove: (CameraPosition newPos) {
                            currentLocation = newPos.target;
                          },
                          markers: _markers.toSet(),
                        ),
                        Positioned(
                          bottom: SizeConfig.scaleHeight(10),
                          right: SizeConfig.scaleWidth(10),
                          left: SizeConfig.scaleWidth(10),
                          child: ContainerApp(
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: hSpaceSmall,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        image_circle(
                                       imageString:      controller.orders[widget.index]
                                                .deliveryimage,
                                            size: 90),
                                        StyleText(
                                          controller.orders[widget.index]
                                              .deliveryname,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: hSpace,
                                    ),
                                    StyleText(AppLocalizations.of(context)!
                                        .ourRepresentativeHasReceivedYourRequest),
                                    SizedBox(
                                      height: hSpace,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: StyleText(
                                        "${controller.orders[widget.index].shippingCost}  ${AppLocalizations.of(context)!.reyal}",
                                        textColor: kSpecialColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: StyleText(
                                        "${controller.orders[widget.index].deliveryDuration}  ${controller.orders[widget.index].deliveryDurationUnit == "h" ? AppLocalizations.of(context)!.hour : "${controller.orders[widget.index].deliveryDurationUnit}" == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                        textColor: kSpecialColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: hSpace,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: StyleButton(
                                        AppLocalizations.of(context)!
                                            .chatWithDriver,
                                        onPressed: () {
                                          Navigator.pushNamed(context, "/chat");
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: wSpace,
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: StyleButton(
                                        AppLocalizations.of(context)!.done,
                                        sideColor: kConfirm,
                                        backgroundColor: kConfirm,
                                        onPressed: () async {
                                          await deliveredrmDeliveryOrder(order_id: "${controller.orders[widget.index].id}");
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: wSpace,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: StyleButton(
                                        AppLocalizations.of(context)!.reporting,
                                        sideColor: kRefuse,
                                        backgroundColor: kRefuse,
                                        onPressed: () async {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return Reporting(
                                                    family: true, driver: true,id: "${controller.orders[widget.index].id}",);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: hSpace,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              floatingActionButton: controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator.adaptive()
              )
                  : Container(
                      height: SizeConfig.scaleHeight(600),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            onPressed: () async {
                              _googleMapController.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    target: LatLng(
                                        controller
                                            .orders[widget.index].shippingLat
                                            .toDouble(),
                                        controller
                                            .orders[widget.index].shippingLng
                                            .toDouble()),
                                    zoom: 13)),
                              );
                            },
                            child: Icon(
                              Icons.gps_fixed,
                              color: Colors.white,
                            ),
                            backgroundColor: kSpecialColor,
                          ),
                          SizedBox(
                            height: hSpaceLarge,
                          ),
                          FloatingActionButton(
                            onPressed: () async {
                              _googleMapController.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    target: LatLng(
                                        controller
                                            .orders[widget.index].deliverylat
                                            .toDouble(),
                                        controller
                                            .orders[widget.index].deliverylng
                                            .toDouble()),
                                    zoom: 13)),
                              );
                            },
                            child: Icon(
                              Icons.delivery_dining,
                              color: Colors.white,
                            ),
                            backgroundColor: kSpecialColor,
                          ),
                        ],
                      ),
                    ));
        }
        );
  }

  void _getMarker() async {
    iconUser = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/userIcon.png');

    iconDriver = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/driverIcon.png');
  }

  Future deliveredrmDeliveryOrder({String order_id=""}) async {
    bool deliveredIt =
        await OrderController().DeliveredDeliveryOrderUserController(
      context: context,
      language: Localizations.localeOf(context).languageCode=="ar"?"ar":"en",
      order_id: order_id,
    );

    print(deliveredIt);

    if (deliveredIt) {
      print('ccccctrueeee55555');
    }
  }
}
