import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/validator.dart';
import '../components/input_text_widget.dart';
import 'package:sistema_de_gestao_comercial/util.dart';

/// Tela de formulario de cadastro
class SignUp extends StatelessWidget {
  /// padding - espaço entre os itens do formulario
  SignUp({Key? key}) : super(key: key);
  var password = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputText(
          label: "EMAIL",
          controller: emailController,
          validator: (email) {
            return Validator.validateEmail(emailController.text);
          },
        ),
        AppUtil.defaultPadding,
        InputText(
          label: "NOME",
          validator: (name) {
            return Validator.validateName(name);
          },
        ),
        AppUtil.defaultPadding,
        InputText(
          label: "SENHA",
          controller: password,
          validator: (password) {
            return Validator.validatePassword(password);
          },
          obscureText: true,
        ),
        AppUtil.defaultPadding,
        InputText(
          label: "CONFIRMAR SENHA",
          validator: (confirmPassword) {
            return Validator.validateConfirmPassword(
                password.text, confirmPassword);
          },
          obscureText: true,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            child: const Text("Ja possuo uma conta",
                style: TextStyle(
                  color: Colors.blueGrey,
                )),
            onTap: () => Navigator.pop(context),
          ),
        ),
        AppUtil.defaultPadding,
        ElevatedButton(
            onPressed: () {
              if (Form.of(context)!.validate()) {}
            },
            child: const Text("Cadastrar"))
      ],
    );
  }
}
