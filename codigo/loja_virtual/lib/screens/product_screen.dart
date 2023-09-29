import 'package:flutter/material.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';

import '../models/products/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: (Text(product.name ?? 'Produto não encontrado')),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
              height: 150.0,
              width: 300.0,
              child: Carousel(
                images: product.images!.map((url){
                  return Image.network(url);
                }).toList(),
              ),
          ),
        ]

      ),
    );
  }
}
