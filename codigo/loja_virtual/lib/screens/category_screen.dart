import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/main.dart';
import 'package:loja_virtual/models/category_manager.dart';
import '../models/categories/components/category_list_tile.dart';
import 'package:provider/provider.dart';







class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

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
        Scaffold(
          drawer: const CustomDrawer(),
          appBar: AppBar(
            title: const Text('Categorias'),
            centerTitle: true,
            backgroundColor: MyApp.primary,
          ),
          body: Consumer<CategoryManager>(
              builder: (_, categoryManager, __){
                return  Center(
                  child: SizedBox(
                    width: screen > 480 ? 500 :double.maxFinite,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(4),
                        itemCount: categoryManager.allCategories.length,
                        itemBuilder: (_, index){
                          return CategoryListTile(category:
                          categoryManager.allCategories[index]);
                        }
                        ),
                  ),
                );
              }
          ),
        ),
      ],
    );
  }
}

