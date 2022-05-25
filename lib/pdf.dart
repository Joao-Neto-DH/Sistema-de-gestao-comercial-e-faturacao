// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:path/path.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sistema_de_gestao_comercial/model/cliente_model.dart';
import 'package:sistema_de_gestao_comercial/model/empresa_model.dart';
import 'package:sistema_de_gestao_comercial/util.dart';
import 'dart:io';

import 'package:sistema_de_gestao_comercial/view/faturacao/faturacao_screen.dart';

class PDFGenerator {
  final pdf = pw.Document();
  final List<Widget> itens;
  final ClienteModel cliente;
  final EmpresaModel empresa;
  final date = DateTime.now().toString().split(".")[0];
  var _totalIva = 0.0;
  final double precoTotal;
  PDFGenerator(this.itens,
      {required this.cliente, required this.empresa, required this.precoTotal});

  addPage() {
    pdf.addPage(pw.MultiPage(
      // footer: (context) => pw.Text("Rodape"),
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return _content();
      },
    ));
  }

  List<pw.Widget> _content() {
    return [
      // pw.Image(),
      pw.Container(
          color: PdfColors.grey300,
          padding: const pw.EdgeInsets.all(8),
          child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _titleWidget("EMPRESA"),
                      _spaceBetweenText(),
                      pw.Text(empresa.nome.toUpperCase()),
                      _spaceBetweenText(),
                      pw.Text("NIF: ${empresa.nif}"),
                      _spaceBetweenText(),
                      for (var contacto in empresa.contactos)
                        pw.Text("Telefone: ${contacto.telefone}"),
                      _spaceBetweenText(),
                      pw.Text("Email: ${empresa.email}"),
                      _spaceBetweenText(),
                      pw.Text("Website: ${empresa.website ?? ""}"),
                    ]),
                pw.Spacer(),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _titleWidget("CLIENTE"),
                      _spaceBetweenText(),
                      pw.Text(cliente.nome.toUpperCase()),
                      _spaceBetweenText(),
                      pw.Text("Endereço: ${cliente.endereco}"),
                      _spaceBetweenText(),
                      pw.Text("NIF: ${cliente.nif}"),
                      // _spaceBetweenText(),
                      // pw.Text("Telefone: "),
                      _spaceBetweenText(),
                      pw.Text("Email: ${cliente.email}"),
                    ]),
              ])), // Cabeçalho
      _spaceBetween(),
      pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("Data de Fatura: $date".toUpperCase()),
                  _spaceBetweenText(),
                  pw.Text("FATURA PROFORMA",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
                ]),
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("Forma de Pagamento",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text("Cash")
                ])
          ]), // Data
      _spaceBetween(),
      pw.Table(
          // border: const pw.TableBorder(
          //     bottom: pw.BorderSide(color: PdfColors.black)),
          children: [
            //  cabeçalho
            pw.TableRow(
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        bottom:
                            pw.BorderSide(color: PdfColors.black, width: 2))),
                children: [
                  _columnTitle("Nº"),
                  pw.Spacer(),
                  _columnTitle("Produto/Serviço"),
                  pw.Spacer(),
                  _columnTitle("Qtd."),
                  pw.Spacer(),
                  _columnTitle("Preco Unit."),
                  pw.Spacer(),
                  _columnTitle("IVA(14%)"),
                  pw.Spacer(),
                  _columnTitle("Total"),
                ]),
            pw.TableRow(children: [pw.SizedBox(height: 10)]),
            for (var item in itens) _row(item), // conteudo
            pw.TableRow(children: [pw.SizedBox(height: 10)]),
            //  Rodape
            pw.TableRow(children: [
              _columnTitle("Taxa"),
              pw.Spacer(),
              _columnTitle("Incidencia"),
              pw.Spacer(),
              _columnTitle(""),
              pw.Spacer(),
              _columnTitle("IVA"),
              pw.Spacer(),
              _columnTitle(""),
              pw.Spacer(),
              _columnTitle("ISENÇAO"),
            ]),
            pw.TableRow(children: [
              pw.Text("IVA(14%)"),
              pw.Spacer(),
              pw.Text(AppUtil.formatNumber(precoTotal - _totalIva)),
              pw.Spacer(),
              pw.Text(""),
              pw.Spacer(),
              pw.Text(AppUtil.formatNumber(_totalIva)),
              pw.Spacer(),
              pw.Text(""),
              pw.Spacer(),
              pw.Text("ISENÇAO"),
            ])
          ]),

      _spaceBetween(),
      pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                      padding: const pw.EdgeInsets.all(4),
                      color: PdfColors.grey300,
                      child: pw.Text("Coordenadas Bancarias")),
                  for (var coord in empresa.coordenadas)
                    pw.Text(coord.coordenada),
                ]),
            pw.Container(
                width: 250,
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            _columnTitle("Subtotal"),
                            pw.Text("0.00")
                          ]),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            _columnTitle("Desconto"),
                            pw.Text("0.00")
                          ]),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            _columnTitle("IVA"),
                            pw.Text(AppUtil.formatNumber(_totalIva))
                          ]),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            _columnTitle("Retençao da fonte"),
                            pw.Text(AppUtil.formatNumber(0))
                          ]),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            _columnTitle("Total"),
                            pw.Text(AppUtil.formatNumber(precoTotal))
                          ]),
                    ]))
          ])
    ];
  }

  pw.Widget _columnTitle(String title) {
    return pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold));
  }

  pw.TableRow _row(Widget widget) {
    final item = widget as ProdutoItem;
    final iva = item.produto.preco * 0.14;
    _totalIva += iva;
    return pw.TableRow(
        decoration: const pw.BoxDecoration(
            border: pw.Border(bottom: pw.BorderSide(color: PdfColors.black))),
        children: [
          pw.Text(item.produto.id.toString()),
          pw.Spacer(),
          pw.Text(item.produto.nome),
          pw.Spacer(),
          pw.Text(item.qtd.toString()),
          pw.Spacer(),
          pw.Text("${item.produto.preco.toStringAsFixed(2)}Kz"),
          pw.Spacer(),
          pw.Text(item.produto.iva! ? "${(iva).toStringAsFixed(2)}Kz" : ""),
          pw.Spacer(),
          pw.Text("${(item.produto.preco * item.qtd).toStringAsFixed(2)}Kz"),
        ]);
  }

  pw.Widget _titleWidget(String title) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
          border: pw.Border(bottom: pw.BorderSide(color: PdfColors.black))),
      // margin: const pw.EdgeInsets.only(bottom: 8.0),
      // color: PdfColors.grey300,
      // padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  pw.Widget _spaceBetween() {
    return pw.Container(height: 60);
  }

  pw.Widget _spaceBetweenText() {
    return pw.SizedBox(height: 15);
  }

  Future<File> save() async {
    //-${DateTime.now().toString()}

    final path = await getExternalStorageDirectory();
    final joined = join(path!.path, "fatura-$date.pdf");
    var file = File(joined);
    return await file.writeAsBytes(await pdf.save());
  }
}
