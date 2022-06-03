import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/controller/cliente_controller.dart';
import 'package:sistema_de_gestao_comercial/controller/empresa_controller.dart';
import 'package:sistema_de_gestao_comercial/model/cliente_model.dart';
import 'package:sistema_de_gestao_comercial/model/empresa_model.dart';
import 'package:sistema_de_gestao_comercial/model/produto_model.dart';
import 'package:sistema_de_gestao_comercial/pdf.dart';
import 'package:sistema_de_gestao_comercial/util.dart';
import 'package:sistema_de_gestao_comercial/validator.dart';
import 'package:sistema_de_gestao_comercial/view/components/dropdown_product.dart';
import 'package:sistema_de_gestao_comercial/view/components/pesquisar_produto.dart';
import 'package:sistema_de_gestao_comercial/view/components/text_form_field_decorated.dart';
import 'package:sistema_de_gestao_comercial/view/empresa/empresa_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../controller/produto_controller.dart';

enum FormaPagamento {
  cash,
  multicaixa,
  transferencia,
  deposito,
  duplo,
}

class FaturacaoScreen extends StatefulWidget {
  const FaturacaoScreen({Key? key}) : super(key: key);

  @override
  State<FaturacaoScreen> createState() => _FaturacaoScreenState();
}

class _FaturacaoScreenState extends State<FaturacaoScreen> {
  _FaturacaoScreenState() {
    onPesquisarCliente();
    onPesquisarEmpresa();
    onPesquisarProduto();
  }

  final _itens = <Widget>[];
  var _clientes = <ClienteModel>[];
  ClienteModel? _cliente;
  var _produtos = <ProdutoModel>[];
  ProdutoModel? _produto;
  var _empresas = <EmpresaModel>[];
  EmpresaModel? _empresa;
  // final _pagamentos = [
  //   "Cash",
  //   "Multicaixa",
  //   "Transferencia",
  //   "Deposito",
  //   "Pagamento Duplo"
  // ];
  FormaPagamento? _pagamento;

  final _produtoNomeIdController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _clienteController = TextEditingController();
  final _empresaController = TextEditingController();
  final _cashController = TextEditingController();
  final _multicaixaController = TextEditingController();
  final _validateForm = GlobalKey<FormState>();

  final _produtoNome = TextEditingController();
  final _produtoPreco = TextEditingController();
  final _produtoQuantidade = TextEditingController();

  var _faturando = false;
  var _isDB = true;

  var _hasIVA = true;

  // @override
  // void initState() {
  //   super.initState();
  //   _selected = samples[0];
  // }

