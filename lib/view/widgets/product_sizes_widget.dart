import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:morgan_shop/utils/themes.dart';
import 'package:morgan_shop/view/widgets/text_widget.dart';

class ProductSizesWidget extends StatefulWidget {
  const ProductSizesWidget({Key? key}) : super(key: key);

  @override
  State<ProductSizesWidget> createState() => _ProductSizesWidgetState();
}

class _ProductSizesWidgetState extends State<ProductSizesWidget> {
  List sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  int currentSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      child: Center(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  currentSelected = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                height: 60,
                // width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: currentSelected != index
                      ? Border.all(color: Colors.grey)
                      : Border.all(
                          style: BorderStyle.none,
                        ),
                  color: currentSelected == index
                      ? Get.isDarkMode
                          ? Colors.black
                          : mainColor.withOpacity(.7)
                      : Colors.transparent,
                ),
                child: Center(
                  child: TextWidget(
                    text: sizes[index],
                    fontWeight: FontWeight.bold,
                    color:
                        currentSelected != index ? Colors.grey : Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            width: 10,
          ),
          itemCount: sizes.length,
        ),
      ),
    );
  }
}
