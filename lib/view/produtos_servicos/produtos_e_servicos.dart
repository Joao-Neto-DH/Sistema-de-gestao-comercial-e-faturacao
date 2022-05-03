import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/util.dart';
import 'package:sistema_de_gestao_comercial/view/empresa/text_form_field_decorated.dart';

class ProdutosServicos extends StatefulWidget {
  const ProdutosServicos({Key? key}) : super(key: key);

  @override
  State<ProdutosServicos> createState() => _ProdutosServicosState();
}

class _ProdutosServicosState extends State<ProdutosServicos> {
  var _hasIVA = true;
  var _hasStock = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
          padding: AppUtil.paddingBody,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Produtos/Serviços",
                style: AppUtil.styleHeader,
                textAlign: TextAlign.center,
              ),
              const Divider(),
              const Text("Nome do produto/serviço"),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(hintText: "Nome do produto/serviço"),
              AppUtil.spaceFields,
              const Text("Preço do produto/serviço"),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Preço do produto/serviço",
                keyboardType: TextInputType.number,
              ),
              AppUtil.spaceFields,
              const Text("Referencia"),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Referencia",
              ),
              AppUtil.spaceFields,
              //checkboxes de IVA e Stock
              CheckboxListTile(
                  value: _hasIVA,
                  title: const Text("Incluir IVA de 14%"),
                  onChanged: (value) {
                    setState(() {
                      _hasIVA = !_hasIVA;
                    });
                  }),
              CheckboxListTile(
                  value: _hasStock,
                  title: const Text("Produto/Serviço com Stock"),
                  onChanged: (value) {
                    setState(() {
                      _hasStock = !_hasStock;
                    });
                  }),
              AppUtil.spaceFields,
              //Campo de quantidade de Stock
              const Text("Quantidade em Stock"),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                enabled: _hasStock,
                hintText: "Quantidade em Stock",
                keyboardType: TextInputType.number,
              ),
              AppUtil.spaceFields,
              ElevatedButton(onPressed: () {}, child: const Text("Salvar")),
              AppUtil.spaceLabelField,
              ElevatedButton(onPressed: () {}, child: const Text("Alterar")),
              AppUtil.spaceLabelField,
              ElevatedButton(onPressed: () {}, child: const Text("Eliminar")),
              AppUtil.spaceLabelField
            ],
          )),
    );
  }
}
