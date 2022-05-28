import 'package:eekie/components/component.dart';
import 'package:eekie/provider/category_provider.dart';
import 'package:eekie/provider/product_provider.dart';
import 'package:eekie/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<CategoryProvider>(context, listen: true);
    var productProvider = Provider.of<ProductProvider>(context, listen: true);

    TextStyle style1 = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: Colors.black87,
    );
    TextStyle style2 = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: actionColor,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 200.0,
              width: double.infinity,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://i.pinimg.com/736x/e7/f7/1c/e7f71ce97c56ea47bc78e294a5ab3f3c.jpg"),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Categories".toUpperCase(),
                        style: style1,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          productProvider.insertNewProduct(
                            categoryId: "1",
                            id: "1",
                            name: "Nike Shoes",
                            rate: 4,
                            currentPrice: 100,
                            oldPrice: 200,
                            image:
                                "https://freepngimg.com/thumb/categories/627.png",
                            description:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                            discount: 100,
                            colors: [
                              "#55efc4",
                              "#22a6b3",
                              "#30336b",
                              "#6ab04c"
                            ],
                            timeDiscount: "2 day",
                            collection: "offers",
                            sizes: ["S", "M", "L", "XL", "XXL"],
                          );
                          productProvider.insertNewProduct(
                            categoryId: "1",
                            id: "3",
                            name: "Blue Sneaker",
                            rate: 5,
                            currentPrice: 55,
                            oldPrice: 0,
                            image: "https://www.pngitem.com/pimgs/m/114-1149906_sneakers-skate-shoe-nike-one-transparent-background-png.png",
                            description:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                            discount: 0,
                            colors: [
                              "#0984e3",
                              "#00b894",
                              "#f0932b",
                            ],
                            sizes: ["S", "M", "L"],
                          );
                          productProvider.insertNewProduct(
                            categoryId: "1",
                            id: "2",
                            name: "Orange Sneaker",
                            rate: 5,
                            currentPrice: 70,
                            oldPrice: 100,
                            timeDiscount: "2 day",
                            collection: "offers",
                            image:
                                "https://pics.clipartpng.com/Orange_Sneakers_PNG_Clipart-391.png",
                            description:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                            discount: 30,
                            colors: [
                              "#0984e3",
                              "#d63031",
                              "#fdcb6e",
                              "#00b894",
                              "#f0932b",
                            ],
                            sizes: ["L", "XL", "XXL"],
                          );
                          productProvider.insertNewProduct(
                            categoryId: "2",
                            id: "6",
                            name: "iPhone 11 Pro Max",
                            rate: 5,
                            currentPrice: 70,
                            oldPrice: 100,
                            timeDiscount: "1 day",
                            image:
                            "https://m.media-amazon.com/images/I/41ZjUOH6nRL._AC_.jpg",
                            description:
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                            discount: 30,
                            colors: [
                              "#FFFFFF",
                              "#000000",
                            ],
                            sizes: [],
                          );
                        },
                        child: Text(
                          "See all".toUpperCase(),
                          style: style2,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 110.0,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return categoryItem(
                          context: context,
                          categoryModel: categoryProvider.list[index],
                          index: index,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 10);
                      },
                      itemCount: categoryProvider.list.length,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Offers".toUpperCase(),
                        style: style1,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          productProvider.addCategory(
                            categoryId: "1",
                            categoryName: "Shoes",
                          );
                          productProvider.addCategory(
                            categoryId: "2",
                            categoryName: "Phones",
                          );
                          productProvider.addCategory(
                            categoryId: "3",
                            categoryName: "Clothes",
                          );
                          productProvider.addCategory(
                            categoryId: "4",
                            categoryName: "PC",
                          );
                          productProvider.addCategory(
                            categoryId: "5",
                            categoryName: "Screens",
                          );
                          productProvider.addCategory(
                            categoryId: "6",
                            categoryName: "Food",
                          );
                        },
                        child: Text(
                          "See all".toUpperCase(),
                          style: style2,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child:  GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 0.0,
                      childAspectRatio: 1 / 1.1,
                      children: List.generate(
                        productProvider.offers.length,
                            (index) => offerProductItem(
                          index: index,
                          product: productProvider.offers[index],
                          context: context,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
