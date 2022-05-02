import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/util.dart';

/// Tela comum para os formularios de login
/// ao sistema
class Login extends StatelessWidget {
  /// formBody - Corpo do formulario
  /// padding - Espaço entre os itens do formulario
  const Login({Key? key, required this.formBody}) : super(key: key);
  final Widget formBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage("assets/img/background.png"),
                      alignment: Alignment.topCenter)),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/img/logo.png",
                        width: 250,
                      ),
                      AppUtil.defaultPadding,
                      const Text(
                        "SISTEMA DE GESTAO COMERCIAL E FATURAÇAO",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      AppUtil.defaultPadding,
                      formBody
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            "@Copyright - Candimba Tecnologia",
            textAlign: TextAlign.center,
          ),
        ));

    // return Scaffold(
    //     body: Container(
    //       decoration: const BoxDecoration(
    //           image: DecorationImage(
    //               image: AssetImage("img/background.png"),
    //               fit: BoxFit.fitWidth,
    //               alignment: Alignment.topCenter)),
    //       child: Container(
    //           margin: const EdgeInsets.all(32),
    //           child: Form(
    //             child: Column(
    //               children: [
    //                 Image.asset(
    //                   "img/logo.png",
    //                 ),
    //                 padding,
    //                 const Text(
    //                   "SISTEMA DE GESTAO COMERCIAL E FATURAÇAO",
    //                   textAlign: TextAlign.center,
    //                   style:
    //                       TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //                 ),
    //                 padding,
    //                 const Spacer(),
    //                 // const Text("Email"),
    //                 formBody,
    //                 // SignUp(),
    //                 const Spacer(),
    //               ],
    //             ),
    //           )),
    //     ),
    //     bottomNavigationBar: const Padding(
    //       padding: EdgeInsets.only(bottom: 18),
    //       child: Text(
    //         "@Copyright - Candimba Tecnologia",
    //         textAlign: TextAlign.center,
    //         style: TextStyle(fontSize: 12),
    //       ),
    //     ));
  }
}
