import 'package:flutter/material.dart';

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
          const Text(
            "Contacto",
          ),
          spaceLabelField,
          TextFormField(
            decoration: const InputDecoration(
                hintText: "Contacto", border: OutlineInputBorder()),
          ),
          spaceFields,
          const Text(
            "Contacto",
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
          spaceFields
        ],
      ),
    ));
  }
}
