import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:loja_virtual/main.dart';
import 'package:loja_virtual/models/products/item_size.dart';
import 'package:loja_virtual/models/products/product.dart';


class SizeWidget extends StatelessWidget {
  const SizeWidget({super.key, required this.size});

  final ItemSize size;

  @override

  Widget build(BuildContext context) {
    final product = context.watch<Product>();
    final selected = size == product.selectedSize;
    Color primary = MyApp.primary;
    Color color;
    bool alpha = MediaQuery.of(context).size.width > 480;

    if (!size.hasStock) {
      color = Colors.grey.withAlpha(alpha? 170:70);
    } else if ( selected) {
      color = primary;
    } else {
      color = primary.withAlpha(alpha? 170:70);
    }

    return  GestureDetector(
      onTap: (){
        if (size.hasStock) {
          product.selectedSize = size;
          product.dataSizeList(size);
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
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
