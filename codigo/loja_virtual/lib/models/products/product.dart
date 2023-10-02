

import 'package:cloud_firestore/cloud_firestore.dart';

import 'item_size.dart';



class Product {

  Product.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    name = doc.get("name");
    description = doc.get('description');
    images = List<String>.from(doc.get("images") as List<dynamic> );
    sizes = (doc.get('sizes') as List<dynamic>).map((s) => ItemSize.fromMap(s as Map<String, dynamic> )).toList();
    }




  String? id;
  String? name;
  String? description;
  List<String>? images;
  List<ItemSize>? sizes;
}