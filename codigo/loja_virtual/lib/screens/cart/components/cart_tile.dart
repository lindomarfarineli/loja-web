import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/main.dart';
import 'package:loja_virtual/models/cart_product.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  const CartTile({super.key, required this.cartProduct});

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    final primary = MyApp.primary;

    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                height: 90,
                width: 90,
                child: Image.network(cartProduct.product!.images!.first),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartProduct.product?.name ?? 'Produto não encontrado',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 3),
                          child: Text('Tamanho: ${cartProduct.size},',
                          style: const TextStyle(fontWeight: FontWeight.w300),
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text('${cartProduct.data}',
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                      Consumer<CartProduct>(
                        builder: (_, cartProduct, __) {
                          if ( cartProduct.hasStock) {
                            return Text('R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: primary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return const Text('Sem estoque disponível', style:
                              TextStyle(color: Colors.red, fontSize: 12
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              Consumer<CartProduct>(
                  builder: (_, cartProduct, __){
                    return Column(
                      children: [
                        CustomIconButton(
                          iconData: Icons.add,
                          color: primary,
                          onTap: (){
                            cartProduct.increment();
                          },
                        ),
                        Text('${cartProduct.quantity}',
                            style: const TextStyle(fontSize: 20)),
                        CustomIconButton(
                          iconData: Icons.remove,
                          color: cartProduct.quantity! > 1? primary : Colors.grey,
                          onTap: (){
                            cartProduct.decrement();
                          },
                        ),
                      ],
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
