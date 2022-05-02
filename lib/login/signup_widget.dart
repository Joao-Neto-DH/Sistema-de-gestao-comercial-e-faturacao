import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/login/input_text_widget.dart';

/// Tela de formulario de cadastro
class SignUp extends StatelessWidget {
  /// padding - espaço entre os itens do formulario
  const SignUp({Key? key, required this.padding}) : super(key: key);
  final Padding padding;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputText(
            label: "EMAIL", validator: (email) => null, obscureText: false),
        padding,
        InputText(label: "NOME", validator: (nome) => null, obscureText: false),
        padding,
        InputText(
            label: "SENHA", validator: (senha) => null, obscureText: true),
        padding,
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
        padding,
        ElevatedButton(onPressed: () {}, child: const Text("Cadastrar"))
      ],
    );
  }
}
