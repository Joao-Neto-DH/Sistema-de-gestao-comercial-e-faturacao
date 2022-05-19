import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/controller/produto_controller.dart';
// import 'package:sistema_de_gestao_comercial/dao/produto_dao.dart';
import 'package:sistema_de_gestao_comercial/model/produto_model.dart';
import 'package:sistema_de_gestao_comercial/util.dart';
import 'package:sistema_de_gestao_comercial/validator.dart';
import '../components/text_form_field_decorated.dart';

class ProdutosServicos extends StatefulWidget {
  const ProdutosServicos({Key? key}) : super(key: key);

  @override
  State<ProdutosServicos> createState() => _ProdutosServicosState();
}

class _ProdutosServicosState extends State<ProdutosServicos> {
  var _hasIVA = true;
  var _hasStock = true;
  final formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final precoController = TextEditingController();
  final qtdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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

              TextFormFieldDecorated(
                hintText: "Nome do produto/serviço",
                controller: nomeController,
                validator: Validator.validateName,
              ),
              AppUtil.spaceFields,
              const Text("Preço do produto/serviço"),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Preço do produto/serviço",
                keyboardType: TextInputType.number,
                controller: precoController,
                validator: Validator.validateNotEmpty,
              ),
              AppUtil.spaceFields,
              const Text("Referencia"),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Referencia",
                enabled: false,
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
                controller: qtdController,
                validator: (value) =>
                    _hasStock ? Validator.validateNotEmpty(value) : null,
              ),
              AppUtil.spaceFields,
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final controller = ProdutoController();
                      try {
                        await controller.cadastrarProduto(ProdutoModel(
                          nome: nomeController.value.text,
                          preco: double.parse(precoController.value.text),
                          stock: qtdController.value.text.isEmpty
                              ? -1
                              : int.parse(qtdController.value.text),
                          iva: _hasIVA,
                        ));
                        AppUtil.snackBar(
                            context, "Produto/Serviço cadastrado com sucesso!");
                      } catch (e) {
                        AppUtil.snackBar(context,
                            "Erro ao cadastrar Produto/Serviço. Certifique-se o mesmo produto nao exista e tente novamente!");
                      }
                    }
                  },
                  child: const Text("Salvar")),
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
