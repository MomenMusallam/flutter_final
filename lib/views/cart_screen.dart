import 'package:eekie/components/component.dart';
import 'package:eekie/model/product_model.dart';
import 'package:eekie/style/colors.dart';
import 'package:eekie/views/product_details.dart';
import 'package:flutter/material.dart';
import 'package:eekie/provider/product_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context, listen: true);

    return Scaffold(
      body: productProvider.carts.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ListView.separated(
                    itemBuilder: (context, index) {
                      return productCartItem(
                        context: context,
                        index: index,
                        product: productProvider.carts[index],
                        productProvider: productProvider,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 0),
                    itemCount: productProvider.carts.length,
                  ),
                  primaryButton(
                    function: () {},
                    text: "PROCEED TO PAYMENT",
                    context: context,
                  ),
                ],
              ),
            )
          : const Center(
              child: Image(image: AssetImage("assets/images/cart_empty.png"))),
    );
  }

  Widget productCartItem(
      {required ProductModel product,
      required int index,
      required ProductProvider productProvider,
      required BuildContext context}) {
    return InkWell(
      onTap: () {
        push(
            context: context,
            page: ProductDetailsScreen(productModel: product));
      },
      child: SizedBox(
        height: 140,
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Image(
                    image: NetworkImage(product.image.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          product.name.toString(),
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 12),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: const Icon(Icons.add),
                            ),
                            const SizedBox(width: 10),
                            const Text("1"),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                productProvider.deleteProductFromCart(
                                    productId: product.id!);
                              },
                              child: const Icon(Icons.remove),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${product.currentPrice} EGN",
                          style: const TextStyle(
                            fontSize: 14,
                            color: actionColor,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            productProvider.deleteProductFromCart(
                                productId: product.id.toString());
                          },
                          child: const Icon(Icons.delete_outline),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
