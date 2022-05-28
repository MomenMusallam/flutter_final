import 'package:eekie/model/category_model.dart';
import 'package:eekie/model/product_model.dart';
import 'package:eekie/provider/product_provider.dart';
import 'package:eekie/style/colors.dart';
import 'package:eekie/views/product_details.dart';
import 'package:eekie/views/products_of_category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

Widget textInputField(
    {required TextEditingController controller,
    required TextInputType keyboard,
    required String hintText,
    IconData? suffixIcon,
    Function? suffixIconPressed,
    required context,
    Function? onSubmit,
    String? Function(String?)? validator,
    bool description = false}) {
  return SizedBox(
    height: 60,
    child: TextFormField(
      controller: controller,
      keyboardType: keyboard,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: () => suffixIconPressed!(),
                )
              : null),
      validator: validator,
    ),
  );
}

Widget primaryButton({
  required Function function,
  required String text,
  required BuildContext context,
  Color color = actionColor,
  Color textColor = Colors.white,
  double width = double.infinity,
}) {
  return Container(
    height: 60,
    decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(5.0))),
    child: MaterialButton(
      minWidth: width,
      onPressed: () => function(),
      child: Center(
        child: Text(text, style: TextStyle(color: textColor)),
      ),
    ),
  );
}

Future<dynamic> push({required BuildContext context, required Widget page}) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

Future<dynamic> pushAndRemove(
    {required BuildContext context, required Widget page}) {
  return Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => page), (route) {
    return false;
  });
}

void toastMessage({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      fontSize: 14.0);
}

Widget categoryItem({
  required CategoryModel categoryModel,
  required int index,
  required BuildContext context,
}) {
  List colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.teal,
    Colors.blueAccent,
    Colors.amber,
    Colors.lightGreen,
    Colors.orange,
    Colors.teal,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.teal,
    Colors.blueAccent,
    Colors.amber,
    Colors.lightGreen,
    Colors.orange,
    Colors.teal,
  ];

  return InkWell(
    onTap: () {
      push(
          context: context,
          page: ProductsOfCategoryScreen(categoryModel: categoryModel));
    },
    child: Container(
      width: 110,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: colors[index],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.category_outlined,
            color: Colors.white,
            size: 40.0,
          ),
          const SizedBox(height: 10),
          Text(
            categoryModel.title.toString(),
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

Widget logo() {
  return const Center(
    child: Image(
      image: AssetImage("assets/images/logo.png"),
      width: 200,
    ),
  );
}


Widget offerProductItem({
  required ProductModel product,
  required int index,
  required BuildContext context,
}) {
  return InkWell(
    onTap: () {
      push(context: context, page:  ProductDetailsScreen(productModel: product));
    },
    child: SizedBox(
      width: 150,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: NetworkImage(product.image.toString()),
                    height: 100,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 10),
                  Text(product.name.toString(),
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Text(
                        "${product.currentPrice.toString()} EGN",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: actionColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${product.oldPrice.toString()} EGN",
                        style: const TextStyle(
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough),
                      ),

                    ],
                  ),
                  const Spacer(),
                  Text(product.timeDiscount.toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 40,
            width:50,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(3.0),
            ),
            child:  Center(
              child: Text(
                "${product.discount.toString()}%",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget cartIcon(context) {
  var productProvider = Provider.of<ProductProvider>(context, listen: true);

  return Stack(
    alignment: Alignment.topLeft,
    children: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.shopping_cart_outlined),
      ),
     if(productProvider.productsInCart!.isNotEmpty )
     Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child:  Center(
          child: Text(
            productProvider.productsInCart!.length.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
}

Widget productItem(
    {required ProductModel product,
    required ProductProvider productProvider,
    required BuildContext context}) {
  return InkWell(
    onTap: () {
      push(context: context, page:  ProductDetailsScreen(productModel: product));
    },
    child: SizedBox(
      width: 150,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: NetworkImage(product.image.toString()),
                    height: 120,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.name.toString(),
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        "${product.currentPrice} EGN",
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: actionColor),
                      ),
                      const SizedBox(width: 10),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          productProvider.checkIsFavorite(
                            productId: product.id!,
                          );
                        },
                        child: Icon(
                          productProvider.productsId!.contains(product.id) ==
                                  true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: actionColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: RatingBar.builder(
              initialRating: product.rate!.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 24,
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
          ),
        ],
      ),
    ),
  );
}
