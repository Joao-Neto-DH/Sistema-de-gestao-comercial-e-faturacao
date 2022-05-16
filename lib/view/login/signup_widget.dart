import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/validator.dart';
import '../../dao/usuario_dao.dart';
import '../../model/usuario_model.dart';
import '../components/input_text_widget.dart';
import 'package:sistema_de_gestao_comercial/util.dart';

/// Tela de formulario de cadastro
class SignUp extends StatelessWidget {
  /// padding - espaço entre os itens do formulario
  SignUp({Key? key}) : super(key: key);
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nomeController = TextEditingController();

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
          controller: nomeController,
          validator: (nome) {
            return Validator.validateName(nome);
          },
        ),
        AppUtil.defaultPadding,
        InputText(
          label: "SENHA",
          controller: passwordController,
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
                passwordController.text, confirmPassword);
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
            onPressed: () async {
              if (Form.of(context)!.validate()) {
                try {
                  await _signup(UsuarioModel(
                      nome: nomeController.value.text,
                      email: emailController.value.text,
                      senha: passwordController.value.text));
                  AppUtil.snackBar(context, "Usuario criado com sucesso!");

                  nomeController.text = "";
                  emailController.text = "";
                  passwordController.text = "";
                  Form.of(context)!.reset();
                } catch (e) {
                  print(e);
                  var dao = UsuarioDAO();
                  print(await dao.all);
                  AppUtil.snackBar(context,
                      "Não foi possivel fazer o cadastro. Este Email ja esta a ser utilizado por outro usuario!");
                }
              }
            },
            child: const Text("Cadastrar"))
      ],
    );
  }

  Future<int> _signup(UsuarioModel usuario) async {
    var dao = UsuarioDAO();
    return await dao.insert(usuario);
  }
}
