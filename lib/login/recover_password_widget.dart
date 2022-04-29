import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/login/input_text_widget.dart';

class RecoverPassword extends StatelessWidget {
  const RecoverPassword({Key? key, required this.padding}) : super(key: key);
  final Padding padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Digite o seu email para recuperar a senha"),
        padding,
        InputText(
            label: "EMAIL", validator: (email) => null, obscureText: false),
        padding,
        padding,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text("Enviar")),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Voltar"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.blueGrey)))
          ],
        )
      ],
    );
  }
}
