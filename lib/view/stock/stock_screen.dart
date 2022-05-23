import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/model/produto_model.dart';
// import 'package:sistema_de_gestao_comercial/controller/stock_controller.dart';
// import 'package:sistema_de_gestao_comercial/dao/produto_dao.dart';
import 'package:sistema_de_gestao_comercial/validator.dart';
import 'package:sistema_de_gestao_comercial/view/empresa/empresa_screen.dart';

import '../../controller/produto_controller.dart';
import '../../util.dart';
import '../components/text_form_field_decorated.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final _nomeOrIDController = TextEditingController();
  var _produtos = <ProdutoModel>[];
  final _quantidadeController = TextEditingController();
  ProdutoModel? _produto;
  bool _stocavel = true;
  final samples = ["name", "body", "some"];
  String? _selected;
  @override
  void initState() {
    super.initState();
    if (_produtos.isNotEmpty) {
      _produto = _produtos[0];
    }

    _selected = samples[0];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
          const Text.rich(TextSpan(text: "Os campos marcados com (", children: [
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
            validator: Validator.validateName,
            controller: _nomeOrIDController,
          ),
          _found(),
          AppUtil.spaceFields,
          ElevatedButton(
              onPressed: () async {
                final controller = ProdutoController();
                try {
                  _produtos.clear();
                  _produtos =
                      await controller.produto(_nomeOrIDController.value.text);
                  // for (var produto in res) {
                  //   _produtos.add(ProdutoModel.fromMap(produto));
                  // }
                  setState(() {});
                } catch (e) {
                  AppUtil.snackBar(context, "Produto/Serviço nao encontrado");
                }
              },
              child: const Text("Pesquisar")),
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
            enabled: !_stocavel,
            hintText: "Adicionar novo Stock",
            keyboardType: TextInputType.number,
          ),
          AppUtil.spaceLabelField,
          ElevatedButton(
              onPressed: () {}, child: const Text("Dimininuir Stock")),
          AppUtil.spaceFields,
          ElevatedButton(
              onPressed: () {}, child: const Text("Adicionar Stock")),
        ],
      ),
    ));
  }

  Widget _found() {
    if (_produtos.isNotEmpty) {
      // final qtd = produtos[0]["stock"];

      // quantidade = !quantidade;
      if (_produtos.length > 1) {
        return DropdownButton<ProdutoModel>(
            // hint: const Text("Seleciona o cliente"),
            value: _produto,
            items: _produtos
                .map((e) => DropdownMenuItem(
                      child: Text(e.nome),
                      value: e,
                    ))
                .toList(),
            onChanged: (value) {
              // print(value);
              setState(() {
                _produto = value!;
              });
            });
      }
      _stocavel = _produtos[0].stock < 0;
      _quantidadeController.text =
          _stocavel ? "Produto nao estocavel" : _produtos[0].stock.toString();
      // print(qtd);
      return Text("Encontrados ${_produtos.length} produto/serviços(s)");
    }
    _quantidadeController.text = "";
    return const Text("Nenhum produto encontrado");
  }
}
