import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/products/data_size.dart';
import 'package:loja_virtual/models/products/item_size.dart';
import 'package:loja_virtual/models/products/product.dart';

class CartProduct extends ChangeNotifier {

  final db = FirebaseFirestore.instance;

  CartProduct.fromProduct(this.product){
    productId = product?.id ;
    quantity = 1;
    type = product?.type;
    size =  product?.selectedSize?.name;
    data = product?.selectedData?.data;
  }

  CartProduct.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    productId = doc.get('pid');
    quantity = doc.get('quantity');
    size = doc.get('size');
    type = doc.get('type');
    data = doc.get('data');

    db.collection('products').doc(type).collection('items').doc(productId)
        .get().then((doc)  => {
           product = Product.fromDocument(doc),
           notifyListeners()
        }
    );
  }

  String? id;
  String? productId;
  String? type;
  int? quantity;
  String? size;
  String? data;


  Product? product;

  ItemSize? get itemSize{
    return product?.findSize(size!);
  }

  DataSize? get itemData{
    return product?.findData(data);
  }

  num get unitPrice {
      return itemData?.price ?? 0;
  }

  num get totalPrice {
    return unitPrice * quantity!;
  }

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'type': type,
      'quantity': quantity,
      'size': size,
      'data': data
    };
  }

  bool stackable(Product product) {
    return product.id == productId &&
           product.selectedSize?.name == size &&
           product.selectedData?.data == data;
  }

  void increment() {
    quantity = quantity! + 1;
    notifyListeners();
  }

  void decrement() {
    if ( quantity! > 0){
      quantity = quantity! - 1;
      notifyListeners();
    }
  }

  bool get hasStock {
    final data = itemData;
    if(data == null) {
      return false;
    }
    return data.stock! >= quantity! ;
  }

}