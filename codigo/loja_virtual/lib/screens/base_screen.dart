import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:loja_virtual/models/page_manager.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'category_screen.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({super.key});

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Scaffold(
            drawer: const CustomDrawer() ,
            appBar: AppBar(
              title: const Text('Home 1'),
            ),
          ),
          const CategoryScreen(),
          Scaffold(
            drawer: const CustomDrawer() ,
            appBar: AppBar(
              title: const Text('Home 2'),
            ),
          ),
        ],
      ),
    );
  }
}
