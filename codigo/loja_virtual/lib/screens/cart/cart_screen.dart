import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:loja_virtual/main.dart';
import '../../models/cart_manager.dart';
import 'components/cart_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = MyApp.primary;
    return  Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: MyApp.gradient
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Carrinho'),
            centerTitle: true,
            backgroundColor: primary,
          ),
          body: Consumer<CartManager>(
            builder: (_, cartManager, __) {
              return Column(
                children: cartManager.items.map(
                    (cartProduct) => CartTile(cartProduct: cartProduct)
                ).toList()
                );
            }
          ),
        ),
      ],
    );
  }
}
