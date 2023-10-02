import 'package:cloud_firestore/cloud_firestore.dart';

class ItemSize{

     ItemSize.fromMap(Map<String, dynamic> map ){
       color = map['color'] as String ;
       name = map['name'] as String;
       price = map['price'] as num;
       stock = map['stock'] as int;
     }

      String? color;
      String? name;
      num? price;
      int? stock;

      bool get hasStock => stock! > 0;

     @override
     String toString() {
       return 'ItemSize{color: $color, name: $name, price: $price, stock: $stock}';
     }
}

