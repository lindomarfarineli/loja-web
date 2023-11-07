
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/products/product.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'cart_product.dart';

class CartManager  {

  List<CartProduct> items = [];

  UserPerson? userp;

  void updateUser(UserManager userManager) {
    print('vai chamar o userManager');
    userp = userManager.userp;
    print('Se deu certo há um nome -> ${userp?.name}');
    items.clear();
    print( 'O carrinho foi limpo');

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

    print('Dentro do addtoCart');
    print(product.name);
    print(product.selectedData!.data);

    items.add(CartProduct.fromProduct(product));

  }
}