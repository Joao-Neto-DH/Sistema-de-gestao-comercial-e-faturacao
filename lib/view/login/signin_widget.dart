import 'package:flutter/material.dart';
import './input_text_widget.dart';
// import './login_widget.dart';
// import './recover_password_widget.dart';
// import './signup_widget.dart';
// import '../../view/main_screen_widget.dart';
import '../../util.dart';

// import '../empresa/empresa_screen.dart';

/// Representa as opçoes de submissao de login
enum OptionLogin { administracao, fatutracao }

/// Tela de login
// ignore: must_be_immutable
class SignIn extends StatefulWidget {
  /// padding - Espaço entre os  itens do formulario
  SignIn({Key? key}) : super(key: key);

  OptionLogin _optionLogin = OptionLogin.administracao;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputText(label: "EMAIL"),
        AppUtil.defaultPadding,
        // const Text("Senha"),
        InputText(label: "SENHA", obscureText: true),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            child: const Text("Esqueci a minha senha",
                style: TextStyle(
                  color: Colors.blueGrey,
                )),
            onTap: () {
              Navigator.pushNamed(context, "/recover-password");
            },
          ),
        ),
        RadioListTile<OptionLogin>(
          value: OptionLogin.administracao,
          groupValue: widget._optionLogin,
          onChanged: (value) {
            _optionLoginChange(value!);
          },
          title: const Text(
            "Administração",
          ),
          contentPadding: EdgeInsets.zero,
        ),
        RadioListTile<OptionLogin>(
          value: OptionLogin.fatutracao,
          groupValue: widget._optionLogin,
          onChanged: (value) {
            _optionLoginChange(value!);
          },
          title: const Text("Faturação"),
          contentPadding: EdgeInsets.zero,
        ),
        AppUtil.defaultPadding,
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/empresa");
              },
              child: const Text("Entrar")),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/signup");
              },
              child: const Text("Criar Conta"),
              style: TextButton.styleFrom(backgroundColor: Colors.blueGrey)),
        ]),
      ],
    );
  }

  void _optionLoginChange(OptionLogin value) {
    setState(() {
      widget._optionLogin = value;
    });
  }
}
