import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/login/input_text_widget.dart';
import 'package:sistema_de_gestao_comercial/login/login_widget.dart';
import 'package:sistema_de_gestao_comercial/login/recover_password_widget.dart';
import 'package:sistema_de_gestao_comercial/login/signup_widget.dart';
import 'package:sistema_de_gestao_comercial/screens/main_screen_widget.dart';
import 'package:sistema_de_gestao_comercial/util.dart';

import '../screens/empresa/empresa_screen.dart';

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
        InputText(
            label: "EMAIL", validator: (email) => null, obscureText: false),
        AppUtil.defaultPadding,
        // const Text("Senha"),
        InputText(
            label: "SENHA", validator: (senha) => null, obscureText: true),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainScreen(
                              title: "Empresa",
                              body: EmpresaScreen(),
                            )));
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
