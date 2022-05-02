import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EmpresaScreen extends StatelessWidget {
  const EmpresaScreen({Key? key}) : super(key: key);

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
            "Coordenada Bancaria #1",
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Coordenada Bancaria", border: OutlineInputBorder()),
          ),
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
              onPressed: _pickImage, child: const Text("Abrir imagem"))
        ],
      ),
    ));
  }

  void _pickImage() async {
    final picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    print("cara isso foi eu");
    print(file!.mimeType ?? "vazio");
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
