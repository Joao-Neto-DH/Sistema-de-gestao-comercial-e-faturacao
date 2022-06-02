import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_de_gestao_comercial/util.dart';
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

// ignore: must_be_immutable
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
        "/": (context) => const SplashScreen(),
        "/signin": (context) => Login(formBody: SignIn()),
        "/signup": (context) => Login(formBody: SignUp()),
        "/validate": (context) => const Senha(),
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

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  void _isValidate(BuildContext context) async {
    final shared = await SharedPreferences.getInstance();
    final psw = shared.getString("licenca");
    final date = shared.getString("tempo") ?? "";
    await Future.delayed(const Duration(microseconds: 5));
    if (psw == "C@ndimb@.5000" &&
        DateTime.now().toString().compareTo(date) < 0) {
      Navigator.pushReplacementNamed(context, "/signin");
    } else {
      Navigator.pushReplacementNamed(context, "/validate");
    }
  }

  @override
  Widget build(BuildContext context) {
    _isValidate(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Center(
        child: Image.asset(
          "assets/img/logo.png",
          width: MediaQuery.of(context).size.width / 2,
        ),
      ),
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
