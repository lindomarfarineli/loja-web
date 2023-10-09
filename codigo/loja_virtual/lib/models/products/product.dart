
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'data_size.dart';
import 'item_size.dart';

class Product extends ChangeNotifier{

  String? id;
  String? name;
  String? description;
  List<String>? images;
  List<ItemSize>? sizes;
  List<DataSize> datas = [];

  Product.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    name = doc.get("name");
    description = doc.get('description');
    images = List<String>.from(doc.get("images") as List<dynamic> );
    sizes = (doc.get('sizes') as List<dynamic>).map((s) => ItemSize.fromMap(s as Map<String, dynamic> )).toList();
    datas = (sizes![0].datas as List<DataSize>).map((d) => d ).toList();
  }

  void dataSizeList (ItemSize item) {
    datas = (item.datas as List<DataSize>).map((d) => d ).toList();
    notifyListeners();
  }

  List<DataSize> get currentData{
    return datas;
  }

  ItemSize? _selectedSize;
  ItemSize? get selectedSize => _selectedSize;

  set selectedSize(ItemSize? value) {
    _selectedSize = value;
    notifyListeners();
  }

  DataSize? _selectedData;
  DataSize? get selectedData => _selectedData;

  set selectedData(DataSize? value){
    _selectedData = value;
    notifyListeners();
  }

   int get totalStock {
     int stock =0;

       for (final data in datas){
         stock += data.stock!;
       }

     return stock;
   }

   bool get hasStock {
     return totalStock > 0;
   }

}