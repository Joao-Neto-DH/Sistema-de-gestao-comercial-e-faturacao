import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/pdf.dart';
import 'package:sistema_de_gestao_comercial/util.dart';
import 'package:sistema_de_gestao_comercial/view/components/text_form_field_decorated.dart';
import 'package:sistema_de_gestao_comercial/view/empresa/empresa_screen.dart';
import 'package:permission_handler/permission_handler.dart';
// import '../../model/db.dart';

class FaturacaoScreen extends StatefulWidget {
  const FaturacaoScreen({Key? key}) : super(key: key);

  @override
  State<FaturacaoScreen> createState() => _FaturacaoScreenState();
}

class _FaturacaoScreenState extends State<FaturacaoScreen> {
  var produtos = <Widget>[
    ProdutoItem(
      qtd: 12,
    ),
    ProdutoItem(
      qtd: 2,
    ),
    ProdutoItem(
      qtd: 3,
    ),
    ProdutoItem(
      qtd: 7,
    )
  ];
  var samples = ["Arroz", "Massa", "Peixe"];
  var _selected = "Arroz";
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
                  hintText: "Selecione produto/serviço",
                ),
                AppUtil.spaceFields,
                const Text("Insira a quantidade a ser vendida"),
                AppUtil.spaceLabelField,
                TextFormFieldDecorated(
                  hintText: "Digitar a quantidade",
                  keyboardType: TextInputType.number,
                ),
                AppUtil.spaceFields,
                Center(
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Adicionar a fatura")),
                ),
                AppUtil.spaceFields,
                const HorizontalDividerWithLabel(
                    label: "Produtos/serviços listados"),
                AppUtil.spaceFields,
              ],
            ),
          ),
          produtos.isEmpty ? _listaVazia() : _lista(produtos),
          AppUtil.spaceLabelField,
          if (produtos.isNotEmpty)
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
                      final pdf = PDFGenerator();
                      pdf.addPage();
                      await pdf.save();
                      // print(await file.exists());
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

  Container _lista(List<Widget> produtos) => Container(
      color: const Color.fromARGB(10, 0, 0, 0),
      child: Column(children: produtos));
}

class ProdutoItem extends StatefulWidget {
  ProdutoItem({Key? key, required this.qtd}) : super(key: key);

  int qtd = 10;
  @override
  State<ProdutoItem> createState() => _ProdutoItemState();
}

class _ProdutoItemState extends State<ProdutoItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: true,
      title: const Text("Produto/serviço"),
      subtitle: Text("120,51kz - " + widget.qtd.toString()),
      trailing: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  widget.qtd++;
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
                  widget.qtd > 0 ? widget.qtd-- : widget.qtd;
                });
              },
              icon: const Icon(Icons.reduce_capacity),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.restore_from_trash),
            ),
          ],
        ),
      ),
    );
  }
}
