import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'components/section_list.dart';
import 'components/section_staggered.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient:  MyApp.gradient
            ),
          ),
          Center(
            child: SizedBox(
              width: screen > 480 ? 800 :double.maxFinite,
              child:  CustomScrollView(
                slivers: [
                  SliverAppBar(
                    snap: true,
                    floating: true,
                    elevation: 0,
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Text('Instituto GCM'),
                      centerTitle: true,
                    ),
                    backgroundColor: MyApp.primary,
                    actions: [
                      IconButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed('/cart');
                          }, icon: const Icon(Icons.shopping_cart)
                      ),
                    ],
                  ),
                  Consumer<HomeManager>(
                    builder: (_, homeManager, __) {

                      final List<Widget> children =
                      homeManager.sections.map<Widget>(
                          (section) {
                            switch(section.type){
                              case 'Staggered':
                                return SectionStaggered(section: section);
                              case 'List':
                                return SectionList(section: section);
                              default:
                                return Container();
                            }
                          }
                      ).toList();

                      return SliverList(
                          delegate: SliverChildListDelegate(children),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
