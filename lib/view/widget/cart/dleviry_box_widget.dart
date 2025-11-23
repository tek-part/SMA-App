import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../logic/controller/check_out_controller.dart';
import '../../../logic/controller/location_controller.dart';
import '../../../utils/them.dart';
import '../../screen/setting/add_location_screen.dart';
import '../text_utils.dart';
import 'choose_delivery_widget.dart';

class DleviryBoxWidgt extends StatefulWidget {
  const DleviryBoxWidgt({super.key});

  @override
  State<DleviryBoxWidgt> createState() => _DleviryBoxWidgtState();
}

class _DleviryBoxWidgtState extends State<DleviryBoxWidgt> {
  CheckOutController controller = Get.put(CheckOutController());
  LocationController locationController = Get.put(LocationController());
  String location = 'اختر عنوانك'.tr;

  @override
  void initState() {
    location;
    controller.phone.text = controller.checkOutPageList[0].phone;
    _start();
    super.initState();
  }

  _start() async {
    await locationController.getLocationItem();
    if (locationController.locationItemList.isNotEmpty) {
      controller.location_id = locationController.locationItemList.first.id;
      controller.location =
          '${locationController.locationItemList.first.city} , ${locationController.locationItemList.first.street}';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = locationController.locationItemList;
    int? dropdownValue;
    if (items.isNotEmpty) {
      if (!items.any((item) => item.id == controller.location_id)) {
        dropdownValue = items.first.id;
        controller.location_id = dropdownValue!;
      } else {
        dropdownValue = controller.location_id;
      }
    } else {
      dropdownValue = null;
    }
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 15.h),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Color(0x4C7785DB)),
          borderRadius: BorderRadius.circular(4.r),
        ),
        shadows: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 1,
            offset: Offset(0.50, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextUtils(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              text: 'تحديد موقع الاستلام'.tr),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: GetBuilder<LocationController>(
                  builder: (_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 6.0.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(8.0.r),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x7FCED5E1),
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                )
                              ], // Border radius
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: dropdownValue,
                                items: items
                                    .map((location) {
                                  return DropdownMenuItem<int>(
                                    value: location.id,
                                    child: Text(
                                      '${location.city}, ${location.street}',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    controller.location_id = newValue;
                                    controller.location =
                                        '${items.firstWhere((l) => l.id == newValue).city}, ${items.firstWhere((l) => l.id == newValue).street}';
                                    setState(() {});
                                  }
                                },
                                isExpanded: true,
                                // Make the dropdown expand to fill the container
                                icon: const Icon(Icons
                                    .arrow_drop_down), // Custom dropdown icon
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsetsDirectional.all(10.w),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => AddLocationScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0.r),
                        side: const BorderSide(
                          color: mainColor,
                          width: 2.0,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0.w, vertical: 12.0.h),
                    ),
                    child: const Center(child: Icon(Icons.add)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            margin: EdgeInsetsDirectional.symmetric(vertical: 6.h),
            child: const Divider(color: mainColor, thickness: 2),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextUtils(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF3F3B3C),
                      text: 'مبلغ التوصيل'.tr,
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/images/dlevry.svg',
                      height: 50.h,
                      width: 50.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            // child: TextUtils(
            //   fontSize: 18,
            //   fontWeight: FontWeight.w600,
            //   color: const Color(0xFF3F3B3C),
            //   text: '${controller.checkOutPageList[0].deliveryCost} د.ع',
            // ),
          ),
          SizedBox(height: 16.h),
          GetBuilder<CheckOutController>(
            builder: (_) {
              return ChooseDeliveryWidget(
                immage: SvgPicture.asset('assets/images/phoooone.svg'),
                text1: 'رقم الموبايل'.tr,
                text2: "${controller.checkOutPageList[0].phone}+",
              );
            },
          ),
        ],
      ),
    );
  }
}
