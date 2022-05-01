import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/login/input_text_widget.dart';
import 'package:sistema_de_gestao_comercial/login/login_widget.dart';
import 'package:sistema_de_gestao_comercial/login/recover_password_widget.dart';
import 'package:sistema_de_gestao_comercial/login/signup_widget.dart';
import 'package:sistema_de_gestao_comercial/screens/main_screen_widget.dart';

enum OptionLogin { administracao, fatutracao }

// ignore: must_be_immutable
class SignIn extends StatefulWidget {
  SignIn({Key? key, required this.padding}) : super(key: key);

  final Padding padding;
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
        widget.padding,
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Login(
                      formBody: RecoverPassword(padding: widget.padding),
                      padding: widget.padding)));
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
        widget.padding,
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainScreen(
                              title: "Definiçoes",
                            )));
              },
              child: const Text("Entrar")),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Login(
                        formBody: SignUp(padding: widget.padding),
                        padding: widget.padding)));
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
