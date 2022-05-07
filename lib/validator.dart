// ignore: import_of_legacy_library_into_null_safe
import 'package:email_validator/email_validator.dart';

class ValidatorController {
  static String? validateEmail(String email) {
    if (email.trim().isEmpty) return "O email não pode estar vazio";
    if (!EmailValidator.validate(email)) {
      return "Email inválido! O email deve ser do tipo email@example.com";
    }
    return null;
  }

  static String? validateName(String name) {
    if (name.trim().isEmpty) return "O nome não pode estar vazio";
    return null;
  }

  static String? validatePassword(String password) {
    if (password.trim().isEmpty) return "A senha não pode estar vazio";
    if (password.length < 6) return "A senha deve ter no mínimo 6 caracteres";
    return null;
  }

  static String? validateConfirmPassword(String password1, String password2) {
    if (password1 != password2) return "As senhas não são compatíveis";
    return null;
  }
}
