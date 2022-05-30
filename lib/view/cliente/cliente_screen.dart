import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/controller/cliente_controller.dart';
import 'package:sistema_de_gestao_comercial/validator.dart';
// import '../../dao/cliente_dao.dart';

import '../../util.dart';
import '../components/text_form_field_decorated.dart';
import '../../model/cliente_model.dart';

class ClienteScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final _nifController = TextEditingController();
  final _creditoController = TextEditingController();
  final _nomeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _emailController = TextEditingController();

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
                "Nome do Cliente*",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Nome",
                validator: Validator.validateName,
                controller: _nomeController,
              ),
              AppUtil.spaceFields,
              const Text(
                "NIF do Cliente",
                textAlign: TextAlign.left,
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "NIF",
                validator: (value) {
                  return _nifController.value.text.trim().isEmpty
                      ? null
                      : Validator.validateNotEmpty(value);
                },
                controller: _nifController,
              ),
              AppUtil.spaceFields,
              const Text(
                "Endereço do Cliente",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Endereço",
                validator: (value) {
                  return _enderecoController.value.text.trim().isEmpty
                      ? null
                      : Validator.validateNotEmpty(value);
                },
                controller: _enderecoController,
              ),
              AppUtil.spaceFields,
              const Text(
                "Email do Cliente",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "EMAIL",
                validator: (value) {
                  return _emailController.value.text.trim().isEmpty
                      ? null
                      : Validator.validateEmail(value);
                },
                controller: _emailController,
              ),
              AppUtil.spaceFields,
              const Text(
                "Credito do Cliente",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Credito",
                controller: _creditoController,
              ),
              AppUtil.spaceFields,
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final controller = ClienteController();
                      try {
                        await controller.cadastrarCliente(ClienteModel(
                            nome: _nomeController.value.text,
                            nif: _nifController.value.text,
                            endereco: _enderecoController.value.text,
                            email: _emailController.value.text,
                            credito: _creditoController.value.text.isEmpty
                                ? 0
                                : double.parse(_creditoController.value.text)));

                        AppUtil.snackBar(
                            context, "Cliente cadastrado com sucesso");
                        clearData();
                      } catch (e) {
                        // print(e);
                        AppUtil.snackBar(context,
                            "Erro ao cadastrar o cliente. Verifique se nao existe um cliente com estes dados e tente novamente");
                      }
                    }
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

  void clearData() {
    formKey.currentState!.reset();
  }
}
