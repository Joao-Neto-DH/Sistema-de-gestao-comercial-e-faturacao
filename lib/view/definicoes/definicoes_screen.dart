import 'package:flutter/material.dart';

import '../../util.dart';

class DefinicoesScreen extends StatelessWidget {
  const DefinicoesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
            onPressed: () {}, child: const Text("Cadastrar utilizador")),
        AppUtil.spaceFields,
        ElevatedButton(onPressed: () {}, child: const Text("Alterar senha")),
        AppUtil.spaceFields,
        ElevatedButton(onPressed: () {}, child: const Text("Alterar dados")),
      ],
    );
  }
}
