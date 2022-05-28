import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eekie/model/category_model.dart';
import 'package:flutter/foundation.dart';

class CategoryProvider with ChangeNotifier {
  final FirebaseFirestore store = FirebaseFirestore.instance;

  List<CategoryModel> get list => _category;

  CategoryModel? get categoryModel => _categoryModel;
   final List<CategoryModel> _category = [];
  CategoryModel? _categoryModel;

  void getCategories() {
    store.collection("categories").get().then((value) {
      for (var element in value.docs) {
        _categoryModel = CategoryModel.fromJson(element.data());
        _category.add(_categoryModel!);
        if (kDebugMode) {
          print("MTE : "+element.data()["id"]);
        }
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print("MTE : $onError");
      }
    });
  }
}
