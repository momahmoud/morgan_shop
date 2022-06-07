import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morgan_shop/utils/themes.dart';

import 'package:morgan_shop/view/widgets/text_widget.dart';
import 'package:readmore/readmore.dart';

import '../../logic/controllers/product_controller.dart';

class ProductDetailWidget extends StatefulWidget {
  final String title;
  late final double? rateCount;
  final int id;
  final String description;
  // ignore: prefer_const_constructors_in_immutables
  ProductDetailWidget({
    Key? key,
    required this.title,
    required this.id,
    required this.rateCount,
    required this.description,
  }) : super(key: key);

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  final productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18, top: 18, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextWidget(
                  text: widget.title,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Obx(
                () {
                  return InkWell(
                    onTap: () {
                      productController.addProductToFavorites(widget.id);
                    },
                    child: CircleAvatar(
                      backgroundColor:
                          Get.isDarkMode ? Colors.white : Colors.black,
                      radius: 20,
                      child: Icon(
                        productController.toggleFavorites(widget.id)
                            ? CupertinoIcons.heart_solid
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: <Widget>[
              RatingStars(
                value: widget.rateCount!,
                onValueChanged: (v) {
                  //
                  setState(() {
                    widget.rateCount = v;
                  });
                },
                starBuilder: (index, color) => Icon(
                  Icons.star,
                  color: color,
                ),
                starCount: 5,
                starSize: 25,
                valueLabelColor: const Color(0xff9b9b9b),
                valueLabelTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0),
                valueLabelRadius: 10,
                maxValue: 5,
                starSpacing: 2,
                maxValueVisibility: true,
                valueLabelVisibility: true,
                animationDuration: const Duration(milliseconds: 1000),
                valueLabelPadding:
                    const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                valueLabelMargin: const EdgeInsets.only(right: 8),
                starOffColor: const Color(0xffe7e8ea),
                starColor: Colors.yellow,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ReadMoreText(
            widget.description,
            trimMode: TrimMode.Line,
            trimLines: 4,
            textAlign: TextAlign.justify,
            style: GoogleFonts.firaSans(
              color: Get.isDarkMode ? Colors.grey[300] : Colors.grey[800],
              fontSize: 16,
              height: 1.3,
            ),
            trimCollapsedText: 'Show More',
            trimExpandedText: 'Show Less',
            lessStyle: GoogleFonts.workSans(
              color: Get.isDarkMode ? pinkClr : mainColor,
              fontWeight: FontWeight.bold,
            ),
            moreStyle: GoogleFonts.workSans(
              color: Get.isDarkMode ? pinkClr : mainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
