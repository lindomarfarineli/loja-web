import 'package:flutter/material.dart';

import '../main.dart';


class IconReturn extends StatelessWidget {
  final bool obscured;
  const IconReturn(this.obscured, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return obscured?  Icon(Icons.visibility_off, color: MyApp.primary,):
    Icon(Icons.visibility, color:MyApp.primary);
  }
}