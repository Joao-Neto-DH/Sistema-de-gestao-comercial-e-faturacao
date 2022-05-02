import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/screens/empresa/load_image.dart';

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
    const spaceLabelField = SizedBox(
      height: 16,
    );
    const spaceFields = SizedBox(
      height: 24,
    );

    return Form(
        child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          spaceFields,
          const Text(
            "CADASTRO DE EMPRESA",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          spaceLabelField,
          const Text("Os campos marcados com (*) sao obrigatorios"),
          const Divider(),
          spaceFields,
          const Text(
            "Nome da Empresa",
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Nome da Empresa", border: OutlineInputBorder()),
          ),
          spaceFields,
          const Text(
            "NIF da Empresa",
            textAlign: TextAlign.left,
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "NIF da Empresa", border: OutlineInputBorder()),
          ),
          spaceFields,
          const Text(
            "Endereço da Empresa",
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Endereço da Empresa", border: OutlineInputBorder()),
          ),
          spaceFields,
          const Text(
            "Cidade",
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Cidade", border: OutlineInputBorder()),
          ),
          spaceFields,
          const HorizontalDividerWithLabel(label: "Informaçoes de contactos"),
          spaceFields,
          const Text(
            "Contacto#1",
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Contacto", border: OutlineInputBorder()),
          ),
          spaceFields,
          const Text(
            "Contacto#2",
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Contacto", border: OutlineInputBorder()),
          ),
          spaceFields,
          const Text(
            "Email",
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Email", border: OutlineInputBorder()),
          ),
          spaceFields,
          const Text(
            "Website",
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Website", border: OutlineInputBorder()),
          ),
          spaceFields,
          const HorizontalDividerWithLabel(label: "Informaçoes Bancarias"),
          spaceFields,
          const Text(
            "IBAN #1",
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "IBAN", border: OutlineInputBorder()),
          ),
          spaceFields,
          const Text(
            "IBAN #2",
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "IBAN", border: OutlineInputBorder()),
          ),
          spaceFields,
          const Text(
            "IBAN #3",
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "IBAN", border: OutlineInputBorder()),
          ),
          spaceFields,
          const Text(
            "Numero da Conta #1",
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Numero da Conta", border: OutlineInputBorder()),
          ),
          spaceFields,
          const Text(
            "Numero da Conta #2",
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Numero da Conta", border: OutlineInputBorder()),
          ),
          spaceFields,
          const Text(
            "Numero da Conta #3",
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Numero da Conta", border: OutlineInputBorder()),
          ),
          spaceFields,
          ElevatedButton(
              onPressed: () {
                logoImage.pickImage().then((value) => setState(() {
                      _logoImagePath = value;
                    }));
              },
              child: const Text("Carregar Logo")),
          _showLogoOrText(_logoImagePath),
          spaceFields,
          ElevatedButton(
              onPressed: () {
                logoImage.pickImage().then((value) => setState(() {
                      _backgroundImagePath = value;
                    }));
              },
              child: const Text("Carregar Fundo das Fasturas")),
          _showLogoOrText(_backgroundImagePath),
          spaceFields,
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
