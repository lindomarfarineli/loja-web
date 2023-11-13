import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/products/product.dart';
import 'package:loja_virtual/models/section_item.dart';


class ProductManager extends ChangeNotifier {

  final String? category;

  ProductManager(this.category) {
     loadAllProduct(category: category);
  }


  final db = FirebaseFirestore.instance;


  List<Product> allProducts = [];


  String? _search;

  String? get search => _search;

  set search(String? value)  {
    _search = value;
    notifyListeners();
  }



  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if(search == null || search != null && search!.isEmpty ){
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(allProducts.where((p) =>
          p.name!.toLowerCase().contains(search!.toLowerCase())));
    }
    return filteredProducts;
  }

  Future<void> loadAllProduct({String? category}) async {

      if(category != null ){
        allProducts = [];
        final QuerySnapshot snapProducts = await db.collection('products').
        doc(category).collection('items').get();
        allProducts = [];
        /// aqui todos os produtos de determinada categoria sõa buscados
        allProducts = snapProducts.docs.map((d) =>
            Product.fromDocument(d)).toList();
    }
    notifyListeners();
  }

    Future<Product?> findProductById (SectionItem item) async {

    await loadAllProduct(category: item.category);

    try {
      return allProducts.firstWhere((p) => p.id == item.product);
    } catch (e) {
      return null;
    }

  }

}
