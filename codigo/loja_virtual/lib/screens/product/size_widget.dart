import 'package:flutter/material.dart';

import 'package:loja_virtual/main.dart';
import 'package:loja_virtual/models/products/item_size.dart';
import 'package:loja_virtual/models/products/product.dart';
import 'package:provider/provider.dart';



class SizeWidget extends StatelessWidget {
  const SizeWidget({super.key, required this.size});

  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = size == product.selectedSize;
    Color primary = MyApp.primary;
    Color color;

    if (!size.hasStock) {
      color = Colors.grey.withAlpha(50);
    } else if ( selected) {
      color = primary;
    } else {
      color = primary.withAlpha(50);
    }

    return  GestureDetector(
      onTap: (){
        if (size.hasStock) {
          product.selectedSize = size;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
          )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: color,
              padding:  const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                size.name ?? 'indisp.',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "R\$ ${size.price?.toStringAsFixed(2)}"
              ),
            )
          ],
        ),
      ),
    );
  }
}
