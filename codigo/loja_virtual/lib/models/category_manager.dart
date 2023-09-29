import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'categories/category.dart';


class CategoryManager extends ChangeNotifier {

  CategoryManager() {
    _loadAllCategories();
  }

  final db = FirebaseFirestore.instance;




  List<Category> allCategories = [];

  Future<void> _loadAllCategories() async {
    final QuerySnapshot snapCategories = await db.collection('products').get();

    allCategories = snapCategories.docs.map((c) =>
        Category.fromDocument(c)).toList();

    notifyListeners();
  }
}