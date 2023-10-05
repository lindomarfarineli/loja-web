

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'item_size.dart';



class Product extends ChangeNotifier{

  String? id;
  String? name;
  String? description;
  List<String>? images;
  List<ItemSize>? sizes;

  Product.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    name = doc.get("name");
    description = doc.get('description');
    images = List<String>.from(doc.get("images") as List<dynamic> );
    sizes = (doc.get('sizes') as List<dynamic>).map((s) => ItemSize.fromMap(s as Map<String, dynamic> )).toList();
  }

  ItemSize? _selectedSize ;
  ItemSize? get selectedSize => _selectedSize;

  set selectedSize(ItemSize? value) {
    _selectedSize = value;
    notifyListeners();
  }
}