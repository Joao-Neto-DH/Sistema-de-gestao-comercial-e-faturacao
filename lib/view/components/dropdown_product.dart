import 'package:flutter/material.dart';

import '../../model/produto_model.dart';

Widget dropdownProduct(List<ProdutoModel> produtos, ProdutoModel? selected,
    void Function(ProdutoModel?) onChange) {
  if (produtos.isNotEmpty) {
    // final qtd = produtos[0]["stock"];

    // quantidade = !quantidade;
    // if (produtos.length > 1) {
    return DropdownButton<ProdutoModel>(
        hint: const Text("Selecionar"),
        value: selected,
        items: produtos
            .map((e) => DropdownMenuItem(
                  child: Text(e.nome),
                  value: e,
                ))
            .toList(),
        onChanged: onChange);
    // }
    // _stocavel = _produtos[0].stock < 0;
    // _quantidadeController.text =
    //     _stocavel ? "Produto nao estocavel" : _produtos[0].stock.toString();
    // print(qtd);
    // return Text("Encontrados ${produtos.length} produto/serviços(s)");
  }
  // _quantidadeController.text = "";
  return const Text("Nenhum produto encontrado");
}
