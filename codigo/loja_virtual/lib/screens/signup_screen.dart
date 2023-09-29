import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';

import '../helpers/validators.dart';
import '../main.dart';
import '../widgets/icon_return.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();


  final _cepController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _complementController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _stateController = TextEditingController();
  final _passController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _confirmEmailAddressController = TextEditingController();
  final _confirmPastController = TextEditingController();

  bool obscured = true;

  Future<void> returnZipCode(String zipCode) async {
    String url = "https://viacep.com.br/ws/$zipCode/json/";
    http.Response response = await http.get(Uri.parse(url));
    setState(() {
      if (response.statusCode == 200) {
        _stateController.text = json.decode(response.body)["uf"] ?? "";
        _cityController.text = json.decode(response.body)["localidade"] ?? "";
        _streetController.text = json.decode(response.body)["logradouro"] ?? "";
        _complementController.text =
            json.decode(response.body)["complemento"] ?? "";
        _neighborhoodController.text =
            json.decode(response.body)["bairro"] ?? "";
      }
    });
  }

  final UserPerson user = UserPerson();

  @override
  Widget build(BuildContext context) {
    double large = MediaQuery.of(context).size.width;
    double largeSB = MediaQuery.of(context).size.width < 500
        ? large * 0.9222
        : MediaQuery.of(context).size.width > 500 &&
                MediaQuery.of(context).size.width < 800
            ? 500
            : 700;
    double fields = largeSB - 64;
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(gradient: MyApp.gradient),
      ),
      Scaffold(
        appBar: AppBar(
          title: const Text('Criar Conta'),
          centerTitle: true,
          backgroundColor: MyApp.primary,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
            child: SizedBox(
              width: largeSB,
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formkey,
                  child: Consumer<UserManager>(builder: (_, userManager, __) {
                      return ListView(
                        padding: const EdgeInsets.all(16),
                        shrinkWrap: true,
                        children: [
                          TextFormField(
                            autocorrect: false,
                            enabled: !userManager.loading,
                            decoration: const InputDecoration(
                                hintText: "Nome Completo"),
                            keyboardType: TextInputType.text,
                            validator: (name) {
                              return nameIsValid(name);
                            },
                            onSaved: (name) => user.name = name,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            autocorrect: false,
                            enabled: !userManager.loading,
                            decoration:
                                const InputDecoration(hintText: "Gênero"),
                            keyboardType: TextInputType.text,
                            onSaved: (gender) => user.gender = gender,
                            //todo: fazer escolhamento
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: fields * 0.47,
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CpfInputFormatter()
                                    ],
                                    textInputAction: TextInputAction.next,
                                    enabled: !userManager.loading,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    autocorrect: false,
                                    decoration:
                                        const InputDecoration(hintText: "Cpf"),
                                    validator: (cpf) {
                                      return cpfIsValid(cpf);
                                    },
                                    onSaved: (cpf) => user.cpf = cpf,
                                  ),
                                ),
                                SizedBox(
                                  width: fields * 0.03,
                                ),
                                SizedBox(
                                  width: fields * 0.50,
                                  child: TextFormField(
                                    inputFormatters: [
                                      MaskTextInputFormatter(
                                          mask: '(##) #####-####')
                                    ],
                                    enabled: !userManager.loading,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.next,
                                    autocorrect: false,
                                    //controller: _phoneController,
                                    decoration:
                                        const InputDecoration(hintText: "Fone"),
                                    validator: (phone) {
                                      if (phone == null ||
                                          phone.isEmpty ||
                                          phone.length < 15) {
                                        return "Número inválido";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (phone) => user.phone = phone,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: fields * 0.33,
                                  child: TextFormField(
                                    inputFormatters: [
                                      MaskTextInputFormatter(mask: '##.###-###')
                                    ],
                                    enabled: !userManager.loading,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    autocorrect: false,
                                    controller: _cepController,
                                    decoration:
                                        const InputDecoration(hintText: "Cep"),
                                    validator: (zipCode) {
                                      if (zipCode == null || zipCode.isEmpty) {
                                        return "CEP inválido";
                                      } else if (_stateController
                                          .text.isEmpty) {
                                        return "CEP inválido";
                                      }
                                      return null;
                                    },
                                    onSaved:  (zipCode) =>
                                        user.zipCode = zipCode,
                                  ),
                                ),
                                SizedBox(
                                  width: fields * 0.02,
                                ),
                                SizedBox(
                                  width: fields * 0.52,
                                  child: Center(
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero),
                                      child: SizedBox(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.search,
                                            color: MyApp.primary,
                                          ),
                                          Text(
                                            "Buscar Endereço",
                                            style:
                                                TextStyle(color: MyApp.primary),
                                          ),
                                        ],
                                      )),
                                      onPressed: ()   {
                                        userManager.loading? null:
                                        setState(() {
                                          String zipCode = _cepController.text
                                              .replaceFirst(".", "");
                                          zipCode =
                                              zipCode.replaceFirst("-", "");
                                          returnZipCode(zipCode);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: fields * 0.02,
                                ),
                                SizedBox(
                                  width: fields * 0.11,
                                  child: TextFormField(
                                    enabled: false,
                                    controller: _stateController,
                                    decoration:
                                        const InputDecoration(hintText: "U.F"),
                                    keyboardType: TextInputType.text,
                                    onSaved: (state) => user.state = state,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            enabled: false,
                            controller: _cityController,
                            decoration:
                                const InputDecoration(hintText: "Cidade"),
                            keyboardType: TextInputType.text,
                            onSaved: (city) => user.city = city,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            enabled: false,
                            controller: _streetController,
                            decoration:
                                const InputDecoration(hintText: "Logradouro"),
                            onSaved: (street) => user.street = street,
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: fields * 0.24,
                                  child: TextFormField(
                                    autocorrect: false,
                                    enabled: !userManager.loading,
                                    decoration: const InputDecoration(
                                        hintText: "Número"),
                                    validator: (number) {
                                      if (number == null || number == "") {
                                        return "S/N?";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (number) => user.number = number,
                                  ),
                                ),
                                SizedBox(width: fields * 0.02),
                                SizedBox(
                                  width: fields * 0.20,
                                  child: TextFormField(
                                    autocorrect: false,
                                    enabled: !userManager.loading,
                                    decoration: const InputDecoration(
                                        hintText: "Comp."),
                                    keyboardType: TextInputType.text,
                                    onSaved: (comp) => user.comp = comp,
                                  ),
                                ),
                                SizedBox(width: fields * 0.02),
                                SizedBox(
                                  width: fields * 0.52,
                                  child: TextFormField(
                                    enabled: false,
                                    controller: _neighborhoodController,
                                    decoration: const InputDecoration(
                                        hintText: "Bairro"),
                                    keyboardType: TextInputType.text,
                                    onSaved: (neighborhood) =>
                                        user.neighborhood = neighborhood,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            autocorrect: false,
                            enableInteractiveSelection: false,
                            toolbarOptions: const ToolbarOptions(
                                copy: false,
                                paste: false,
                                cut: false,
                                selectAll: false),
                            controller: _emailAddressController,
                            enabled: !userManager.loading,
                            decoration:
                                const InputDecoration(hintText: "Email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (text) {
                              return emailIsValid(text);
                            },
                            onSaved: (email) => user.email = email,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            autocorrect: false,
                            enableInteractiveSelection: false,
                            toolbarOptions: const ToolbarOptions(
                                copy: false,
                                paste: false,
                                cut: false,
                                selectAll: false),
                            controller: _confirmEmailAddressController,
                            enabled: !userManager.loading,
                            decoration: const InputDecoration(
                                hintText: "Confirme o Email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (text) {
                              if (text != null) {
                                if (text.isEmpty ||
                                    _confirmEmailAddressController.text !=
                                        _emailAddressController.text) {
                                  return "Os emails não são iguais";
                                }
                              } else {
                                return "Os emails não são iguais";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: fields * 0.85,
                                  child: TextFormField(
                                    enableInteractiveSelection: false,
                                    autocorrect: false,
                                    controller: _passController,
                                    obscureText: obscured,
                                    enabled: !userManager.loading,
                                    decoration: const InputDecoration(
                                      hintText: "Senha",
                                    ),
                                    validator: (text) {
                                      if (text != null) {
                                        if (text.isEmpty || text.length < 6) {
                                          return "senha inválida";
                                        }
                                      } else {
                                        return "senha inválida";
                                      }
                                      return null;
                                    },
                                    onSaved: (pass) => user.password = pass,
                                  ),
                                ),
                                SizedBox(
                                  width: fields * 0.15,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero),
                                    child: IconReturn(obscured),
                                    onPressed: () {
                                      setState(() {
                                        if (obscured == true) {
                                          obscured = false;
                                        } else {
                                          obscured = true;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          SizedBox(
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: fields * 0.85,
                                  child: TextFormField(
                                    enableInteractiveSelection: false,
                                    autocorrect: false,
                                    controller: _confirmPastController,
                                    enabled: !userManager.loading,
                                    obscureText: obscured,
                                    decoration: const InputDecoration(
                                      hintText: "Confirme a Senha",
                                    ),
                                    validator: (text) {
                                      if (text != null) {
                                        if (text.isEmpty ||
                                            text.length < 6 ||
                                            _confirmPastController.text !=
                                                _passController.text) {
                                          return "As senhas não são iguais";
                                        }
                                      } else {
                                        return "As senhas não são iguais";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: fields * 0.15,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero),
                                    child: IconReturn(obscured),
                                    onPressed: () {
                                      setState(() {
                                        if (obscured == true) {
                                          obscured = false;
                                        } else {
                                          obscured = true;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 44.0,
                            child: TextButton(
                              onPressed: userManager.loading? null: () {
                                if (_formkey.currentState != null &&
                                    _formkey.currentState!.validate())
                                {
                                  if(user.name!=null || user.name != "" &&
                                      user.gender!=null || user.gender != "" &&
                                      user.cpf!=null || user.cpf != "" &&
                                      user.zipCode!=null || user.zipCode != "" &&
                                      user.state!=null || user.state != "" &&
                                      user.city!=null || user.city != "" &&
                                      user.street!=null || user.street != "" &&
                                      user.number!=null || user.number != "" &&
                                      user.neighborhood!=null || user.neighborhood != "" &&
                                      user.email!=null || user.email != ""
                                  ){
                                    _formkey.currentState!.save();
                                    userManager.signUp(
                                        user: user,
                                        onFail: (e) {
                                          var snackBar = SnackBar(
                                              content: Text(
                                                  "Falha ao cadastrar: $e",
                                                  style: const TextStyle(
                                                      color: Colors.red)),
                                              backgroundColor: Colors.yellow,
                                              duration:
                                              const Duration(seconds: 4));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                        onSucess: (){
                                          Navigator.of(context).pop();
                                        }
                                        );
                                  }else {
                                    var snackBar = const SnackBar(
                                        content: Text("Falha ao cadastrar, revise os dados!",
                                            style: TextStyle(color: Colors.red)),
                                        backgroundColor: Colors.yellow,
                                        duration: Duration(seconds: 4));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                } else {
                                  var snackBar = const SnackBar(
                                      content: Text("Verifique os campos!",
                                          style: TextStyle(color: Colors.red)),
                                      backgroundColor: Colors.yellow,
                                      duration: Duration(seconds: 4));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: MyApp.primary,
                                  disabledBackgroundColor:
                                  MyApp.primary.withAlpha(100)),
                              child: userManager.loading?
                              const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ):const Text(
                                'Criar Conta',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ),
    ]);
  }
}
