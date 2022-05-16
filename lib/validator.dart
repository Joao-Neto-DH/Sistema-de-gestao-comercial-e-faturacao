// import 'package:email_validator/email_validator.dart';

class Validator {
  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return "O email não pode estar vazio";
    }
    String p = r'^\w+(\.\w)*@\w+(.\w{2,})+';

    RegExp regExp = RegExp(p);
    // print(regExp.hasMatch(email));
    if (!regExp.hasMatch(email)) {
      return "Email inválido! O email deve ser do tipo email@example.com";
    }
    return null;
  }

  static String? validateName(String? name) {
    if (name!.trim().isEmpty) return "O nome não pode estar vazio";
    return null;
  }

  static String? validatePassword(String? password) {
    if (password!.trim().isEmpty) return "A senha não pode estar vazio";
    if (password.length < 6) return "A senha deve ter no mínimo 6 caracteres";
    return null;
  }

  static String? validateConfirmPassword(String? password1, String? password2) {
    // print("$password1 $password2");
    if (password1 != password2) return "As senhas não são compatíveis";
    return null;
  }

  static String? validateNotEmpty(String? value) {
    return value!.trim().isEmpty ? "Este campo não pode ser vazio" : null;
  }
}
