import 'package:bandora_app/routes/routes.dart';
import 'package:bandora_app/view/screen/setting/add_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pinput/pinput.dart';

import '../../logic/controller/check_out_controller.dart';
import '../../logic/controller/location_controller.dart';
import '../../logic/controller/order_controller.dart';
import '../../logic/controller/order_status_controller.dart';
import '../../logic/controller/setting_controller.dart';
import '../../services/main_catogery_services.dart';
import '../../utils/my_strings.dart';
import '../../utils/them.dart';
import '../widget/button_utils.dart';
import '../widget/cart/cart_text_form_field_widget.dart';
import '../widget/cart/dleviry_box_widget.dart';
import '../widget/cart/pay_ment_method_widget.dart';
import '../widget/cart/summery_pay_ment.dart';
import '../widget/text_utils.dart';

// ignore: must_be_immutable
class CheckScreen extends StatefulWidget {
  CheckScreen({super.key});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  CheckOutController controller = Get.put(CheckOutController());

  OrderController orderController = Get.put(OrderController());

  OrderStatusController orderStatusController =
  Get.put(OrderStatusController());

  SettingController settingController = Get.put(SettingController());

  LocationController locationController = Get.put(LocationController());
  RxString location = 'اختر عنوانك'.tr.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _start();
    });
  }

  _start() async {
    await locationController.getLocationItem();
    if (locationController.locationItemList.isNotEmpty) {
      controller.location_id = locationController.locationItemList.first.id;
      controller.location =
      '${locationController.locationItemList.first.city} , ${locationController
          .locationItemList.first.street}';
      setState(() {});
    }
    
    // تأمين الوصول للقائمة
    if (controller.checkOutPageList.isNotEmpty) {
      controller.phone.text = controller.checkOutPageList[0].phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الطلب'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            height: 0,
            letterSpacing: -0.30,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp,color: Colors.black,), onPressed: () {
          Navigator.pop(context);
        },),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GetBuilder<CheckOutController>(
            builder: (_) {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextUtils(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        text: 'الرجاء إختيار طريقة الإستلام'.tr),
                    const DleviryBoxWidgt(),
                    TextUtils(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        text: 'هل تود أن نتصل بك علي رقم أخر'.tr),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Row(children: [
                        //الكود
                        Expanded(
                          child: Container(
                            decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: GreyClr,
                                ),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    bottomRight: Radius.circular(4)),
                              ),
                            ),
                            child: const Center(
                                child: TextUtils(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    text: '+964')),
                          ),
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          flex: 5,
                          child: CartTextFormField(
                              onsave: (v) {
                                controller.anotherPhone.text = v!;
                              },
                              keyboardType: TextInputType.phone,
                              controller: controller.anotherPhone,
                              validator: (value) {},
                              hintText: '7XX XXX XXXX'.tr),
                        )
                      ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextUtils(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        text: 'هل لديك كوبون خصم'.tr),
                    const SizedBox(
                      height: 10,
                    ),
                    //cobon
                    SizedBox(
                        width: double.infinity,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 15,
                        child: Stack(
                          children: [
                            CartTextFormField(
                                onsave: (v) {
                                  controller.cobon.text = v!;
                                },
                                keyboardType: TextInputType.name,
                                controller: controller.cobon,
                                validator: (value) {
                                  controller.validateName(value);
                                },
                                hintText: 'مثال: PI6EV7JTDW'.tr),
                            PositionedDirectional(
                              end: 0,
                              child: TextButton(
                                  onPressed: () {
                                    controller.checkConbon();
                                  },
                                  child: TextUtils(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: mainColor,
                                      text: 'تحقق'.tr)),
                            )
                          ],
                        )),
                    //PayMent
                    const SizedBox(
                      height: 10,
                    ),
                    //paument
                    PayMentMetohodWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    //ملخص الدفع
                    SummeryPayMent(),

                    //buttons
                    const SizedBox(
                      height: 20,
                    ),

                    //buttons

                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          CheckOutDetailsServices.getProduct();
                          Get.toNamed(Routes.checkOutDetailsScreen);
                        },
                        child: TextUtils(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: mainColor,
                            text: 'مراجعة الطلب'.tr),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ButtonUtils(
                          text: 'إطلب'.tr,
                          onPressed: () async {
                            print('=== DEBUG START ===');
                            print('location: \'${controller.location}\'');
                            print('location_id: ${controller.location_id}');
                            print('condition check: ${controller.location == 'اختر عنوانك'} || ${controller.location_id == 0}');
                            
                            if (controller.location == 'اختر عنوانك' || controller.location_id == 0) {
                              print('Entering condition: location is default or location_id is 0');
                              // جلب العناوين أولاً
                              await locationController.getLocationItem();
                              print('Location items count: ${locationController.locationItemList.length}');
                              
                              // إذا كان هناك عناوين، اختر أول واحد تلقائياً
                              if (locationController.locationItemList.isNotEmpty) {
                                print('Selecting first location automatically');
                                controller.location_id = locationController.locationItemList.first.id;
                                controller.location = '${locationController.locationItemList.first.city} , ${locationController.locationItemList.first.street}';
                                controller.update();
                                print('Updated location_id: ${controller.location_id}');
                                print('Updated location: ${controller.location}');
                                
                                // الآن ارفع الطلب مباشرة
                                print('Calling checkOut...');
                                controller.checkOut(controller.phone.text, context, settingController.langlocal == 'ar');
                              } else {
                                print('No locations found, showing dialog');
                                // إذا لم تكن هناك عناوين، أظهر رسالة إضافة عنوان
                                Get.defaultDialog(
                                  backgroundColor: Colors.white,
                                  title: '',
                                  titlePadding: const EdgeInsets.all(0),
                                  titleStyle: const TextStyle(height: 0, letterSpacing: -0.30),
                                  middleText: 'الرجاء إضافة عنوان'.tr,
                                );
                              }
                            } else {
                              print('Location already selected, calling checkOut directly');
                              controller.checkOut(controller.phone.text, context, settingController.langlocal == 'ar');
                            }
                            print('=== DEBUG END ===');
                          },
                          colorstext: Colors.black,
                          background: mainColor),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
