
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/products/product.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'cart_product.dart';

class CartManager  {

  List<CartProduct> items = [];

  UserPerson? userp;

  void updateUser(UserManager userManager) {

    userp = userManager.userp;
    items.clear();


    if (userp != null){
      print('Chamou o update user, o usuário não é nulo');
      _loadCartItems();
    } else {
      print ('usuário é nulo no cartManager');
    }

  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await userp!.cartReference.get();

    items = cartSnap.docs.map((d) => CartProduct.fromDocument(d)).toList();
  }

  void addToCart(Product product){
    try{
      final e = items.firstWhere((p) => p.stackable(product));
      e.quantity = e.quantity! + 1 ;
    } catch(e) {
      final cartProduct = CartProduct.fromProduct(product);
      items.add(cartProduct);
      userp!.cartReference.add(cartProduct.toCartItemMap());
    }




  }
}