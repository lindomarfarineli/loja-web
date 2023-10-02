import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/helpers/firebase_errors.dart';
import 'package:loja_virtual/models/user.dart';


/// classe de administração de usuarios ////////////////////////////////////////
class UserManager extends ChangeNotifier{


  UserManager(){
    _loadCurrentUser();
  }

/// váriaveis de banco /////////////////////////////////////////////////////////
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
   User? user;


 UserPerson? userp;


  bool _loading = false;
  bool get loading => _loading;



/// método de login ////////////////////////////////////////////////////////////
  Future<void> signIn({
    required UserPerson user,
    required Function onFail,
    required Function onSucess } ) async {

    try {
      loading = true;
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: user.email!,
          password: user.password!);

      if(result.user != null){
        await _loadCurrentUser(userFireb: result.user );
      }

      onSucess();
      loading = false;
    } on FirebaseException catch (e) {
      loading = false;
      onFail(getErrorString(e.code));
    }
  }
/// ////////////////////////////////////////////////////////////////////////////
  set loading(bool value) {
    _loading = value;
    notifyListeners();  }

/// ////////////////////////////////////////////////////////////////////////////
/// faz o carregamento do usuário atual ////////////////////////////////////////
/// chamado no login e no carregamento inicial da pág. /////////////////////////

   Future<void> _loadCurrentUser({User? userFireb}) async {


       ///se usuário é passado no login ou vai buscar no firebase
       user = userFireb ?? auth.currentUser;


       ///buscando dados de usuário
       if (user?.uid != null){
         final DocumentSnapshot doc =
         await db.collection('USERS').doc(user!.uid).get();
         ///fazendo o carregamento do objeto UserPerson
         userp = UserPerson.fromDocument(doc);
       }

       notifyListeners();
  }
  bool get isLoggedIn => userp != null;

/// ////////////////////////////////////////////////////////////////////////////
/// método de cadastro --> chamado pela pag. de cadastro ///////////////////////

  Future<void> signUp({
    required UserPerson user,
    required Function onFail,
    required Function onSucess }) async {

    loading = true;

    try{
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: user.email!,
          password: user.password!);

      if(result.user != null){
        this.user = result.user;

        user.id = this.user!.uid;
        await user.saveData();
        userp = user;
        onSucess();
      }
    } on FirebaseException catch (e) {
      loading = false;
      onFail(getErrorString(e.code));
    }
    loading = false;
  }
/// ////////////////////////////////////////////////////////////////////////////
/// método de saída ////////////////////////////////////////////////////////////
/// chamado no custom_drawer_header/////////////////////////////////////////////

  void signOut(){
    auth.signOut();
    userp = null;
    user = null;
    notifyListeners();
  }
/// ////////////////////////////////////////////////////////////////////////////
}
/// fim da classe///////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////