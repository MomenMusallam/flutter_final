import 'dart:ui';

import 'package:eekie/model/product_model.dart';
import 'package:eekie/provider/product_provider.dart';
import 'package:eekie/style/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../components/component.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductModel productModel;

  ProductDetailsScreen({required this.productModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        actions: [
          cartIcon(context),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      productProvider.checkIsFavorite(
                        productId: productModel.id!,
                      );
                    },
                    child: Icon(
                      productProvider.productsId!.contains(productModel.id) ==
                          true
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: actionColor,
                      size: 30,
                    ),
                  ),
                  const Spacer(),
                  RatingBar.builder(
                    initialRating: productModel.rate!.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      if (kDebugMode) {
                        print(rating);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                productModel.name!.toUpperCase(),
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Image(
                image: NetworkImage(productModel.image!),
                height: 200,
                width: double.infinity,
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${productModel.currentPrice} EGN",
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: actionColor),
                          ),
                          const Spacer(),
                          Text(
                            productModel.oldPrice!.toDouble() > 0
                                ? "${productModel.oldPrice} EGN"
                                : "",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        productModel.description!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (productModel.colors!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("COLORS",
                                style: TextStyle(fontSize: 12)),
                            const SizedBox(height: 5),
                            colorWidget(),
                          ],
                        ),
                      const SizedBox(height: 20.0),
                      if (productModel.sizes!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("SIZES", style: TextStyle(fontSize: 12)),
                            const SizedBox(height: 5),
                            sizeWidget(),
                          ],
                        ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          const Text('QUINTITY',
                              style: TextStyle(fontSize: 12.0)),
                          const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add),
                              iconSize: 30.0,
                              color: actionColor),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("1"),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.remove),
                            iconSize: 30.0,
                            color: actionColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              productProvider.productsInCart!.contains(productModel.id!) ==
                      false
                  ? primaryButton(
                      function: () {
                        productProvider.addProductToCart(
                            productId: productModel.id!);
                      },
                      text: "ADD TO CART",
                      context: context,
                      color: actionColor)
                  : primaryButton(
                      function: () {
                        productProvider.deleteProductFromCart(
                            productId: productModel.id!);
                      },
                      text: "DELETE FROM CART",
                      context: context,
                      textColor: primaryColor,
                      color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }

  Widget colorWidget() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          height: 40,
          width: 60,
          decoration: BoxDecoration(
            color: Color(int.parse(
                "0xFF" + productModel.colors![index].replaceAll("#", ""))),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        itemCount: productModel.colors!.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }

  Widget sizeWidget() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          height: 40,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
              child: Text(
            productModel.sizes![index],
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
        itemCount: productModel.sizes!.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}
