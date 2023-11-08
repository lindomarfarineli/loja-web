import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/products/product.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'cart_product.dart';

class CartManager extends ChangeNotifier {

  List<CartProduct> items = [];

  UserPerson? userp;

  void updateUser(UserManager userManager) {

    userp = userManager.userp;
    items.clear();


    if (userp != null){
      _loadCartItems();
    }

  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await userp!.cartReference.get();

    items = cartSnap.docs.map(
            (d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated)
    ).toList();
  }

  void addToCart(Product product) async {
    try{
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch(e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      await userp!.cartReference.add(cartProduct.toCartItemMap()).then(
              (doc) => cartProduct.id = doc.id);
    }
  }

  void _onItemUpdated(){
    for (final cartProduct in items) {
      if (cartProduct.quantity == 0) {
        removeFromCart(cartProduct);
      }
      _updateCartProduct(cartProduct);
    }
  }
  
  void _updateCartProduct(CartProduct cartProduct) {
    userp?.cartReference.doc(cartProduct.id).
    update(cartProduct.toCartItemMap());
  }

  void removeFromCart(CartProduct cartProduct){
    items.removeWhere((p) => p.id == cartProduct.id);
    userp?.cartReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }
}