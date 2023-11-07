import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/products/data_size.dart';
import 'package:loja_virtual/models/products/item_size.dart';
import 'package:loja_virtual/models/products/product.dart';

class CartProduct {

  final db = FirebaseFirestore.instance;

  CartProduct.fromProduct(this.product){
    productId = product?.id ;
    quantity = 1;
    type = product?.type;
    size =  product?.selectedSize?.name;
    data = product?.selectedData?.data;
  }

  CartProduct.fromDocument(DocumentSnapshot doc) {
    print('CartProduct foi chamado');
    print('o valor de product é ${product?.name}');
    productId = doc.get('pid');
    print('o valor de pid é $productId');
    quantity = doc.get('quantity');
    print('O valor de quantity é $quantity');
    size = doc.get('size');
    print('O valor de size é $size');
    type = doc.get('type');
    print('O valor de type é $type');
    data = doc.get('data');
    print('O valor de data é $data');

    print('vai realizar uma pesquisa no banco');
    db.collection('products').doc(type).collection('items').doc(productId)
        .get().then((doc)  => {
           product = Product.fromDocument(doc),
           print('O valor de product dentro do them agora é ${product?.name}')
    }
    );

    print('O valor de product agora é ${product?.name}');
  }

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
}