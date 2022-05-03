import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/util.dart';
import './load_image.dart';
import 'text_form_field_decorated.dart';

/// Tela de cadastro de empresa
class EmpresaScreen extends StatefulWidget {
  const EmpresaScreen({Key? key}) : super(key: key);

  @override
  State<EmpresaScreen> createState() => _EmpresaScreenState();
}

class _EmpresaScreenState extends State<EmpresaScreen> {
  String _logoImagePath = "";
  String _backgroundImagePath = "";

  final LoadImage logoImage = LoadImage();
  final LoadImage backgroundImage = LoadImage();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppUtil.spaceFields,
          const Text(
            "CADASTRO DE EMPRESA",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          AppUtil.spaceLabelField,
          const Text("Os campos marcados com (*) sao obrigatorios"),
          const Divider(),
          AppUtil.spaceFields,
          const Text(
            "Nome da Empresa",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "Nome da Empresa",
          ),
          AppUtil.spaceFields,
          const Text(
            "NIF da Empresa",
            textAlign: TextAlign.left,
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "NIF da Empresa",
          ),
          AppUtil.spaceFields,
          const Text(
            "Endereço da Empresa",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "Endereço da Empresa",
          ),
          AppUtil.spaceFields,
          const Text(
            "Cidade",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "Cidade",
          ),
          AppUtil.spaceFields,
          const HorizontalDividerWithLabel(label: "Informaçoes de contactos"),
          AppUtil.spaceFields,
          const Text(
            "Contacto#1",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "Contacto",
          ),
          AppUtil.spaceFields,
          const Text(
            "Contacto#2",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "Contacto",
          ),
          AppUtil.spaceFields,
          const Text(
            "Email",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "Email",
          ),
          AppUtil.spaceFields,
          const Text(
            "Website",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "Website",
          ),
          AppUtil.spaceFields,
          const HorizontalDividerWithLabel(label: "Informaçoes Bancarias"),
          AppUtil.spaceFields,
          const Text(
            "IBAN #1",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "IBAN",
          ),
          AppUtil.spaceFields,
          const Text(
            "IBAN #2",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "IBAN",
          ),
          AppUtil.spaceFields,
          const Text(
            "IBAN #3",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "IBAN",
          ),
          AppUtil.spaceFields,
          const Text(
            "Numero da Conta #1",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "Numero da Conta",
          ),
          AppUtil.spaceFields,
          const Text(
            "Numero da Conta #2",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "Numero da Conta",
          ),
          AppUtil.spaceFields,
          const Text(
            "Numero da Conta #3",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "Numero da Conta",
          ),
          AppUtil.spaceFields,
          ElevatedButton(
              onPressed: () {
                logoImage.pickImage().then((value) => setState(() {
                      _logoImagePath = value;
                    }));
              },
              child: const Text("Carregar Logo")),
          _showLogoOrText(_logoImagePath),
          AppUtil.spaceFields,
          ElevatedButton(
              onPressed: () {
                logoImage.pickImage().then((value) => setState(() {
                      _backgroundImagePath = value;
                    }));
              },
              child: const Text("Carregar Fundo das Fasturas")),
          _showLogoOrText(_backgroundImagePath),
          AppUtil.spaceFields,
          ElevatedButton(
              onPressed: () {}, child: const Text("Cadastrar Empresa"))
        ],
      ),
    ));
  }

  Widget _showLogoOrText(String path) {
    return path != ""
        ? Image.file(File(path))
        : const Text("Selecionar imagem");
  }
}

class HorizontalDividerWithLabel extends StatelessWidget {
  const HorizontalDividerWithLabel({Key? key, required this.label})
      : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
            child: Divider(
          thickness: 2,
          endIndent: 20,
        )),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
        const Expanded(
            child: Divider(
          indent: 20,
          thickness: 2,
        )),
      ],
    );
  }
}
