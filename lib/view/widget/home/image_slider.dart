import 'package:bandora_app/logic/controller/slider_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Imagesliders extends StatefulWidget {
  const Imagesliders({super.key});

  @override
  State<Imagesliders> createState() => _ImageslidersState();
}

class _ImageslidersState extends State<Imagesliders> {
  final SliderController controller = Get.put(SliderController());
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.sliderList.isEmpty) {
        return const Center(child: Text("No images available"));
      } else {
        return CarouselSlider.builder(
          itemCount: controller.sliderList.length,
          options: CarouselOptions(
            height: 210,
            autoPlay: true,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            autoPlayInterval: const Duration(seconds: 2),
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currentPage = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return PhotoDetails(image: controller.sliderList[index].image);
          },
        );
      }
    });
  }

  Widget PhotoDetails({required String image}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
