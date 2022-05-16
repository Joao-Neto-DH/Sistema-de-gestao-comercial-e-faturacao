import 'package:flutter/material.dart';
import '../../dao/cliente_dao.dart';

import '../../util.dart';
import '../components/text_form_field_decorated.dart';
import '../../model/cliente_model.dart';

class ClienteScreen extends StatelessWidget {
  const ClienteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        child: SingleChildScrollView(
      padding: AppUtil.paddingBody,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "CADASTRO DE CLIENTE",
            textAlign: TextAlign.center,
            style: AppUtil.styleHeader,
          ),
          AppUtil.spaceLabelField,
          const Text.rich(TextSpan(text: "Os campos marcados com (", children: [
            TextSpan(text: "*", style: TextStyle(color: Colors.red)),
            TextSpan(text: ") sao obrigatorios")
          ])),
          const Divider(),
          const Text(
            "Nome do Cliente",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "Nome",
          ),
          AppUtil.spaceFields,
          const Text(
            "NIF do Cliente",
            textAlign: TextAlign.left,
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "NIF",
          ),
          AppUtil.spaceFields,
          const Text(
            "Endereço do Cliente",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "Endereço",
          ),
          AppUtil.spaceFields,
          const Text(
            "Email do Cliente",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "EMAIL",
          ),
          AppUtil.spaceFields,
          const Text(
            "Credito do Cliente",
          ),
          AppUtil.spaceLabelField,
          TextFormFieldDecorated(
            hintText: "Credito",
          ),
          AppUtil.spaceFields,
          ElevatedButton(
              onPressed: () async {
                final res = await _cadastrarClieente(ClienteModel(
                    nome: "nome",
                    nif: "nif",
                    endereco: "endereco",
                    email: "email",
                    credito: 10));

                print(res);
              },
              child: const Text("Cadastrar cliente")),
          AppUtil.spaceFields,
          ElevatedButton(
              onPressed: () {}, child: const Text("Alterar dados do cliente")),
          AppUtil.spaceFields,
          ElevatedButton(
              onPressed: () {}, child: const Text("Extrato do cliente")),
          AppUtil.spaceFields,
          ElevatedButton(
              onPressed: () {}, child: const Text("Eliminar cliente")),
          AppUtil.spaceFields,
          ElevatedButton(onPressed: () {}, child: const Text("Listar clientes"))
        ],
      ),
    ));
  }

  Future<int> _cadastrarClieente(ClienteModel cliente) async {
    final dao = ClienteDAO();
    final res = await dao.insert(cliente);
    print(await dao.all);
    return res;
  }
}
