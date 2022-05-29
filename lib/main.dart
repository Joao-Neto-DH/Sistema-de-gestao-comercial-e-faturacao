import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:sistema_de_gestao_comercial/view/cliente/cliente_screen.dart';
import 'package:sistema_de_gestao_comercial/view/definicoes/definicoes_screen.dart';
import 'package:sistema_de_gestao_comercial/view/empresa/empresa_screen.dart';
import 'package:sistema_de_gestao_comercial/view/faturacao/faturacao_screen.dart';
import 'package:sistema_de_gestao_comercial/view/login/senha.dart';
import 'package:sistema_de_gestao_comercial/view/produtos_servicos/produtos_e_servicos.dart';
import 'package:sistema_de_gestao_comercial/view/stock/stock_screen.dart';
import 'view/login/login_widget.dart';
import 'view/login/signup_widget.dart';

import 'view/login/recover_password_widget.dart';
import 'view/login/signin_widget.dart';
import 'view/main_screen_widget.dart';

void main() {
  runApp(const GestaoComercial());
}

class GestaoComercial extends StatelessWidget {
  const GestaoComercial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ListView.builder()
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sistema de gestão comercial",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Login(formBody: Senha()),
        "/signin": (context) => Login(formBody: SignIn()),
        "/signup": (context) => Login(formBody: SignUp()),
        "/recover-password": (context) =>
            Login(formBody: const RecoverPassword()),
        "/empresa": (context) =>
            MainScreen(title: "Empresa", body: const EmpresaScreen()),
        "/produtos": (context) => MainScreen(
            title: "Produtos/Serviços", body: const ProdutosServicos()),
        "/clientes": (context) =>
            MainScreen(title: "Clientes", body: ClienteScreen()),
        "/definiçoes": (context) =>
            MainScreen(title: "Definiçoes", body: const DefinicoesScreen()),
        "/stock": (context) =>
            MainScreen(title: "Stock", body: const StockScreen()),
        "/faturacao": (context) =>
            MainScreen(title: "Faturaçao", body: const FaturacaoScreen())
      },
    );
  }
}

// class GestaoLogin extends StatelessWidget {
//   // final GlobalKey<FormState> _formKey = GlobalKey();

//   const GestaoLogin({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Login(
//       formBody: SignIn(
//         padding: _defaultPadding,
//       ),
//       padding: _defaultPadding,
//     );
//   }

  // void _optionLoginChange(OptionLogin value) {
  //   setState(() {
  //     _optionLogin = value;
  //   });
  // }
// }
