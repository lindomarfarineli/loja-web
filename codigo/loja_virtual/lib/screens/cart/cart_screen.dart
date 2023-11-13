import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:loja_virtual/main.dart';
import '../../common/price_card.dart';
import '../../models/cart_manager.dart';
import 'components/cart_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = MyApp.primary;
    double screen = MediaQuery.of(context).size.width;
    return  Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: MyApp.gradient
          ),
        ),
        Center(
          child: SizedBox(
            width: screen > 480 ? 800 :double.maxFinite,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Carrinho'),
                centerTitle: true,
                backgroundColor: primary,
              ),
              body: Consumer<CartManager>(
                builder: (_, cartManager, __) {
                  return ListView(
                    children: [
                      Column(
                        children: cartManager.items.map(
                          (cartProduct) => CartTile(cartProduct: cartProduct)
                        ).toList()
                      ),
                      PriceCard(
                        buttonText: 'Continuar para Entrega',
                        onPressed: cartManager.isCartValid? (){}:null,
                      )
                    ],
                  );
                }
              ),
            ),
          ),
        ),
      ],
    );
  }
}
