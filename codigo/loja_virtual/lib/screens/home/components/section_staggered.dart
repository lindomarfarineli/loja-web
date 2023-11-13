import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:loja_virtual/screens/home/components/section_header.dart';
import '../../../models/section.dart';
import 'item_tile.dart';

class SectionStaggered extends StatelessWidget {
  const SectionStaggered({super.key, required this.section});

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section: section),
          SingleChildScrollView(
            child: SizedBox(
              height: 470,
              child: MasonryGridView.count(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemCount: section.items.length,
                itemBuilder: (context, index) {
                  return ItemTile(
                      height: index % 2 == 0 ? 300:150,
                      item: section.items[index],
                      valueKey: ValueKey(section.items[index])
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}