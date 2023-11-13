import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/main.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<ScaffoldState> scalffoldkey = GlobalKey<ScaffoldState>();

  @override

  Widget build(BuildContext context) {
    double large = MediaQuery.of(context).size.width;
    double largeSB = MediaQuery.of(context).size.width < 500?
    large * 0.9222 :
    MediaQuery.of(context).size.width > 500 &&
        MediaQuery.of(context).size.width < 800? 400 : 800;
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(gradient: MyApp.gradient),
      ),
      Scaffold(
        key: scalffoldkey,
        appBar: AppBar(
          title: const Text('Entrar'),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.of(context).pushReplacementNamed('/signup');
                },
                child: const Text('CRIAR CONTA',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white)
                )
            )
          ],
          backgroundColor: MyApp.primary,
        ),
        body: Center(
          child: SizedBox(
            width: largeSB,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                //child: //ChangeNotifierProvider(
                 // create: (_) => UserManager(),
                  child: Consumer<UserManager>(
                    builder: (_, userManager, __) {
                      return ListView(
                        padding: const EdgeInsets.all(16),
                        shrinkWrap: true,
                        children: [
                          TextFormField(
                            controller: emailController,
                            enabled: !userManager.loading,
                            decoration: const InputDecoration(hintText: 'E-mail'),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            validator: (email) {
                              if (email == null || !emailValid(email)) {
                                return 'E-mail inválido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: passController,
                            enabled: !userManager.loading,
                            decoration: const InputDecoration(hintText: 'Senha'),
                            autocorrect: false,
                            obscureText: true,
                            validator: (pass) {
                              if (pass == null ||
                                  pass.isEmpty ||
                                  pass.length < 6) {
                                return 'Senha inválida';
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              style:
                                  TextButton.styleFrom(padding: EdgeInsets.zero),
                              onPressed: () {},
                              child: const Text('Esqueci minha senha'),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: userManager.loading
                                  ? null
                                  : () async {
                                      if (formKey.currentState != null &&
                                          formKey.currentState!.validate()) {
                                       await userManager.signIn(
                                            user: UserPerson(
                                                email: emailController.text,
                                                password: passController.text),
                                            onFail: (e) {
                                              var snackBar = SnackBar(
                                                  content: Text("Falha: $e",
                                                      style: const TextStyle(
                                                          color: Colors.red)),
                                                  backgroundColor: Colors.yellow,
                                                  duration:
                                                      const Duration(seconds: 4));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            },
                                            onSucess: () {
                                              Navigator.of(context).pop();
                                            });
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: MyApp.primary,
                                  disabledBackgroundColor:
                                      MyApp.primary.withAlpha(100)),
                              child: userManager.loading
                                  ? const CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    )
                                  : const Text(
                                      'Entrar',
                                      style: TextStyle(fontSize: 18),
                                    ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      //),
    ]);
  }
}
