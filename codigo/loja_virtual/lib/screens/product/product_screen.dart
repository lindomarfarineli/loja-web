import 'package:flutter/material.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/screens/product/data_widget.dart';
import 'package:loja_virtual/screens/product/size_widget.dart';
import 'package:provider/provider.dart';

import '../../models/products/product.dart';


class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;
    double screen = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: (Text(product.name ?? 'Produto não encontrado')),
          centerTitle: true,
          backgroundColor:primary,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            width: screen > 480 ? 700 :double.maxFinite,
            child: ListView(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                    child: Carousel(
                      images: product.images != null? product.images!.map((url){
                        return Image.network(url, fit: BoxFit.cover );
                      }).toList() : [Image.network('https://firebasestorage.'
                          'googleapis.com/v0/b/loja-virtual-b3933.appspot.com/o/'
                          'image-no-photo.png?alt=media&token='
                          '876d6191-3e65-4827-b16e-8bcb9045c0ff',fit:BoxFit.cover)],
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: const Duration(milliseconds: 700),
                      dotSize: 4,
                      dotSpacing: 15,
                      dotBgColor: Colors.transparent,
                      dotColor: primary,
                      autoplay: true,
                      autoplayDuration: const Duration(milliseconds: 10000),
                      dotIncreasedColor: primary,
                    ),
                ),
                Padding(
                    padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 8),
                        child: Text('Tamanho(s)',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500 ),
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: product.sizes!.map((s){
                          return SizeWidget(size: s);
                        }).toList(),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Text( product.sizes != null?
                      product.sizes![0].feature! : '' ,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500 ),
                      ),
                    ),
                       Consumer<Product>(
                         builder: (_, prodt, __){
                           return Wrap(
                               spacing: 8,
                               runSpacing: 8,
                               children: prodt.currentData.map((d){
                             return DataWidget(data: d, product: product);
                           }).toList()
                           );
                         },
                       ),
                      const SizedBox(height: 20),
                      if (product.hasStock)
                      Consumer2<UserManager, Product>
                        (builder: (_, userManager, product, __){
                          return SizedBox(height: 44,
                          child: ElevatedButton(
                            onPressed: product.selectedData!=null?(){
                              if (userManager.isLoggedIn) {
                                context.read<CartManager>().addToCart(product);
                                Navigator.of(context).pushNamed('/cart');
                              } else {
                                Navigator.of(context).pushNamed('/login');
                              }
                            }:null,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                disabledBackgroundColor:
                                primary.withAlpha(100)),
                            child: Text(
                              userManager.isLoggedIn?
                                  'Adicionar ao carrinho':
                                  'Entre para comprar'
                            , style: const TextStyle(color: Colors.white, fontSize: 18),),
                          ),
                          );
                      })
                    ],
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
