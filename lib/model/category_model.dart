
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CategoryModel {
  String? id;
  String? title;

  CategoryModel({
    this.id,
    this.title,
  });

  CategoryModel.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    title = json['title'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

}
