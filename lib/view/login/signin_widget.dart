import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/validator.dart';
import 'package:sistema_de_gestao_comercial/view/dao/usuario_dao.dart';
import 'package:sistema_de_gestao_comercial/view/model/usuario_model.dart';
import '../components/input_text_widget.dart';
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
        // const Text("Senha"),
        InputText(
            label: "SENHA",
            controller: passwordController,
            validator: (password) {
              return Validator.validatePassword(password);
            },
            obscureText: true),
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
              onPressed: () async {
                if (Form.of(context)!.validate()) {
                  // if (widget._optionLogin == OptionLogin.fatutracao) {
                  //   Navigator.pushReplacementNamed(context, "/faturacao");
                  // } else {
                  //   Navigator.pushReplacementNamed(context, "/empresa");
                  // }
                  var map = await _login(UsuarioModel(
                      email: emailController.value.text,
                      senha: passwordController.value.text));
                  print(map);
                }
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

  Future<Map<String, Object?>> _login(UsuarioModel usuario) async {
    var dao = UsuarioDAO();
    var map = await dao.getUsuario(usuario);
    return map[0];
  }

  void _optionLoginChange(OptionLogin value) {
    setState(() {
      widget._optionLogin = value;
    });
  }
}
