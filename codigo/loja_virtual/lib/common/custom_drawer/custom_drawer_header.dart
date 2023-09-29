import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_manager.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
        height: 220,
        child:  Consumer<UserManager>(builder: (_, userManager, __) {
              return  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Instituto\nGCM',
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                  Text('Olá ${userManager.userp?.name ?? '' }',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  GestureDetector(
                    onTap: (){
                      if(userManager.isLoggedIn){
                        userManager.signOut();
                      } else {
                        Navigator.of(context).pushNamed('/login');
                      }
                    },
                    child: Text( userManager.isLoggedIn == true ? 'Sair'
                        : 'Entre ou cadastre-se',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    )   ,
                  )

                ],
              );
            }));
  }
}
