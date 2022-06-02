import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/model/produto_model.dart';
// import 'package:sistema_de_gestao_comercial/controller/stock_controller.dart';
// import 'package:sistema_de_gestao_comercial/dao/produto_dao.dart';
// import 'package:sistema_de_gestao_comercial/validator.dart';
import 'package:sistema_de_gestao_comercial/view/empresa/empresa_screen.dart';

import '../../controller/produto_controller.dart';
import '../../util.dart';
import '../components/dropdown_product.dart';
import '../components/pesquisar_produto.dart';
import '../components/text_form_field_decorated.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  _StockScreenState() {
    onPesquisarProduto();
  }

  var _produtos = <ProdutoModel>[];
  final _nomeOrIDController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _newQuantidadeController = TextEditingController();
  ProdutoModel? _produto;
  final key = GlobalKey<FormState>();
  // bool _stocavel = true;
  @override
  void initState() {
    super.initState();
    if (_produtos.isNotEmpty) {
      _produto = _produtos[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: key,
        child: SingleChildScrollView(
          padding: AppUtil.paddingBody,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "GERENCIAR STOCK",
                textAlign: TextAlign.center,
                style: AppUtil.styleHeader,
              ),
              AppUtil.spaceLabelField,
              const Text.rich(
                  TextSpan(text: "Os campos marcados com (", children: [
                TextSpan(text: "*", style: TextStyle(color: Colors.red)),
                TextSpan(text: ") sao obrigatorios")
              ])),
              AppUtil.spaceFields,
              const Text(
                "Filtrar produto/serviço",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Nome ou id do produto/serviço",
                // validator: Validator.validateName,
                controller: _nomeOrIDController,
              ),
              dropdownProduct(
                _produtos,
                _produto,
                ((value) => setState(() {
                      _produto = value;
                      _quantidadeController.text = _produto!.stock.toString();
                    })),
              ),
              AppUtil.spaceFields,
              pesquisarProduto(onPesquisarProduto),
              AppUtil.spaceLabelField,
              const HorizontalDividerWithLabel(
                  label: "Detalhes do Produto/Serviço"),
              AppUtil.spaceLabelField,
              const Text(
                "Quantidade em Stock",
                textAlign: TextAlign.left,
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                controller: _quantidadeController,
                enabled: false,
              ),
              AppUtil.spaceFields,
              const Text(
                "Adicionar novo Stock",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                enabled: _produto == null ? false : _produto!.stock > 0,
                hintText: "Adicionar novo Stock",
                keyboardType: TextInputType.number,
                controller: _newQuantidadeController,
                validator: (value) {
                  if (int.tryParse(value!) == null) {
                    return "Este nao e um numero valido";
                  }
                  return null;
                },
              ),
              AppUtil.spaceLabelField,
              ElevatedButton(
                  onPressed: () async {
                    if (_produto == null) {
                      AppUtil.snackBar(context,
                          "Nenhum produto selecionado. Por favor selecione um produto e tente novamente!");
                      return;
                    } else if (_produto!.stock < 0) {
                      AppUtil.snackBar(context,
                          "Este produto nao e estocavel. Por favor selecione um produto que possua estoque e tente novamente!");
                      return;
                    }

                    if (key.currentState!.validate()) {
                      final newValue =
                          int.parse(_newQuantidadeController.value.text);
                      if (newValue < 0 || _produto!.stock < newValue) {
                        AppUtil.snackBar(context,
                            "A quantidade a ser reduzida nao pode ser maior que a quantidade actual em Stock nem menor que zero.\nPor favor digite uma nova quantidade valida!");
                        return;
                      }
                      final controller = ProdutoController();
                      _produto!.stock = _produto!.stock - newValue;
                      try {
                        await controller.update(_produto!);
                        AppUtil.snackBar(context,
                            "Nova quantidade actualizada com sucesso!");
                        setState(() {
                          _quantidadeController.text =
                              _produto!.stock.toString();
                        });
                      } catch (e) {
                        AppUtil.snackBar(context,
                            "Ocorreu um erro ao atribuir a nova quantidade!");
                      }
                    }
                  },
                  child: const Text("Dimininuir Stock")),
              AppUtil.spaceFields,
              ElevatedButton(
                  onPressed: () async {
                    if (_produto == null) {
                      AppUtil.snackBar(context,
                          "Nenhum produto selecionado. Por favor selecione um produto e tente novamente!");
                      return;
                    } else if (_produto!.stock < 0) {
                      AppUtil.snackBar(context,
                          "Este produto nao e estocavel. Por favor selecione um produto que possua estoque e tente novamente!");
                      return;
                    }

                    if (key.currentState!.validate()) {
                      final newValue =
                          int.parse(_newQuantidadeController.value.text);
                      if (newValue < 0) {
                        AppUtil.snackBar(context,
                            "A quantidade a ser adicionada nao pode ser menor que zero.\nPor favor digite uma nova quantidade valida!");
                        return;
                      }
                      final controller = ProdutoController();
                      _produto!.stock = _produto!.stock + newValue;
                      try {
                        await controller.update(_produto!);
                        AppUtil.snackBar(context,
                            "Nova quantidade actualizada com sucesso!");
                        setState(() {
                          _quantidadeController.text =
                              _produto!.stock.toString();
                        });
                      } catch (e) {
                        AppUtil.snackBar(context,
                            "Ocorreu um erro ao atribuir a nova quantidade!");
                      }
                    }
                  },
                  child: const Text("Adicionar Stock")),
            ],
          ),
        ));
  }

  void onPesquisarProduto() async {
    final controller = ProdutoController();
    try {
      _produtos.clear();
      _produtos = await controller.produto(_nomeOrIDController.value.text);
      // for (var produto in res) {
      //   _produtos.add(ProdutoModel.fromMap(produto));
      // }
      // setState(() {});
      if (_produtos.isNotEmpty) {
        _produto = _produtos[0];
        _quantidadeController.text = _produto!.stock.toString();
      } else {
        _quantidadeController.text = "";
      }
      setState(() {});
    } catch (e) {
      AppUtil.snackBar(context, "Produto/Serviço nao encontrado");
    }
  }

  // Widget _found() {
  //   if (_produtos.isNotEmpty) {
  //     // final qtd = produtos[0]["stock"];
  //     // quantidade = !quantidade;
  //     if (_produtos.length > 1) {
  //       return DropdownButton<ProdutoModel>(
  //           // hint: const Text("Seleciona o cliente"),
  //           value: _produto,
  //           items: _produtos
  //               .map((e) => DropdownMenuItem(
  //                     child: Text(e.nome),
  //                     value: e,
  //                   ))
  //               .toList(),
  //           onChanged: (value) {
  //             // print(value);
  //             setState(() {
  //               _produto = value!;
  //             });
  //           });
  //     }
  //     _stocavel = _produtos[0].stock < 0;
  //     _quantidadeController.text =
  //         _stocavel ? "Produto nao estocavel" : _produtos[0].stock.toString();
  //     // print(qtd);
  //     return Text("Encontrados ${_produtos.length} produto/serviços(s)");
  //   }
  //   _quantidadeController.text = "";
  //   return const Text("Nenhum produto encontrado");
  // }
}
