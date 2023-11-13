import 'package:flutter/material.dart';

import 'package:loja_virtual/screens/home/components/section_header.dart';
import '../../../models/section.dart';
import 'item_tile.dart';

class SectionList extends StatelessWidget {
  const SectionList({super.key, required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section: section),
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            height: 150,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index){
                  return ItemTile(item: section.items[index], valueKey: ValueKey(section.items[index]));
                  // return AspectRatio(
                  //   aspectRatio: 1,
                  //     child: Image.network(
                  //       section.items[index].image.toString(),
                  //       fit: BoxFit.cover,));
                },
                separatorBuilder: (_, __) => const SizedBox(width: 4),
                itemCount: section.items.length),
          )
        ],
      ),
    );
  }
}
