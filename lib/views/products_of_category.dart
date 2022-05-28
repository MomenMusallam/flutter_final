import 'package:eekie/components/component.dart';
import 'package:eekie/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eekie/provider/product_provider.dart';

class ProductsOfCategoryScreen extends StatelessWidget {
  CategoryModel categoryModel;

  ProductsOfCategoryScreen({required this.categoryModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryModel.title.toString()),
      ),
      body: Builder(builder: (context) {
        productProvider.getProductsByCategories(
          categoryId: categoryModel.id!,
        );
        return productProvider.products.isNotEmpty
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
                          productProvider.products.length,
                          (index) => productItem(
                            context: context,
                            productProvider:productProvider,
                            product: productProvider.products[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: Image(
                    image: AssetImage("assets/images/product_empty.png")));
      }),
    );
  }
}
