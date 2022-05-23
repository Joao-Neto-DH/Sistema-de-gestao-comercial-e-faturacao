import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

import '../../util.dart';

class DefinicoesScreen extends StatelessWidget {
  const DefinicoesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppUtil.paddingBody,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppUtil.spaceFields,
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/signup");
              },
              child: const Text("Cadastrar utilizador")),
          AppUtil.spaceFields,
          ElevatedButton(onPressed: () {}, child: const Text("Alterar senha")),
          AppUtil.spaceFields,
          ElevatedButton(onPressed: () {}, child: const Text("Alterar dados")),
        ],
      ),
    );
  }
}
