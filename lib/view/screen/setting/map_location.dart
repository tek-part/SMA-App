import 'dart:async';

import 'package:bandora_app/logic/controller/details_order_controller.dart';
import 'package:bandora_app/logic/controller/order_status_controller.dart';
// import 'package:bandora_app/view/widget/cart/prices_widget.dart';
import 'package:bandora_app/view/widget/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Map_Location extends StatefulWidget {
  String code = '';

  Map_Location({
    required this.code,
  });

  @override
  _MapLocation createState() => _MapLocation();
}

class _MapLocation extends State<Map_Location> {
  bool issearching = false;
  late GoogleMapController mapController;

  OrderDetailsController _orderDetailsController =
      Get.put(OrderDetailsController());
  OrderStatusController controller = Get.put(OrderStatusController());

  final List<Marker> _markers = [];
  final Set<Polyline> _polyline = {};
  List<LatLng> polylineCoordinates = [];

  late Timer timer;

  double _rating = 3;

  @override
  void initState() {
    _start();
    if (widget.code.isNotEmpty && _orderDetailsController.orders.isNotEmpty) {
      timer =
          Timer.periodic(Duration(seconds: 5), (Timer t) => _onMapCreated());
    }

    _onMapCreated();

    _onMapCreated();

    super.initState();
  }

  _start() async {
    await controller.get_rating(4);
    _rating = double.parse(controller.driver.value!.averageRating);
    await _orderDetailsController.getProducrtDetails(int.parse(widget.code));
    _markers.add(Marker(
      infoWindow:
          InfoWindow(title: _orderDetailsController.addres.city, snippet: ''),
      markerId: MarkerId('1111'),
      position: LatLng(double.parse(_orderDetailsController.addres.lat),
          double.parse(_orderDetailsController.addres.lang)),
    ));
    polylineCoordinates.add(LatLng(
        double.parse(_orderDetailsController.addres.lat),
        double.parse(_orderDetailsController.addres.lang)));
  }

  void _onMapCreated() async {
    var check =
        _orderDetailsController.orders.where((el) => el.id == widget.code);

    if (_orderDetailsController.orders.isNotEmpty && check.isNotEmpty) {
      final ByteData bytes =
          await rootBundle.load('assets/images/map_logo.png');
      final Uint8List list = bytes.buffer.asUint8List();

      _markers.add(Marker(
        //add distination location marker
        markerId: MarkerId('222'),
        position: check.first.location, //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: check.first.name,
        ),
        //  icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        icon: BitmapDescriptor.fromBytes(list),
      ));

      polylineCoordinates.add(check.first.location);
      _polyline.add(Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        //latlng is List<LatLng>
        points: polylineCoordinates,
        width: 2,
        color: Colors.blue,
      ));

      setState(() {});
    }
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
        title: Text('الخريطة'),
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

              markers: Set<Marker>.of(_markers),
              polylines: _polyline,
            ),
          ),
          Positioned(
            bottom: 5,
            child: Container(
              height: 450,
              width: Get.width,
              // margin: EdgeInsets.only(bottom: 300),
              padding: EdgeInsets.only(left: 15, right: 15),

              // color: Colors.deepOrangeAccent,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    // bottomLeft: Radius.circular(40),
                    // bottomRight: Radius.circular(40),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'الوقت المتوقع للتوصيل',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    TextUtils(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        text: controller.orderStatusItemList
                            .firstWhere((el) => el.id == int.parse(widget.code))
                            .remaing),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'يتم تحضير طلبك',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Card(
                      elevation: 15,
                      surfaceTintColor: Colors.transparent,
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(
                          Icons.person_pin,
                          color: Colors.black,
                          size: 50,
                        ),
                        trailing: IconButton(
                            onPressed: () => launchUrlString(
                                "tel://" + controller.driver.value!.phone),
                            icon: Icon(Icons.phone, color: Colors.green)),
                        title: Text(controller.orderStatusItemList
                            .firstWhere((el) => el.id == int.parse(widget.code))
                            .representativeName),
                        subtitle: RatingBarIndicator(
                          rating: _rating,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 25.0,
                          direction: Axis.horizontal,
                        ),
                        onTap: () => Selete_drivery(context),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      leading: Image.asset(
                          'assets/images/WhatsApp Image 2023-12-22 at 12.49.01 PM.jpeg'),
                      title: Text(
                        'SAM',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '2023-12-22',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 0, left: 15, right: 15),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          _orderDetailsController.orderDetailsList.length,
                      itemBuilder: (context, index) {
                        return Text(
                          _orderDetailsController
                                  .orderDetailsList[index].quantity
                                  .toString() +
                              '  ' +
                              _orderDetailsController
                                  .orderDetailsList[index].name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                    //   child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         PricesWidget(
                    //           textColor: Colors.black,
                    //           priceColor: Colors.black,
                    //           text: 'تكلفة الطلبات'.tr,
                    //           price: '${_orderDetailsController.total} د.ع',
                    //         ),
                    //         PricesWidget(
                    //           textColor: Colors.black,
                    //           priceColor: Colors.black,
                    //           text: 'تكلفة التوصيل'.tr,
                    //           price:
                    //               '${_orderDetailsController.costDelivery} د.ع',
                    //         ),
                    //         const SizedBox(
                    //           height: 7,
                    //         ),
                    //         const Divider(color: Colors.black, height: 1),
                    //         PricesWidget(
                    //           textColor: Colors.black,
                    //           priceColor: Colors.black,
                    //           text: 'المجموع '.tr,
                    //           price: '${_orderDetailsController.first} د.ع',
                    //         ),
                    //       ]),
                    // ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
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

  Selete_drivery(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              width: Get.width,
              color: Colors.white,
              height: 450,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  Icon(
                    Icons.person_pin,
                    color: Colors.black,
                    size: 100,
                  ),
                  Text(
                    controller.orderStatusItemList
                        .firstWhere((el) => el.id == int.parse(widget.code))
                        .representativeName,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            controller.driver.value!.numberOfOrders.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'تقييم',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                _rating.toString(),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
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
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            1.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                            controller
                                .driver.value!.ratingsPerCategory.first.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                            controller
                                .driver.value!.ratingsPerCategory.last.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
              ));
        });
  }
}
