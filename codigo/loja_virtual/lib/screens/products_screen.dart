import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:loja_virtual/main.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/models/products/components/product_list_tile.dart';
import '../models/products/components/search_dialog.dart';


class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, required this.category});

  final String category;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}


class _ProductsScreenState extends State<ProductsScreen> {

   @override
   void initState() {
     context.read<ProductManager>().loadAllProduct(category: widget.category);
   }
  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: MyApp.gradient
          ),
        ),
        Builder(
          builder: (context){
            return Scaffold(
              appBar: AppBar(
                title: Consumer<ProductManager>(
                  builder: (context, productManager, __){
                    if(productManager.search == null ||
                        productManager.search != null && productManager.search!.isEmpty){
                      return const Text('Produtos');
                    } else {
                      return LayoutBuilder(
                          builder: (_, constraints){
                            return GestureDetector(
                              onTap: () async {
                                final search = await showDialog<String>(context: context,
                                    builder: (_) =>  SearchDialog(
                                      productManager.search
                                    ));
                                if(search != null){
                                  productManager.search = search;
                                }
                              },
                              child: SizedBox(
                                width: constraints.biggest.width,
                                child: Text(productManager.search!,
                                  textAlign: TextAlign.center,),
                              ),
                            );
                          });
                    }
                  },
                ),
                centerTitle: true,
                backgroundColor: MyApp.primary,
                actions: [
                  Consumer<ProductManager>(
                    builder: (_, productManager, __) {
                      if(productManager.search == null ||
                          productManager.search != null && productManager.search!.isEmpty){
                        return IconButton(onPressed:() async {
                          final search = await showDialog<String>(context: context,
                              builder: (_) =>  SearchDialog(
                                  productManager.search
                              ));
                          if(search != null){
                            productManager.search = search;
                          }
                        }, icon: const Icon(Icons.search));
                      } else {
                        return IconButton(onPressed:() async {

                            productManager.search = null;

                        }, icon: const Icon(Icons.close));
                      }
                    },
                  )
                ],
              ),
              body: Consumer<ProductManager>(
                  builder: (context, productManager, __){
                    final filteredProducts = productManager.filteredProducts;
                    return  Center(
                      child: SizedBox(
                        width: screen > 480 ? 500 :double.maxFinite,
                        child: ListView.builder(
                            padding: const EdgeInsets.all(4),
                            itemCount: filteredProducts.length,
                            itemBuilder: (_, index){
                              return ProductListTile(product: filteredProducts[index]);
                            }),
                      ),
                    );
                  }
              ),
              );
          }
        ),
      ],
    );
  }
}
