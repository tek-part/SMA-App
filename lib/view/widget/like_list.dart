import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controller/childern_category.dart';
import '../../logic/controller/product_category_controller.dart';
import '../../utils/them.dart';

class LikeList extends StatefulWidget {
  const LikeList({super.key});

  @override
  State<LikeList> createState() => _LikeListState();
}

class _LikeListState extends State<LikeList> {
  var currentSelected = 0;
  bool _isInitialized = false;
  ChildrenCategory controller = Get.put(ChildrenCategory());
  ProductCatogeryController productCatogeryController =
      Get.put(ProductCatogeryController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized && controller.childrenCategoryList.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _initializeData();
      });
    }
  }

  void _initializeData() {
    if (controller.childrenCategoryList.isNotEmpty && !_isInitialized) {
      _isInitialized = true;
      
      // تنظيف القائمة إذا كانت تحتوي على منتجات
      if (productCatogeryController.productCategoryList.isNotEmpty) {
        productCatogeryController.clearList();
      }
      
      // تهيئة البيانات الجديدة
      productCatogeryController.page = 1;
      productCatogeryController.id =
          controller.childrenCategoryList[currentSelected].id;
      productCatogeryController.getProducrtDetails(
          controller.childrenCategoryList[currentSelected].id);
    }
  }

  void _onCategoryTap(int index) {
    if (currentSelected != index) {
      setState(() {
        currentSelected = index;
      });

      if (productCatogeryController.productCategoryList.isNotEmpty) {
        productCatogeryController.clearList();
      }
      
      productCatogeryController.id = controller.childrenCategoryList[index].id;
      productCatogeryController.getProducrtDetails(
          controller.childrenCategoryList[index].id);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView.builder(
            itemCount: controller.childrenCategoryList.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () => _onCategoryTap(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        color:
                            currentSelected == index ? mainColor : Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: GreyClr,
                          width: 0.5,
                        )),
                    child: Center(
                      child: Text(
                        controller.childrenCategoryList[index].name,
                        style: TextStyle(
                          color: currentSelected == index
                              ? Colors.white
                              : Colors.black,
                          fontSize: 14,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                          height: 0.06,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ));
    }
  }
}
