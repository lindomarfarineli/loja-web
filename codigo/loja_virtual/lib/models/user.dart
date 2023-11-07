import 'package:cloud_firestore/cloud_firestore.dart';


class UserPerson {

  UserPerson({this.id, this.name, this.gender, this.cpf, this.phone, this.city,
    this.street, this.number, this.comp, this.neighborhood, this.zipCode,
    this.state, this.email, this.password});

  UserPerson.fromDocument(DocumentSnapshot doc) {
    final d = doc.get;
    id = doc.id;
    name = doc.get('name');
    cpf = d('cpf');
    gender = d('gender');
    phone = d('phone');
    city = d('city');
    street = d('street');
    number = d('number');
    comp = d('comp');
    neighborhood = d('neighborhood');
    zipCode = d('zipCode');
    state = d('state');
    email = d('email');

  }

  String? id;
  String? name;
  String? cpf;
  String? gender;
  String? phone;
  String? city;
  String? street;
  String? number;
  String? comp;
  String? neighborhood;
  String? zipCode;
  String? state;
  String? email;
  String? password;

  DocumentReference get fireRef => FirebaseFirestore.instance.doc('USERS/$id');

  CollectionReference get cartReference => fireRef.collection('cart');

  Future<void> saveData() async {
    await fireRef.set(toMap());
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'cpf': cpf,
      'gender': gender,
      'phone': phone,
      'city': city,
      'street': street,
      'number': number,
      'comp': comp,
      'neighborhood': neighborhood,
      'zipCode': zipCode,
      'state': state,
      'email': email
    };
  }



}


