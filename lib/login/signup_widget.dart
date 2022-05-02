import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/login/input_text_widget.dart';
import 'package:sistema_de_gestao_comercial/util.dart';

/// Tela de formulario de cadastro
class SignUp extends StatelessWidget {
  /// padding - espaço entre os itens do formulario
  const SignUp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputText(
            label: "EMAIL", validator: (email) => null, obscureText: false),
        AppUtil.defaultPadding,
        InputText(label: "NOME", validator: (nome) => null, obscureText: false),
        AppUtil.defaultPadding,
        InputText(
            label: "SENHA", validator: (senha) => null, obscureText: true),
        AppUtil.defaultPadding,
        InputText(
            label: "CONFIRMAR SENHA",
            validator: (senha) => null,
            obscureText: true),
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
        ElevatedButton(onPressed: () {}, child: const Text("Cadastrar"))
      ],
    );
  }
}
