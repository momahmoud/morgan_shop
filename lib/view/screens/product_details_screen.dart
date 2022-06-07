import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morgan_shop/model/product_model.dart';
import 'package:morgan_shop/view/widgets/image_slider_widget.dart';
import 'package:morgan_shop/view/widgets/product_detail_widget.dart';
import 'package:morgan_shop/view/widgets/product_sizes_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailsScreen({Key? key, required this.productModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ImageSliderWidget(imageUrl: productModel.image),
            ProductDetailWidget(
              title: productModel.title,
              id: productModel.id,
              rateCount: productModel.rating.rate,
              description: productModel.description,
            ),
            const ProductSizesWidget()
          ],
        ),
      ),
    );
  }
}
