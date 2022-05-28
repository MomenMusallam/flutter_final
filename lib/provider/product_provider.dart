import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eekie/components/component.dart';
import 'package:eekie/components/constance.dart';
import 'package:eekie/local/cache_helper.dart';
import 'package:eekie/model/category_model.dart';
import 'package:eekie/model/product_model.dart';
import 'package:eekie/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'auth_service.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseFirestore store = FirebaseFirestore.instance;

  List<ProductModel> get offers => _offers;

  List<ProductModel> get products => _products;

  ProductModel? get productModel => _productModel;

  List<ProductModel> get favorites => _favorites;

  List<ProductModel> get carts => _carts;

  ProductModel? get favoriteModel => _favoriteModel;

  ProductModel? get cartModel => _cartModel;

  ProductModel? get offerModel => _offerModel;

  List<String>? get productsId => _productsId;
  List<String>? get productsOffersId => _productsOffersId;

  List<String>? get productsInCart => _productsInCart;

  List<ProductModel> _offers = [];
  List<ProductModel> _products = [];
  List<ProductModel> _favorites = [];
  List<ProductModel> _carts = [];
  ProductModel? _productModel;
  ProductModel? _favoriteModel;
  ProductModel? _cartModel;
  ProductModel? _offerModel;

  void getProductsByCategories({required String categoryId}) {
    store
        .collection("products")
        .where("categoryId", isEqualTo: categoryId)
        .snapshots()
        .listen((value) {
      _products = [];
      for (var element in value.docs) {
        var productModel = ProductModel.fromJson(element.data());
        _productModel = productModel;
        _products.add(_productModel!);
      }
      notifyListeners();
    });
  }

  void getOffers() {
    store
        .collection("products")
        .where("discount", isGreaterThanOrEqualTo: 1)
        .orderBy("discount")
        .snapshots()
        .listen(
      (event) {
        _productsOffersId = [];
        _offers = [];
        for (var element in event.docs) {
          _productsOffersId.add(element.data()['id']);
        }
        for (var element in _productsOffersId) {
          store
              .collection("products")
              .where("id", isEqualTo: element)
              .snapshots()
              .listen((event) {
            for (var e in event.docs) {
              _offerModel = ProductModel.fromJson(e.data());
                _offers.add(_offerModel!);
            }
          });
        }
        notifyListeners();
      },
    );
  }

  void insertNewProduct({
    String? categoryId,
    String? id,
    String? name,
    int? rate,
    String? image,
    double? currentPrice,
    double? oldPrice,
    String? description,
    String? timeDiscount,
    String? collection,
    int? discount,
    List<String>? colors,
    List<String>? sizes,
  }) {
    ProductModel model = ProductModel(
      id: id,
      categoryId: categoryId,
      name: name,
      rate: rate,
      currentPrice: currentPrice,
      oldPrice: oldPrice,
      image: image,
      description: description,
      discount: discount,
      colors: colors,
      sizes: sizes,
    );
    store.collection("products").add(model.toMap());
  }

  List<String> _productsId = [];
  List<String> _productsOffersId = [];

 // String currentUserId = uId;

  String? currentUserId =FirebaseAuth.instance.currentUser!.uid;


  void addCategory({required String categoryId, required String categoryName}) {

    CategoryModel categoryModel = CategoryModel(
      id: categoryId,
      title: categoryName,
    );
    store.collection("categories").add(categoryModel.toMap());
  }

  void addProductToFavorite({required String productId}) {
    store
        .collection("users")
        .doc(currentUserId)
        .collection("favorite")
        .add({"id": productId});
  }

  void deleteProductFromFavorite({required String productId}) async {
    store
        .collection("users")
        .doc(currentUserId)
        .collection("favorite")
        .where("id", isEqualTo: productId)
        .get()
        .then((event) {
      event.docs[0].reference.delete();
    });
  }

  List<String> _productsInCart = [];

  void getCart() {
    store
        .collection("users")
        .doc(currentUserId)
        .collection("cart")
        .snapshots()
        .listen(
      (event) {
        _productsInCart = [];
        _carts = [];
        for (var element in event.docs) {
          _productsInCart.add(element.data()['id']);
        }
        for (var element in _productsInCart) {
          store
              .collection("products")
              .where("id", isEqualTo: element)
              .snapshots()
              .listen((event) {
            for (var element in event.docs) {
              _cartModel = ProductModel.fromJson(element.data());
              _carts.add(_cartModel!);
            }
          });
        }
        notifyListeners();
      },
    );
  }

  void addProductToCart({required String productId}) {
    store
        .collection("users")
        .doc(currentUserId)
        .collection("cart")
        .add({"id": productId});
  }

  void deleteProductFromCart({required String productId}) async {
    store
        .collection("users")
        .doc(currentUserId)
        .collection("cart")
        .where("id", isEqualTo: productId)
        .get()
        .then((event) {
      event.docs[0].reference.delete();
    });
  }

  void checkIsCart({required String productId}) {
    var isCart = _productsInCart.contains(productId);
    switch (isCart) {
      case true:
        deleteProductFromCart(productId: productId);
        break;
      case false:
        addProductToCart(productId: productId);
        break;
    }
  }

  void getFavorites() {
    store
        .collection("users")
        .doc(currentUserId)
        .collection("favorite")
        .snapshots()
        .listen(
      (event) {
        _productsId = [];
        _favorites = [];
        for (var element in event.docs) {
          _productsId.add(element.data()['id']);
        }
        for (var element in _productsId) {
          store
              .collection("products")
              .where("id", isEqualTo: element)
              .snapshots()
              .listen((event) {
            for (var element in event.docs) {
              _favoriteModel = ProductModel.fromJson(element.data());
              _favorites.add(_favoriteModel!);
            }
          });
        }
        notifyListeners();
      },
    );
  }

  void checkIsFavorite({required String productId}) {
    var isFavorite = _productsId.contains(productId);
    switch (isFavorite) {
      case true:
        deleteProductFromFavorite(productId: productId);
        break;
      case false:
        addProductToFavorite(productId: productId);
        break;
    }
  }
}
