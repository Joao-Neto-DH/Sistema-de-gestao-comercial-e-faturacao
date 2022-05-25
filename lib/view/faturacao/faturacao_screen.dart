import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistema_de_gestao_comercial/controller/cliente_controller.dart';
import 'package:sistema_de_gestao_comercial/controller/empresa_controller.dart';
import 'package:sistema_de_gestao_comercial/model/cliente_model.dart';
import 'package:sistema_de_gestao_comercial/model/empresa_model.dart';
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
  var _clientes = <ClienteModel>[];
  ClienteModel? _cliente;
  var _produtos = <ProdutoModel>[];
  ProdutoModel? _produto;
  var _empresas = <EmpresaModel>[];
  EmpresaModel? _empresa;
  final _pagamentos = [
    "Cash",
    "Multicaixa",
    "Transferencia",
    "Deposito",
    "Pagamento Duplo"
  ];
  String? _pagamento;

  final TextEditingController? _produtoNomeIdController =
      TextEditingController();
  final _quantidadeController = TextEditingController();
  final _clienteController = TextEditingController();
  final _empresaController = TextEditingController();
  final _pagamentoController = TextEditingController();
  final format = NumberFormat.simpleCurrency(locale: "pt_BR");
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Selecionar Empresa"),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                controller: _empresaController,
                hintText: "Selecione uma Empresa",
              ),
              AppUtil.spaceLabelField,
              DropdownButton<EmpresaModel>(
                  // hint: const Text("Seleciona o cliente"),
                  value: _empresa,
                  items: _empresas
                      .map((e) => DropdownMenuItem(
                            child: Text(e.nome),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    // print(value);
                    setState(() {
                      _empresa = value;
                    });
                  }),
              // AppUtil.spaceFields,s
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final controller = EmpresaController();
                        _empresas = await controller
                            .getEmpresa(_empresaController.value.text);
                        // print(res);
                        if (_empresas.isNotEmpty) {
                          _empresa = _empresas[0];
                        } else {
                          _empresa = null;
                        }
                        setState(() {});
                      },
                      child: const Text("Pesquisar"),
                    ),
                  ),
                ],
              ),
              AppUtil.spaceLabelField,
              const HorizontalDividerWithLabel(label: "Dados do cliente"),
              AppUtil.spaceFields,
              //Empresa
              const Text("Selecionar cliente"),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                controller: _clienteController,
                hintText: "Selecione um cliente",
              ),
              AppUtil.spaceLabelField,
              DropdownButton<ClienteModel>(
                  // hint: const Text("Seleciona o cliente"),
                  value: _cliente,
                  items: _clientes
                      .map((e) => DropdownMenuItem(
                            child: Text(e.nome),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    // print(value);
                    _cliente = value;
                    setState(() {});
                  }),
              // AppUtil.spaceFields,s
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onPesquisarCliente,
                      child: const Text("Pesquisar"),
                    ),
                  ),
                ],
              ),
              AppUtil.spaceLabelField,
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
                  Expanded(child: pesquisarProduto(onPesquisarProduto)),
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
              DropdownButton<String>(
                  hint: const Text("Forma de Pagamento"),
                  value: _pagamento,
                  items: _pagamentos
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _pagamento = value!;
                    });
                  }),
              AppUtil.spaceFields,
              Form(
                  child: Column(
                children: [
                  TextFormFieldDecorated(
                    controller: _pagamentoController,
                    keyboardType: TextInputType.number,
                    onChange: (value) {
                      setState(() {});
                    },
                    hintText: "Valor Entregue",
                    enabled: _pagamentos[1] != _pagamento,
                  ),
                  AppUtil.spaceFields,
                  TextFormFieldDecorated(
                    keyboardType: TextInputType.number,
                    hintText: _pagamentos[1] == _pagamento ||
                            _pagamentos[4] == _pagamento
                        ? _precoTotal().toString()
                        : "Multicaixa",
                    enabled: _pagamentos[4] == _pagamento,
                  ),
                  AppUtil.spaceFields,
                  TextFormFieldDecorated(
                    keyboardType: TextInputType.number,
                    hintText: format.format((_pago() - _precoTotal())),
                    enabled: false,
                  ),
                ],
              )),
              AppUtil.spaceFields,
              Center(
                child: ElevatedButton(
                    onPressed: onAddLista,
                    child: const Text("Adicionar a fatura")),
              ),
              AppUtil.spaceFields,
              const HorizontalDividerWithLabel(
                  label: "Produtos/serviços listados"),
              AppUtil.spaceFields,
            ],
          ),
          _itens.isEmpty ? _listaVazia() : _lista(),
          AppUtil.spaceLabelField,
          if (_itens.isNotEmpty)
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: onFaturar, child: const Text("Faturar")),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _itens.clear();
                    });
                  },
                  child: const Text("Apagar Lista"))
            ])
        ],
      ),
    );
  }

  double _pago() {
    // print(double.tryParse(_pagamentoController.value.text));
    var value = double.tryParse(
            _pagamentoController.value.text.replaceFirst(RegExp(r','), '.')) ??
        0;

    return value;
  }

  void onPesquisarCliente() async {
    final controller = ClienteController();
    final res =
        await controller.getClienteByNomeOrId(_clienteController.value.text);
    _clientes = res;
    if (res.isNotEmpty) {
      _cliente = _clientes[0];
    } else {
      _cliente = null;
    }
    setState(() {});
  }

  void onPesquisarProduto() async {
    final controller = ProdutoController();
    try {
      _produtos.clear();
      _produtos =
          await controller.produto(_produtoNomeIdController!.value.text);
      // for (var produto in res) {
      //   _produtos.add(ProdutoModel.fromMap(produto));
      // }
      // setState(() {});
      if (_produtos.isNotEmpty) {
        _produto = _produtos[0];
      }
      setState(() {});
    } catch (e) {
      AppUtil.snackBar(context, "Produto/Serviço nao encontrado");
    }
  }

  void onAddLista() {
    if (_produto != null) {
      final qtd = int.tryParse(_quantidadeController.value.text) ?? 1;

      if (_produto!.stock != -1 && (_produto!.stock < qtd || qtd < 0)) {
        AppUtil.snackBar(context,
            "Quantidade digitada nao pode ser maior que a quantidade em Stock nem menor que 0");
        return;
      }
      final item = ProdutoItem(
        produto: _produto!,
        state: setState,
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
      AppUtil.snackBar(context, "Nenhum produto selecionado");
    }
  }

  void onFaturar() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      status = await Permission.storage.request();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    if (!status.isDenied && !status.isPermanentlyDenied) {
      if (_empresa != null) {
        final pdf = PDFGenerator(_itens,
            cliente: _cliente ??
                ClienteModel(
                    nome: "Cliente Diversos",
                    nif: "99999999",
                    endereco: "Diversos",
                    email: "Diversos",
                    credito: 0),
            empresa: _empresa!);
        pdf.addPage();
        await pdf.save();
        // print(await file.exists());
        AppUtil.snackBar(context, "Fatura salva com sucesso!");
        return;
      }
      AppUtil.snackBar(context,
          "Nenhuma empresa selecionada! Por favor selecione uma empresa para faturar");
    } else {
      AppUtil.snackBar(context,
          "O aplicativo nao tem permissao de acessar o armazenamento. Por Favor de permissao para poder continuar");
    }
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

// ignore: must_be_immutable
class ProdutoItem extends StatefulWidget {
  ProdutoItem(
      {Key? key, required this.produto, required this.state, this.qtd = 0})
      : super(key: key);
  final ProdutoModel produto;
  void Function()? onDeletePressed;
  void Function(VoidCallback fn) state;
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
                    widget.state(() {});
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
                    widget.state(() {});
                  }
                });
              },
              icon: const Icon(Icons.minimize),
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

class Pagamento {
  String tipo;
  double cashValor;
  double? multicaixaValor;
  Pagamento(
      {required this.tipo, required this.cashValor, this.multicaixaValor});
}
