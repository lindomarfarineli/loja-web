import 'package:flutter/material.dart';
import 'package:loja_virtual/models/products/product.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';


import '../../../models/product_manager.dart';
import '../../../models/section_item.dart';

class ItemTile extends StatelessWidget {

  const ItemTile({super.key, required this.item, this.valueKey, this.height});

  final SectionItem item;
  final ValueKey<dynamic>? valueKey;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.product != null) {
          Product? product;
          context.read<ProductManager>()
              .findProductById(item).then((value) => {
                product = value,
                if (product != null) {
                Navigator.of(context).pushNamed('/product', arguments: product)
                }
          });
        }
      },
      child: Card(
        margin: EdgeInsets.zero,
        key: ValueKey(valueKey),
        child: SizedBox(
          height:height,
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: item.image!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}