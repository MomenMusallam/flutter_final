import 'package:eekie/components/component.dart';
import 'package:eekie/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context, listen: true);

    return productProvider.favorites.isNotEmpty
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 1 / 1.1,
                    children: List.generate(
                      productProvider.favorites.length,
                      (index) => productItem(
                        context: context,
                        productProvider: productProvider,
                        product: productProvider.favorites[index],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center(
            child:
                Image(image: AssetImage("assets/images/favorite_empty.png")));
  }
}
