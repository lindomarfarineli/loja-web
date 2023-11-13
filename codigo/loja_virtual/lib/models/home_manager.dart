import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/models/section.dart';

class HomeManager extends ChangeNotifier {

  List<Section> sections = [];
  final FirebaseFirestore db = FirebaseFirestore.instance;

  HomeManager()  {

    _loadSections();
  }


  void _loadSections()  {
     db.collection('home').snapshots().listen((snap) {
      sections.clear();
        for (final DocumentSnapshot doc in snap.docs ) {
          sections.add(Section.fromDocument(doc));
        }
        notifyListeners();
    });
  }


}