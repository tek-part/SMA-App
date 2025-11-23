import 'dart:async';

import 'package:bandora_app/logic/controller/location_controller.dart';
import 'package:bandora_app/logic/controller/profile_data_controller.dart';
import 'package:bandora_app/utils/them.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.id});

  final int id;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng cl = LatLng(33.307492, 44.369771); // Default to Baghdad coordinates

  List<Marker> _markers = [];
  ProfileDataController _user = Get.put(ProfileDataController());

  LocationController controller_location = Get.put(LocationController());

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.307492, 44.369771),
    zoom: 12.4746,
  );
  GoogleMapController? gmc;

  @override
  void initState() {
    Permision();
    getLatAndLang();

    if (controller_location.latlatPostition.latitude != 0) {
      _markers.add(Marker(
        infoWindow: InfoWindow(
            title:
                '${_user.productCategoryList[0].firstName} ${_user.productCategoryList[0].lastName}',
            snippet: '222'),
        markerId: MarkerId('+${_user.productCategoryList[0].phone}'),
        position: controller_location.latlatPostition,
      ));
    }
    super.initState();
  }

  @override
  void dispose() {
    // controller_location.latlatPostition = new LatLng(0,0) ;
    _markers.clear();
    super.dispose();
  }

  _baseDialog(LatLng position) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text('save'.tr),
        surfaceTintColor: Colors.transparent,
        content: Text('Save_new_home'.tr),
        actions: <Widget>[
          new TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pop(false); // dismisses only the dialog and returns false
            },
            child: Text('cancel'.tr),
          ),
          TextButton(
            onPressed: () async {
              _markers.add(Marker(
                infoWindow: InfoWindow(
                    title:
                        '${_user.productCategoryList[0].firstName} ${_user.productCategoryList[0].lastName}',
                    snippet: '222'),
                markerId: MarkerId('+${_user.productCategoryList[0].phone}'),
                position: position,
              ));

              controller_location.latlatPostition = position;

              try {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                    position.latitude, position.longitude);
                
                if (placemarks.isNotEmpty) {
                  Placemark place = placemarks[0];
                  var _currentAddress1 = "${place.thoroughfare}"; // شارع
                  var _currentAddress2 = "${place.locality}"; // منطقة
                  
                  // إذا كانت العناوين فارغة، استخدم معلومات إضافية
                  if (_currentAddress1.isEmpty && _currentAddress2.isEmpty) {
                    _currentAddress1 = "${place.street}";
                    _currentAddress2 = "${place.administrativeArea}";
                  }
                  
                  // إذا كانت لا تزال فارغة، استخدم اسم البلد
                  if (_currentAddress1.isEmpty && _currentAddress2.isEmpty) {
                    _currentAddress2 = "${place.country}";
                  }

                  if (widget.id != 0 && (_currentAddress1.isNotEmpty || _currentAddress2.isNotEmpty)) {
                    controller_location.updateSecondLocation.text =
                        _currentAddress2 + '  ' + _currentAddress1;
                  } else if (widget.id == 0 && (_currentAddress1.isNotEmpty || _currentAddress2.isNotEmpty)) {
                    controller_location.secondLocation.text =
                        _currentAddress2 + '  ' + _currentAddress1;
                  }
                } else {
                  // إذا لم يتم العثور على عنوان، استخدم الإحداثيات
                  String coordinates = "${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}";
                  if (widget.id != 0) {
                    controller_location.updateSecondLocation.text = coordinates;
                  } else {
                    controller_location.secondLocation.text = coordinates;
                  }
                }
              } catch (e) {
                // في حالة حدوث خطأ في geocoding، استخدم الإحداثيات
                String coordinates = "${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}";
                if (widget.id != 0) {
                  controller_location.updateSecondLocation.text = coordinates;
                } else {
                  controller_location.secondLocation.text = coordinates;
                }
                print('Geocoding error: $e');
              }

              setState(() {});
              Navigator.of(context, rootNavigator: true).pop(false);
            },
            child: Text('ok'.tr),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'أضف عنوان'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            height: 0,
            letterSpacing: -0.30,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: mainColor,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.save,
                color: Colors.black,
              ))
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            rotateGesturesEnabled: true,
            tiltGesturesEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              gmc = controller;
              currentLocation(controller);
            },
            markers: Set<Marker>.of(_markers),
            onTap: (position) async {
              _baseDialog(position);

              setState(() {});
            },
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black12,
                height: 100,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '-  ${'aLarm_map'.tr}  -',
                      style: GoogleFonts.getFont('Cairo',
                          color: Colors.deepOrange,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      'home_location'.tr,
                      style: GoogleFonts.getFont('Cairo',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // Future<LatLng> getLatAndLang() async {
  //   return await Geolocator.getCurrentPosition().then((value) =>   LatLng(value.latitude,value.latitude));
  // }

  getLatAndLang() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 10),
      );
      
      // التحقق من أن الإحداثيات صحيحة وليست قريبة من (0,0)
      if (position.latitude.abs() > 0.001 && position.longitude.abs() > 0.001) {
        cl = LatLng(position.latitude, position.longitude);
        if (gmc != null) {
          currentLocation(gmc);
        }
      } else {
        print('Invalid coordinates received: ${position.latitude}, ${position.longitude}');
        // استخدام الإحداثيات الافتراضية
        cl = LatLng(33.307492, 44.369771);
        if (gmc != null) {
          currentLocation(gmc);
        }
      }
    } catch (e) {
      print('Error getting location: $e');
      // في حالة الخطأ، استخدم الإحداثيات الافتراضية
      cl = LatLng(33.307492, 44.369771);
      if (gmc != null) {
        currentLocation(gmc);
      }
    }
  }

  Future getPosition() async {
    LocationPermission per;
    bool services;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      Get.defaultDialog(title: 'عذرا  ', middleText: 'قم بتشغيل خدمه الموقع');
    }
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
  }

  Future Permision() async {
    LocationPermission per;
    bool services;
    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      Get.defaultDialog(title: 'عذرا  ', middleText: 'قم بتشغيل خدمه الموقع');
    }
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    await getLatAndLang();
  }

  void currentLocation(mapController) async {
    if (mapController != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(cl.latitude, cl.longitude),
          zoom: 14.0,
        ),
      ));
    }
  }
}
