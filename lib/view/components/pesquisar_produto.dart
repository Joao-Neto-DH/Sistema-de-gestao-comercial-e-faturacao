import 'package:flutter/material.dart';

// import '../../controller/produto_controller.dart';
// import '../../model/produto_model.dart';
// import '../../util.dart';

Widget pesquisarProduto(void Function() onPressed) {
  return ElevatedButton(onPressed: onPressed, child: const Text("Pesquisar"));
}
