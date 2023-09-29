import 'package:flutter/material.dart';
import 'package:loja_virtual/main.dart';
import '../product.dart';


class ProductListTile extends StatelessWidget {
   const ProductListTile({super.key, required this.product} );

  final Product product;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed('/product', arguments: product);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              AspectRatio(aspectRatio: 1,
              child: Image.network(product.images?.first ?? 'https://'
                  'firebasestorage.googleapis.com/v0/b/loja-virtual-b3933.'
                  'appspot.com/o/noPhoto.png?alt='
                  'media&token=ec7f0d54-abf8-45a5-8518-b60dce5d88b1',
                fit: BoxFit.fitHeight,),
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? 'Não há produtos aqui',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'A partir de',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12
                          ),
                        ),
                      ),
                      Text(
                        'R\$ 19,99',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: MyApp.primary
                        ),
                      )
                    ],
                  ),
              )
            ],
          ),
        )
      ),
    );
  }
}