  // var nomes = ["Primeiro", "Segundo"];
  @override
  Widget build(BuildContext context) {
    _upadatePreco();
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
                hintText: "Pesquisar Empresa",
              ),
              AppUtil.spaceLabelField,
              if (_empresas.isNotEmpty)
                DropdownButton<EmpresaModel>(
                    isExpanded: true,
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
                      onPressed: onPesquisarEmpresa,
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
                hintText: "Pesquisar cliente",
              ),
              AppUtil.spaceLabelField,
              if (_clientes.isNotEmpty)
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
              CheckboxListTile(
                  title: const Text("Carregar produto/serviço cadastrado"),
                  value: _isDB,
                  onChanged: (value) => setState(() {
                        _isDB = !_isDB;
                      })),
              if (!_isDB) _insertProduto(),
              AppUtil.spaceLabelField,
              if (_isDB)
                TextFormFieldDecorated(
                  controller: _produtoNomeIdController,
                  hintText: "Pesquisar produto/serviço",
                ),
              // Seleciona o produto
              if (_isDB)
                dropdownProduct(_produtos, _produto, (value) {
                  setState(() {
                    _produto = value;
                    _quantidadeController.text = "";
                  });
                }),
              const Text("Insira a quantidade a ser vendida"),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                enabled: _produto != null && _produto!.stock > 0,
                controller: _quantidadeController,
                hintText: "Digitar a quantidade",
                keyboardType: TextInputType.number,
              ),
              AppUtil.spaceFields,
              Row(
                children: [
                  Expanded(child: pesquisarProduto(onPesquisarProduto)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: onAddLista,
                        child: const Text("Adicionar a fatura")),
                  ),
                  // Expanded(
                  //     child: ElevatedButton(
                  //         onPressed: () {}, child: const Text("Selecionar")))
                ],
              ),
              AppUtil.spaceFields,
              DropdownButton<FormaPagamento>(
                  hint: const Text("Forma de Pagamento"),
                  value: _pagamento,
                  items: FormaPagamento.values
                      .map((e) => DropdownMenuItem(
                            child: Text(e.name.toUpperCase()),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _pagamento = value!;
                      // _upadatePreco();
                    });
                  }),
              AppUtil.spaceFields,
              _formPagamento(),
              // AppUtil.spaceFields,

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
                  onPressed: () {
                    showModalBottomSheet(
                      // enableDrag: false,
                      context: context,
                      builder: _modalBottomSheetContent,
                    );
                    /*onFaturar */
                  },
                  child: const Text("Faturar")),
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
            ]),
          if (_faturando) const CircularProgressIndicator()
        ],
      ),
    );
  }

  void _upadatePreco() {
    if (_pagamento != FormaPagamento.cash &&
        _pagamento != FormaPagamento.duplo) {
      _cashController.text = "";
    }

    if (_pagamento != FormaPagamento.duplo) {
      _multicaixaController.text = _pagamento != FormaPagamento.cash
          ? AppUtil.formatNumber(_precoTotal())
          : "";
    }
  }

  Future<ProdutoModel> _cadastrarProduto(ProdutoModel produto) async {
    final controller = ProdutoController();
    final id = await controller.cadastrarProduto(produto);
    produto.id = id;
    return produto;
  }

  double _pago() {
    // print(double.tryParse(_pagamentoController.value.text));
    final entregue = AppUtil.toNumber(_cashController.value.text);
    final multicaixa = AppUtil.toNumber(_multicaixaController.value.text);

    // print(multicaixa);

    return entregue + multicaixa;
  }

  Widget _modalBottomSheetContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(40), topEnd: Radius.circular(40))),
      width: double.infinity,
      height: 146,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _faturando = true;
                        });
                        Navigator.pop(context);
                        await onFaturarProforma();
                      },
                      child: const Text("Fatura Proforma"))),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _faturando = true;
                        });
                        Navigator.pop(context);
                        await onFaturarRecibo();
                      },
                      child: const Text("Fatura Recibo")))
            ],
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar")),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void clearData() {
    _clienteController.clear();
    // _empresaController.clear();
    _cashController.clear();
    _produtoNome.clear();
    // _produtoNomeIdController.clear();
    _produtoPreco.clear();
    _produtoQuantidade.clear();
    _quantidadeController.clear();
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

  void onPesquisarEmpresa() async {
    final controller = EmpresaController();
    _empresas = await controller.getEmpresa(_empresaController.value.text);
    // print(res);
    if (_empresas.isNotEmpty) {
      _empresa = _empresas[0];
    } else {
      _empresa = null;
    }
    setState(() {});
  }

  void onPesquisarProduto() async {
    if (!_isDB) return;
    final controller = ProdutoController();
    _produtos.clear();
    _produtos = await controller.produto(_produtoNomeIdController.value.text);
    // for (var produto in res) {
    //   _produtos.add(ProdutoModel.fromMap(produto));
    // }
    // setState(() {});
    if (_produtos.isNotEmpty) {
      _produto = _produtos[0];
    }
    setState(() {});
    // try {
    //   _produtos.clear();
    //   _produtos = await controller.produto(_produtoNomeIdController.value.text);
    //   // for (var produto in res) {
    //   //   _produtos.add(ProdutoModel.fromMap(produto));
    //   // }
    //   // setState(() {});
    //   if (_produtos.isNotEmpty) {
    //     _produto = _produtos[0];
    //   }
    //   setState(() {});
    // } catch (e) {
    //   AppUtil.snackBar(context, "Produto/Serviço nao encontrado");
    // }
  }

  void onAddLista() async {
    if (!_isDB) {
      if (_validateForm.currentState!.validate()) {
        // print(_produtoPreco.value.text);
        // print(_produtoQuantidade.value.text);
        final produto = ProdutoModel(
            nome: _produtoNome.value.text,
            iva: _hasIVA,
            preco: double.parse(_produtoPreco.value.text) * 1.0,
            stock: int.parse(_produtoQuantidade.value.text));

        try {
          _produto = await _cadastrarProduto(produto);
          clearData();
          onPesquisarProduto();
        } catch (e) {
          AppUtil.snackBar(context, "Este produto ja existe na base de dados");
        }
      } else {
        AppUtil.snackBar(context,
            "Nao foi possivel cadastrar o produto/serviço. Verifique se ele nao existe e tente novamente");
        return;
      }
    }
    if (_produto != null) {
      if (_isListado()) {
        AppUtil.snackBar(context, "Esse produto ja esta na lista");
        return;
      }
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
        _quantidadeController.text = "";
        _produto = null;
        AppUtil.snackBar(context, "Produto adicionado");
      });
    } else {
      AppUtil.snackBar(context, "Nenhum produto selecionado");
    }
  }

  bool _isListado() {
    for (var item in _itens) {
      if ((item as ProdutoItem).produto.id == _produto!.id) return true;
    }
    return false;
  }

  Future<void> onFaturarProforma() async {
    var status = await _writeReadPermission();
    if (!status.isDenied && !status.isPermanentlyDenied) {
      if (_empresa != null) {
        final vencimento = DateTime.now().add(const Duration(days: 15));
        final pdf = PdfFatura(
          _itens,
          cliente: _cliente ??
              ClienteModel(
                  nome: "Cliente Diversos",
                  nif: "99999999",
                  endereco: "Diversos",
                  email: "Diversos",
                  credito: 0),
          empresa: _empresa!,
          precoTotal: _precoTotal(),
          vencimento: vencimento,
        );
        pdf.addPage();
        try {
          await pdf.save();
          // print("Verificando se o ficheiro existe $filePath");
          // print(await File(filePath!).exists());

          AppUtil.snackBar(context, "Fatura salva com sucesso!");

          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => PdfView(pdf: filePath!)));
        } catch (e) {
          // print(e);
          AppUtil.snackBar(context, "Ocorreu um erro ao salvar a fatura!");
        }
        setState(() {
          _faturando = false;
        });
        return;
      }
      AppUtil.snackBar(context,
          "Nenhuma empresa selecionada! Por favor selecione uma empresa para faturar");
    } else {
      AppUtil.snackBar(context,
          "O aplicativo nao tem permissao de acessar o armazenamento. Por Favor de permissao para poder continuar");
    }
    setState(() {
      _faturando = false;
    });
  }

  Future<PermissionStatus> _writeReadPermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      status = await Permission.storage.request();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    return status;
  }

  Future<void> onFaturarRecibo() async {
    final troco = _pago() - _precoTotal();
    if (troco < 0) {
      AppUtil.snackBar(context, "O troco nao pode ser menor que zero");
      setState(() {
        _faturando = false;
      });
      return;
    }
    var status = await _writeReadPermission();
    if (!status.isDenied && !status.isPermanentlyDenied) {
      if (_empresa != null && _pagamento != null) {
        final pdf = PdfRecibo(
          _itens,
          cliente: _cliente ??
              ClienteModel(
                  nome: "Cliente Diversos",
                  nif: "99999999",
                  endereco: "Diversos",
                  email: "Diversos",
                  credito: 0),
          empresa: _empresa!,
          precoTotal: _precoTotal(),
          pagamento: Pagamento(
            tipo: _pagamento!.name.toUpperCase(),
            cashValor: _pago(),
            troco: troco,
          ),
        );
        pdf.addPage();
        try {
          await pdf.save();
          AppUtil.snackBar(context, "Fatura salva com sucesso!");
        } catch (e) {
          AppUtil.snackBar(context, "Ocorreu um erro ao salvar a fatura!");
        }
        setState(() {
          _faturando = false;
        });
        return;
      }
      AppUtil.snackBar(
          context, "O tipo de pagamento e a empresa nao podem estar vazios!");
    } else {
      AppUtil.snackBar(context,
          "O aplicativo nao tem permissao de acessar o armazenamento. Por Favor de permissao para poder continuar");
    }
    setState(() {
      _faturando = false;
    });
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

  Widget _insertProduto() {
    return Form(
        key: _validateForm,
        child: Column(
          children: [
            TextFormFieldDecorated(
                controller: _produtoNome,
                validator: Validator.validateName,
                hintText: "Nome do Produto/Serviço"),
            AppUtil.spaceLabelField,
            TextFormFieldDecorated(
                controller: _produtoPreco,
                keyboardType: TextInputType.number,
                validator: Validator.validateNotEmpty,
                hintText: "Preço"),
            AppUtil.spaceLabelField,
            TextFormFieldDecorated(
                controller: _produtoQuantidade,
                keyboardType: TextInputType.number,
                validator: Validator.validateNotEmpty,
                hintText: "Quantidade em Stock"),
            AppUtil.spaceLabelField,
            CheckboxListTile(
                title: const Text("Incluir 14% de IVA"),
                value: _hasIVA,
                onChanged: (value) {
                  setState(() {
                    _hasIVA = !_hasIVA;
                  });
                })
          ],
        ));
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

  Widget _formPagamento() {
    return Form(
        child: Column(
      children: [
        TextFormFieldDecorated(
          controller: _cashController,
          keyboardType: TextInputType.number,
          onChange: (value) {
            setState(() {});
          },
          hintText: "Valor Entregue",
          enabled: FormaPagamento.cash == _pagamento ||
              FormaPagamento.duplo == _pagamento,
        ),
        AppUtil.spaceFields,
        TextFormFieldDecorated(
          controller: _multicaixaController,
          keyboardType: TextInputType.number,
          onChange: (value) {
            setState(() {});
          },
          hintText: "Multicaixa",
          enabled: FormaPagamento.duplo == _pagamento,
        ),
        AppUtil.spaceFields,
        TextFormFieldDecorated(
          hintText: AppUtil.formatNumber((_pago() - _precoTotal())),
          enabled: false,
        ),
      ],
    ));
  }
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
  double? troco;
  Pagamento(
      {required this.tipo,
      required this.cashValor,
      this.multicaixaValor,
      this.troco});
}

class PdfView extends StatefulWidget {
  const PdfView({Key? key, required this.pdf}) : super(key: key);
  final String pdf;

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  bool _loading = true;
  PDFDocument? doc;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    doc = await PDFDocument.fromAsset("assets/livro.pdf");
    _loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PDFViewer(document: doc!),
    );
  }
}
