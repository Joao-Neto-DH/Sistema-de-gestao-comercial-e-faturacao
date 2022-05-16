import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/validator.dart';
import '../../dao/cliente_dao.dart';

import '../../util.dart';
import '../components/text_form_field_decorated.dart';
import '../../model/cliente_model.dart';

class ClienteScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final nifController = TextEditingController();
  final creditoController = TextEditingController();
  final nomeController = TextEditingController();
  final enderecoController = TextEditingController();
  final emailController = TextEditingController();

  ClienteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
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
              const Text.rich(
                  TextSpan(text: "Os campos marcados com (", children: [
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
                validator: Validator.validateName,
                controller: nomeController,
              ),
              AppUtil.spaceFields,
              const Text(
                "NIF do Cliente",
                textAlign: TextAlign.left,
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "NIF",
                validator: Validator.validateNotEmpty,
                controller: nifController,
              ),
              AppUtil.spaceFields,
              const Text(
                "Endereço do Cliente",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Endereço",
                validator: Validator.validateNotEmpty,
                controller: enderecoController,
              ),
              AppUtil.spaceFields,
              const Text(
                "Email do Cliente",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "EMAIL",
                validator: Validator.validateEmail,
                controller: emailController,
              ),
              AppUtil.spaceFields,
              const Text(
                "Credito do Cliente",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Credito",
                controller: creditoController,
              ),
              AppUtil.spaceFields,
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await _cadastrarClieente(ClienteModel(
                            nome: nomeController.value.text,
                            nif: nifController.value.text,
                            endereco: enderecoController.value.text,
                            email: emailController.value.text,
                            credito: creditoController.value.text.isEmpty
                                ? 0
                                : double.parse(creditoController.value.text)));

                        AppUtil.snackBar(
                            context, "Cliente cadastrado com sucesso");
                      } catch (e) {
                        print(e);
                        AppUtil.snackBar(context,
                            "Erro ao cadastrar o cliente. Verifique se nao existe um cliente com estes dados e tente novamente");
                      }
                    }
                    // final res = await _cadastrarClieente(ClienteModel(
                    //     nome: "nome",
                    //     nif: "nif",
                    //     endereco: "endereco",
                    //     email: "email",
                    //     credito: 10));

                    // print(res);
                  },
                  child: const Text("Cadastrar cliente")),
              AppUtil.spaceFields,
              ElevatedButton(
                  onPressed: () {},
                  child: const Text("Alterar dados do cliente")),
              AppUtil.spaceFields,
              ElevatedButton(
                  onPressed: () {}, child: const Text("Extrato do cliente")),
              AppUtil.spaceFields,
              ElevatedButton(
                  onPressed: () {}, child: const Text("Eliminar cliente")),
              AppUtil.spaceFields,
              ElevatedButton(
                  onPressed: () {}, child: const Text("Listar clientes"))
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
