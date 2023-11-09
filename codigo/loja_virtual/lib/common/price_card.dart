import 'package:flutter/material.dart';
import 'package:loja_virtual/main.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({super.key,
    required this.buttonText,
    required this.onPressed});

  final String buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {

    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Resumo do Pedido',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Subtotal'),
                  Text('R\$ ${productsPrice.toStringAsFixed(2)}')
                ]
            ),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total',
                style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text('R\$19,99',
                    style: TextStyle(
                    color: MyApp.primary,
                    fontSize: 16
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                    backgroundColor: MyApp.primary,
                    disabledBackgroundColor:
                    MyApp.primary.withAlpha(100)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(buttonText,
                  style: const TextStyle(color: Colors.white, fontSize: 16),),
                )
            )
          ],
        ),
      ),
    );
  }
}
