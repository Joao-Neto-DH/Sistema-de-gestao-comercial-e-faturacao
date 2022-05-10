import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/validator.dart';
import '../components/input_text_widget.dart';
import 'package:sistema_de_gestao_comercial/util.dart';

/// Tela de recuperaçao de password
class RecoverPassword extends StatelessWidget {
  /// padding - espaço entre os itens do formulario
  const RecoverPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    return Column(
      children: [
        const Text("Digite o seu email para recuperar a senha"),
        AppUtil.defaultPadding,
        InputText(
          label: "EMAIL",
          // controller: emailController,
          validator: (email) {
            emailController.text = email!;
            return Validator.validateEmail(email);
          },
        ),
        AppUtil.defaultPadding,
        AppUtil.defaultPadding,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (Form.of(context)!.validate()) {}
                },
                child: const Text("Enviar")),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Voltar"),
                style: TextButton.styleFrom(backgroundColor: Colors.blueGrey))
          ],
        )
      ],
    );
  }
}
