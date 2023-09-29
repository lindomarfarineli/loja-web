import 'package:get/get_utils/src/get_utils/get_utils.dart';

bool emailValid(String email){
  final RegExp regex = RegExp(
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
  return regex.hasMatch(email);
}

String? nameIsValid(String? value) {
  if (value == null || value.isEmpty) {
    return "Campo obrigatório";
  } else if (value.trim().split(' ').length <= 1){
    return "preencha seu nome completo";
  } else {
    return null;
  }
}

String? cpfIsValid(String? value){
  if(value == null || value.isEmpty){
    return "Campo obrigatório!";
  } else if(GetUtils.isCpf(value)){
    return null;
  } else {
    return "CPF inválido!";
  }
}

String? emailIsValid(String? email){
  final RegExp regex = RegExp(
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0"
      r"-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a"
      r"-zA-Z]{2,}))$");
  if (email != null && regex.hasMatch(email)){
    return null;
  } else {
    return "email inválido!";
  }
}