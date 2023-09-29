import 'package:flutter/material.dart';
import 'package:loja_virtual/main.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:provider/provider.dart';
import '../category.dart';


class CategoryListTile extends StatelessWidget {

  const CategoryListTile({super.key, required this.category} );

  final Category category;




  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){

          MyApp.init = category.id;
          context.read<ProductManager>().loadAllProduct(category: category.id);
          Navigator.of(context).pushNamed('/products', arguments: category);

      },
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)
          ),
          child: Container(
            height: 100,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                AspectRatio(aspectRatio: 1,
                  child: Image.network(category.icon ?? 'https://firebasestorage.'
                      'googleapis.com/v0/b/loja-virtual-b3933.appspot.com/o/'
                      'image-no-photo.png?alt=media&token='
                      '876d6191-3e65-4827-b16e-8bcb9045c0ff'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Text(
                        category.title ?? 'Produto ausente',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right, size: 50,)
                    ],
                  ),
                )
              ],
            ),
          ),
      ),
    );


  }
}
