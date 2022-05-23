import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/model/produto_model.dart';
import 'package:sistema_de_gestao_comercial/pdf.dart';
import 'package:sistema_de_gestao_comercial/util.dart';
import 'package:sistema_de_gestao_comercial/view/components/dropdown_product.dart';
import 'package:sistema_de_gestao_comercial/view/components/pesquisar_produto.dart';
import 'package:sistema_de_gestao_comercial/view/components/text_form_field_decorated.dart';
import 'package:sistema_de_gestao_comercial/view/empresa/empresa_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../controller/produto_controller.dart';

class FaturacaoScreen extends StatefulWidget {
  const FaturacaoScreen({Key? key}) : super(key: key);

  @override
  State<FaturacaoScreen> createState() => _FaturacaoScreenState();
}

class _FaturacaoScreenState extends State<FaturacaoScreen> {
  final _itens = <Widget>[];
  final samples = ["Arroz", "Massa", "Peixe"];
  var _selected = "Arroz";
  var _produtos = <ProdutoModel>[];
  ProdutoModel? _produto;

  final TextEditingController? _produtoNomeIdController =
      TextEditingController();
  final _quantidadeController = TextEditingController();
  @override
  // void initState() {
  //   super.initState();
  //   _selected = samples[0];
  // }

  // var nomes = ["Primeiro", "Segundo"];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppUtil.paddingBody,
      child: Column(
        children: [
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Selecionar cliente"),
                AppUtil.spaceLabelField,
                TextFormFieldDecorated(
                  hintText: "Selecione um cliente",
                ),
                DropdownButton(
                    // hint: const Text("Seleciona o cliente"),
                    value: _selected,
                    items: samples
                        .map((e) => DropdownMenuItem<String>(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) {
                      // print(value);
                      _selected = value as String;
                      setState(() {});
                    }),
                AppUtil.spaceFields,
                const HorizontalDividerWithLabel(
                    label: "Dados do produto/serviço"),
                AppUtil.spaceFields,
                const Text("Selecionar produto/serviço"),
                AppUtil.spaceLabelField,
                TextFormFieldDecorated(
                  controller: _produtoNomeIdController,
                  hintText: "Selecione produto/serviço",
                ),
                // Seleciona o produto
                dropdownProduct(_produtos, _produto, (value) {
                  setState(() {
                    _produto = value;
                    _quantidadeController.text = "";
                  });
                }),
                Row(
                  children: [
                    Expanded(child: pesquisarProduto(() async {
                      final controller = ProdutoController();
                      try {
                        _produtos.clear();
                        _produtos = await controller
                            .produto(_produtoNomeIdController!.value.text);
                        // for (var produto in res) {
                        //   _produtos.add(ProdutoModel.fromMap(produto));
                        // }
                        // setState(() {});
                        if (_produtos.isNotEmpty) {
                          _produto = _produtos[0];
                        }
                        setState(() {});
                      } catch (e) {
                        AppUtil.snackBar(
                            context, "Produto/Serviço nao encontrado");
                      }
                    })),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // Expanded(
                    //     child: ElevatedButton(
                    //         onPressed: () {}, child: const Text("Selecionar")))
                  ],
                ),
                AppUtil.spaceFields,
                const Text("Insira a quantidade a ser vendida"),
                AppUtil.spaceLabelField,
                TextFormFieldDecorated(
                  enabled: _produto != null && _produto!.stock > 0,
                  controller: _quantidadeController,
                  hintText: "Digitar a quantidade",
                  keyboardType: TextInputType.number,
                ),
                AppUtil.spaceFields,
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_produto != null) {
                          final qtd =
                              int.tryParse(_quantidadeController.value.text) ??
                                  1;

                          if (_produto!.stock != -1 &&
                              (_produto!.stock < qtd || qtd < 0)) {
                            AppUtil.snackBar(context,
                                "Quantidade digitada nao pode ser maior que a quantidade em Stock nem menor que 0");
                            return;
                          }
                          final item = ProdutoItem(
                            produto: _produto!,
                            qtd: qtd,
                          );
                          item.onDeletePressed = () {
                            setState(() {
                              _itens.remove(item);
                            });
                          };
                          setState(() {
                            _itens.add(item);
                            _produto = null;
                          });
                        } else {
                          AppUtil.snackBar(
                              context, "Nenhum produto selecionado");
                        }
                      },
                      child: const Text("Adicionar a fatura")),
                ),
                AppUtil.spaceFields,
                const HorizontalDividerWithLabel(
                    label: "Produtos/serviços listados"),
                AppUtil.spaceFields,
              ],
            ),
          ),
          _itens.isEmpty ? _listaVazia() : _lista(),
          AppUtil.spaceLabelField,
          if (_itens.isNotEmpty)
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: () async {
                    var status = await Permission.storage.status;
                    if (status.isDenied) {
                      status = await Permission.storage.request();
                    } else if (status.isPermanentlyDenied) {
                      openAppSettings();
                    }
                    if (!status.isDenied && !status.isPermanentlyDenied) {
                      final pdf = PDFGenerator(_itens);
                      pdf.addPage();
                      await pdf.save();
                      // print(await file.exists());
                      AppUtil.snackBar(context, "Fatura salva com sucesso!");
                    }
                  },
                  child: const Text("Faturar")),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(onPressed: () {}, child: const Text("Cancelar"))
            ])
        ],
      ),
    );
  }

  Center _listaVazia() =>
      const Center(child: Text("Nenhum produto adicionado"));

  double _precoTotal() {
    if (_itens.isEmpty) {
      return 0;
    }

    var valor = 0.0;
    for (var item in _itens) {
      final it = item as ProdutoItem;
      valor += it.qtd * it.produto.preco;
    }
    return valor;
  }

  Container _lista() => Container(
      color: const Color.fromARGB(10, 0, 0, 0),
      child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Text("Total: ${_precoTotal().toStringAsFixed(2)}Kz"),
        ),
        Column(
          children: _itens,
        )
      ]));
}

class ProdutoItem extends StatefulWidget {
  ProdutoItem({Key? key, required this.produto, this.qtd = 0})
      : super(key: key);
  final ProdutoModel produto;
  void Function()? onDeletePressed;
  int qtd;
  @override
  State<ProdutoItem> createState() => _ProdutoItemState();
}

class _ProdutoItemState extends State<ProdutoItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: true,
      title: Text(widget.produto.nome),
      subtitle: Text(
          "${widget.produto.preco}Kz ${widget.qtd >= 0 ? "- " + widget.qtd.toString() : ""}"),
      trailing: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (widget.produto.stock != -1 &&
                      widget.qtd < widget.produto.stock) {
                    widget.qtd++;
                  }
                });
              },
              icon: const Icon(
                Icons.add,
                semanticLabel: "Adicionar quantidade",
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  if (widget.produto.stock != -1 && widget.qtd > 1) {
                    widget.qtd--;
                  }
                });
              },
              icon: const Icon(Icons.reduce_capacity),
            ),
            IconButton(
              onPressed: widget.onDeletePressed,
              icon: const Icon(Icons.restore_from_trash),
            ),
          ],
        ),
      ),
    );
  }
}
