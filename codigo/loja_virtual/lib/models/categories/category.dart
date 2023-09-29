import 'package:cloud_firestore/cloud_firestore.dart';

class Category {

  Category.fromDocument(DocumentSnapshot doc){
    id = doc.id;
    icon = doc.get("icon");
    title = doc.get('title');


  }
  String? id;
  String? icon;
  String? title;
}