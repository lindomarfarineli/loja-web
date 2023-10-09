import 'package:flutter/material.dart';

import 'package:loja_virtual/main.dart';
import 'package:loja_virtual/models/products/product.dart';
import '../../models/products/data_size.dart';


class DataWidget extends StatelessWidget {
  const DataWidget({super.key, required this.data, required this.product});


  final Product product;
  final DataSize data;

  @override

  Widget build(BuildContext context) {
    final selected = data ==  product.selectedData;
    Color primary = MyApp.primary;
    Color color;
    bool alpha = MediaQuery.of(context).size.width > 480;
    if (!data.hasStock) {
      color = Colors.grey.withAlpha(alpha? 170:70);
    } else if ( selected) {
      color = primary;
    } else {
      color = primary.withAlpha(alpha? 170:70);   }

    return  GestureDetector(
      onTap: product.selectedSize != null ?(){
        if (data.hasStock) {
          product.selectedData = data;
        }
      }: null,
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
                data.data ?? 'indisp.',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                  "R\$ ${data.price?.toStringAsFixed(2)}"
              ),
            )
          ],
        ),
      ),
    );
  }
}