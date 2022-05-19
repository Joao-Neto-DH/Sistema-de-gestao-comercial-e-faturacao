import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/controller/stock_controller.dart';
import 'package:sistema_de_gestao_comercial/dao/produto_dao.dart';
import 'package:sistema_de_gestao_comercial/validator.dart';
import 'package:sistema_de_gestao_comercial/view/empresa/empresa_screen.dart';

import '../../util.dart';
import '../components/text_form_field_decorated.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final nomeController = TextEditingController();
  List<Map<String, Object?>> produtos = [];

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
            hintText: "Nome do produto/serviço",
            validator: Validator.validateName,
            controller: nomeController,
          ),
          _found(),
          AppUtil.spaceFields,
          ElevatedButton(
              onPressed: () async {
                final controller = StockController();
                try {
                  produtos =
                      await controller.produto(nomeController.value.text);
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
            initialValue: "12",
            enabled: false,
          ),
          AppUtil.spaceFields,
          const Text(
            "Adicionar novo Stock",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "Adicionar novo Stock",
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
    if (produtos.isNotEmpty) {
      return Text("Encontrados ${produtos.length} produto/serviços(s)");
    }
    return const Text("");
  }
}
