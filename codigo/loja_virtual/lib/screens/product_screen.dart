import 'package:flutter/material.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';

import '../models/products/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: (Text(product.name ?? 'Produto não encontrado')),
        centerTitle: true,
        backgroundColor:primary,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
              child: Carousel(
                images: product.images != null? product.images!.map((url){
                  return Image.network(url, fit: BoxFit.cover );
                }).toList() : [Image.network('https://firebasestorage.'
                    'googleapis.com/v0/b/loja-virtual-b3933.appspot.com/o/'
                    'image-no-photo.png?alt=media&token='
                    '876d6191-3e65-4827-b16e-8bcb9045c0ff',fit:BoxFit.cover)] ,
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: primary,
                autoplay: false,
              ),
          ),
          Padding(
              padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? 'Não encontrado',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'A partir de',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13
                        )
                  ),
                ),
                Text(
                  'R\$ 19,99',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primary
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    'Descrição',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Text(
                  product.description ?? 'não encontrado',
                  style: const TextStyle(
                    fontSize: 16
                  ),
                )
              ],
            ),
          )
        ]

      ),
    );
  }
}
