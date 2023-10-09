

import 'package:flutter/cupertino.dart';

import 'data_size.dart';

class ItemSize extends ChangeNotifier{

     ItemSize.fromMap(Map<String, dynamic>? map){
       if(map != null){

         feature = map['feature'] as String ;
         name = map['name'] as String;
         datas = (map['data'] as List<dynamic>).map((d) =>
             DataSize.fromMap(d as Map<String, dynamic>)).toList();
       }
     }

     //ItemSize();
     String? feature;
     String? name;
     List<DataSize>? datas;

     //DataSize? _selectedData;
     //DataSize? get selectedData => _selectedData;

     //set selectedData(DataSize? value) {
     //  _selectedData = value;
     // notifyListeners();
     //}

     int get totalStock {
       int stock =0;
       if (datas != null) {
         for (final data in datas!){
           stock += data.stock!;
         }
       }
       return stock;
     }


     bool get hasStock {
       return totalStock > 0;
     }

     @override
  String toString() {
    return 'ItemSize{feature: $feature, name: $name, datas: $datas}';
  }
}

