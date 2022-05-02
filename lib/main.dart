import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/login/login_widget.dart';
import 'package:sistema_de_gestao_comercial/login/signup_widget.dart';

import 'login/recover_password_widget.dart';
import 'login/signin_widget.dart';

void main() {
  runApp(const GestaoComercial());
}

class GestaoComercial extends StatelessWidget {
  const GestaoComercial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sistema de gestão comercial",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/signin",
      routes: {
        "/signin": (context) => Login(formBody: SignIn()),
        "/signup": (context) => const Login(formBody: SignUp()),
        "/recover-password": (context) =>
            const Login(formBody: RecoverPassword())
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
