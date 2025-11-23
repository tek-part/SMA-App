import 'dart:async';

import 'package:bandora_app/logic/controller/details_order_controller.dart';
import 'package:bandora_app/logic/controller/order_status_controller.dart';
import 'package:bandora_app/utils/them.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Order_evaluation_view extends StatefulWidget {
  String code = '';

  Order_evaluation_view({
    required this.code,
  });

  @override
  _Order_evaluation_view createState() => _Order_evaluation_view();
}

class _Order_evaluation_view extends State<Order_evaluation_view> {
  bool issearching = false;
  late GoogleMapController mapController;

  OrderDetailsController _orderDetailsController =
      Get.put(OrderDetailsController());
  OrderStatusController controller = Get.put(OrderStatusController());

  late Timer timer;

  double _rating = 3;

  @override
  void initState() {
    _start();
    super.initState();
  }

  _start() async {
    await controller.get_rating(4);
    _rating = double.parse(controller.driver.value!.averageRating);
    await _orderDetailsController.getProducrtDetails(int.parse(widget.code));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CameraPosition _kGooglePlex = CameraPosition(
      // bearing: 192.8334901395799,
      target: LatLng(33.320542, 44.382377),
      tilt: 59.440717697143555,
      zoom: 11.4746,
    );
    return _mobile(_kGooglePlex);
  }

  _mobile(_kGooglePlex) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('evaluation'.tr),
        centerTitle: true,
        leading: CloseButton(),
      ),

      body: Stack(
        children: [
          Container(
            // height: 500,
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              compassEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              //   trafficEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;

                // _getPolyline();
              },
            ),
          ),
          Positioned(
            bottom: 5,
            child: Container(
              width: Get.width,
              // color: Colors.white,
              height: Get.height * 0.65,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                    // bottomLeft: Radius.circular(40),
                    // bottomRight: Radius.circular(40),
                  )),
              child: Obx(() => controller.driver.value == null
                  ? Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    )
                  : Column(
                      children: [
                        Icon(
                          Icons.person_pin,
                          color: Colors.black,
                          size: 100,
                        ),
                        Text(
                          controller.orderStatusItemList
                              .firstWhere(
                                  (el) => el.id == int.parse(widget.code))
                              .representativeName,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'الطلبات',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  controller.driver.value!.numberOfOrders
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'تقييم',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      _rating.toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'سنوات',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  1.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    // Icon(Icons.card_travel_rounded,color: Colors.cyanAccent,size: 50,),
                                    Image.asset('assets/icons/icon55.png'),
                                    Positioned(
                                        top: -3,
                                        left: -3,
                                        child: Text(controller.driver.value!
                                            .ratingsPerCategory.first.total
                                            .toString()))
                                  ],
                                ),
                                Text(
                                  controller.driver.value!.ratingsPerCategory
                                      .first.name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    // Icon(Icons.card_travel_rounded,color: Colors.cyanAccent,size: 50,),
                                    Image.asset('assets/icons/icon66.png'),
                                    Positioned(
                                        top: -3,
                                        left: -3,
                                        child: Text(controller.driver.value!
                                            .ratingsPerCategory.last.total
                                            .toString()))
                                  ],
                                ),
                                Text(
                                  controller.driver.value!.ratingsPerCategory
                                      .last.name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        MaterialButton(
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                            color: Colors.greenAccent,
                            onPressed: () => launchUrlString(
                                "tel://" + controller.driver.value!.phone),
                            child: Icon(Icons.phone, color: Colors.redAccent))
                      ],
                    )),
            ),
          )
        ],
      ),
      //   floatingActionButton: FloatingActionButton.extended(
      //     icon: Icon(Icons.location_on_outlined),
      //     label: Text('المكان الحالي'),
      //   onPressed: (){
      //       setState((){
      //         _productController.currentLocation(mapController);
      //
      //       });
      //
      //   },
      // ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    // myFocusNode.dispose();
    //   mapController.dispose();
    // _productController.closelocation();
    // _productController.islocation_map(false);
    timer.cancel();
    super.dispose();
  }
}
