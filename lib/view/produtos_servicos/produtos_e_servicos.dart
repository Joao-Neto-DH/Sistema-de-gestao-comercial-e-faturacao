import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/controller/produto_controller.dart';
// import 'package:sistema_de_gestao_comercial/dao/produto_dao.dart';
import 'package:sistema_de_gestao_comercial/model/produto_model.dart';
import 'package:sistema_de_gestao_comercial/util.dart';
import 'package:sistema_de_gestao_comercial/validator.dart';
import 'package:sistema_de_gestao_comercial/view/components/dropdown_product.dart';
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

  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  final _qtdController = TextEditingController();

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
                controller: _nomeController,
                validator: Validator.validateName,
              ),
              AppUtil.spaceFields,
              const Text("Preço do produto/serviço"),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Preço do produto/serviço",
                keyboardType: TextInputType.number,
                controller: _precoController,
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
                controller: _qtdController,
                validator: (value) =>
                    _hasStock ? Validator.validateNotEmpty(value) : null,
              ),
              AppUtil.spaceFields,
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final controller = ProdutoController();
                      try {
                        var preco = double.parse(_precoController.value.text);
                        if (_hasIVA) preco += _addIVA(preco);
                        // print(preco);
                        await controller.cadastrarProduto(ProdutoModel(
                          nome: _nomeController.value.text,
                          preco: preco,
                          stock: _qtdController.value.text.isEmpty
                              ? -1
                              : int.parse(_qtdController.value.text),
                          iva: _hasIVA,
                        ));
                        AppUtil.snackBar(
                            context, "Produto/Serviço cadastrado com sucesso!");
                        formKey.currentState!.reset();
                        _clearFields();
                      } catch (e) {
                        AppUtil.snackBar(context,
                            "Erro ao cadastrar Produto/Serviço. Certifique-se o mesmo produto nao exista e tente novamente!");
                      }
                    }
                  },
                  child: const Text("Salvar")),
              // AppUtil.spaceLabelField,
              // ElevatedButton(onPressed: () {}, child: const Text("Alterar")),
              AppUtil.spaceLabelField,
              ElevatedButton(
                  onPressed: _eliminar, child: const Text("Eliminar")),
              AppUtil.spaceLabelField
            ],
          )),
    );
  }

  double _addIVA(double preco) {
    return preco * 0.14;
  }

  void _clearFields() {
    _nomeController.clear();
    _precoController.clear();
    _qtdController.clear();
  }

  void _eliminar() {
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => const DeleteProdutoSheet());
  }
}

class DeleteProdutoSheet extends StatefulWidget {
  const DeleteProdutoSheet({Key? key}) : super(key: key);

  @override
  State<DeleteProdutoSheet> createState() => _DeleteProdutoSheetState();
}

class _DeleteProdutoSheetState extends State<DeleteProdutoSheet> {
  _DeleteProdutoSheetState() {
    _load();
  }
  ProdutoModel? _produto;
  List<ProdutoModel>? _produtos;

  final _controller = ProdutoController();
  var _loading = true;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: const Text("Eliminar Produto/serviço"),
        titleTextStyle: const TextStyle(fontSize: 16.0, color: Colors.black),
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _loading
                      ? const Align(
                          child: CircularProgressIndicator(),
                          alignment: Alignment.center,
                        )
                      : dropdownProduct(_produtos!, _produto, (value) {
                          setState(() {
                            _produto = value!;
                          });
                        }),
                  AppUtil.spaceLabelField,
                  ElevatedButton(
                      onPressed: () async {
                        if (_produto == null) return;
                        final res = await _controller.delete(_produto!);
                        if (res > 0) {
                          AppUtil.snackBar(context,
                              "Produto/Serviço ${_produto!.nome} foi apagado!");
                          _produtos!.remove(_produto);
                          _produto = null;
                        }
                        setState(() {});
                      },
                      child: const Text("Eliminar")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Fechar"))
                ],
              ),
            ),
          ),
        ]);
  }

  void _load() async {
    _loading = true;
    _produtos = await _controller.all;
    if (_produtos!.isNotEmpty) {
      _produto = _produtos!.first;
    }
    setState(() {
      _loading = false;
    });
  }
}
