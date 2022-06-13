import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgan_shop/utils/themes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../logic/controllers/cart_controller.dart';
import '../screens/cart_screen.dart';

class ImageSliderWidget extends StatefulWidget {
  final String imageUrl;
  const ImageSliderWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  final CarouselController carouselController = CarouselController();
  final cartController = Get.find<CartController>();
  int activeIndex = 0;
  List<Color> colorSelected = [
    kCOlor1,
    kCOlor2,
    kCOlor3,
    kCOlor4,
    kCOlor5,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: 4,
            carouselController: carouselController,
            options: CarouselOptions(
              onPageChanged: (index, _) {
                setState(() {
                  activeIndex = index;
                });
              },
              autoPlay: false,
              height: Get.height * .6,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 2),
            ),
            itemBuilder: (context, index, i) {
              return Padding(
                padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: 4,
                effect: ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Get.isDarkMode ? pinkClr : mainColor,
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 30,
            child: Container(
              height: 250,
              width: 55,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.4),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 3,
                ),
                itemCount: colorSelected.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorSelected[index],
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 20,
            child: InkWell(
              onTap: () => Get.back(),
              child: CircleAvatar(
                backgroundColor: Get.isDarkMode ? pinkClr : mainColor,
                radius: 24,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 22,
                    color: Get.isDarkMode ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 20,
            child: Obx(() {
              return CircleAvatar(
                backgroundColor: Get.isDarkMode ? pinkClr : mainColor,
                radius: 24,
                child: _shoppingCartBadge(),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _shoppingCartBadge() {
    return Badge(
      position: BadgePosition.topEnd(top: -10, end: -10),
      animationDuration: const Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeContent: Text(
        cartController.productMap.isEmpty
            ? "0"
            : cartController.quantity().toString(),
        style: const TextStyle(color: Colors.white),
      ),
      child: IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Get.isDarkMode ? Colors.black : Colors.white,
            size: 35,
          ),
          onPressed: () {
            Get.to(() => CartScreen());
          }),
    );
  }
}
