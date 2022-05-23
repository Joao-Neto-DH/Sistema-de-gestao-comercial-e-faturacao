// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:path/path.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

import 'package:sistema_de_gestao_comercial/view/faturacao/faturacao_screen.dart';

class PDFGenerator {
  final pdf = pw.Document();
  final List<Widget> itens;
  PDFGenerator(this.itens);

  addPage() {
    pdf.addPage(pw.MultiPage(
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
                      pw.Text("Minha Empresa".toUpperCase()),
                      _spaceBetweenText(),
                      pw.Text("NIF: "),
                      _spaceBetweenText(),
                      pw.Text("Telefone: "),
                      _spaceBetweenText(),
                      pw.Text("Website: "),
                      _spaceBetweenText(),
                      pw.Text("Email: "),
                    ]),
                pw.Spacer(),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _titleWidget("CLIENTE"),
                      _spaceBetweenText(),
                      pw.Text("Nome do cliente".toUpperCase()),
                      _spaceBetweenText(),
                      pw.Text("Endereço: "),
                      _spaceBetweenText(),
                      pw.Text("NIF: "),
                      _spaceBetweenText(),
                      pw.Text("Telefone: "),
                      _spaceBetweenText(),
                      pw.Text("Conta Conta: "),
                    ]),
              ])), // Cabeçalho
      _spaceBetween(),
      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Text("Data e Hora de Fatura: ${DateTime.now()}".toUpperCase()),
        _spaceBetweenText(),
        pw.Text("FATURA PROFORMA",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold))
      ]), // Data
      _spaceBetween(),
      pw.Table(
          // border: const pw.TableBorder(
          //     bottom: pw.BorderSide(color: PdfColors.black)),
          children: [
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
            for (var item in itens) _row(item)
          ]),
    ];
  }

  pw.Widget _columnTitle(String title) {
    return pw.Text("Nº", style: pw.TextStyle(fontWeight: pw.FontWeight.bold));
  }

  pw.TableRow _row(Widget widget) {
    final item = widget as ProdutoItem;
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
          pw.Text(item.produto.iva!
              ? "${(item.produto.preco * 0.14).toStringAsFixed(2)}Kz"
              : ""),
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
    final joined = join(path!.path, "fatura-${DateTime.now().toString()}.pdf");
    var file = File(joined);
    return await file.writeAsBytes(await pdf.save());
  }
}
