import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/them.dart';
import '../../widget/order_widget/all_order.dart';
import '../../widget/order_widget/currnet_orders.dart';
import '../../widget/order_widget/pervious_order.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'طلباتي'.tr,
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
            ),
            body: Column(
              children: [
                TabBar(
                    physics: const BouncingScrollPhysics(),
                    indicatorColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(
                          child: Text(
                        'جميع الطلبات'.tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height / 65,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Cairo',
                        ),
                      )
                          // TextUtils(
                          //     fontSize:MediaQuery.of(context).size.height /65,
                          //     fontWeight: FontWeight.w600,
                          //     color: Colors.black,
                          //     text: 'جميع الطلبات'.tr),
                          ),
                      Tab(
                          child: Text(
                        'الطلبات الحالية'.tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height / 65,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Cairo',
                        ),
                      )
                          // TextUtils(
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w600,
                          //     color: Colors.black,
                          //     text: 'الطلبات الحالية'.tr),
                          ),
                      Tab(
                          child: Text(
                        'الطلبات السابقة'.tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.height / 65,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Cairo',
                        ),
                      )
                          //  TextUtils(
                          //     fontSize: 13,
                          //     fontWeight: FontWeight.w600,
                          //     color: Colors.black,
                          //     text: 'الطلبات السابقة'.tr),
                          ),
                    ]),
                Expanded(
                  child: TabBarView(children: [
                    AllOrderWidget(),
                    CurrentOrderWidget(),
                    PreviousOrderWidget(),
                  ]),
                ),
              ],
            )));
  }
}
