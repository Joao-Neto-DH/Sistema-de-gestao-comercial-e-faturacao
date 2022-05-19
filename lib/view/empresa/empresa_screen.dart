import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sistema_de_gestao_comercial/controller/empresa_controller.dart';
import 'package:sistema_de_gestao_comercial/util.dart';
import 'package:sistema_de_gestao_comercial/validator.dart';
// import '../../dao/contacto_dao.dart';
// import '../../dao/coordenada_bancaria_dao.dart';
// import '../../dao/empresa_dao.dart';
// import '../../dao/logo_dao.dart';
import '../../model/coordenada_bancaria_model.dart';
import '../../model/empresa_model.dart';
import '../../model/logo_model.dart';
import './load_image.dart';
import '../components/text_form_field_decorated.dart';

/// Tela de cadastro de empresa
class EmpresaScreen extends StatefulWidget {
  const EmpresaScreen({Key? key}) : super(key: key);

  @override
  State<EmpresaScreen> createState() => _EmpresaScreenState();
}

class _EmpresaScreenState extends State<EmpresaScreen> {
//  Key para controlar o formulario
  final formKey = GlobalKey<FormState>();
//  Imagens da empresa(logotipo e marca d'agua)
  String _logoImagePath = "";
  String _backgroundImagePath = "";
  final LoadImage logoImage = LoadImage();
  final LoadImage backgroundImage = LoadImage();
//  Dados da empresa
  final nomeController = TextEditingController();
  final nifController = TextEditingController();
  final enderecoController = TextEditingController();
  final cidadeController = TextEditingController();
//  Dados de contacto da empresa
  final contactoControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  final emailController = TextEditingController();
  final websiteController = TextEditingController();
//  Dados bancario da empresa
  final ibanControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  final contaControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

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
                "CADASTRO DE EMPRESA",
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
                "Nome da Empresa",
              ),
              AppUtil.spaceLabelField,
              //dados da empresa
              TextFormFieldDecorated(
                controller: nomeController,
                validator: (value) {
                  return Validator.validateNotEmpty(value!);
                },
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
                controller: nifController,
                validator: (value) {
                  return Validator.validateNotEmpty(value!);
                },
              ),
              AppUtil.spaceFields,
              const Text(
                "Endereço da Empresa",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Endereço da Empresa",
                controller: enderecoController,
                validator: (value) {
                  return Validator.validateNotEmpty(value!);
                },
              ),
              AppUtil.spaceFields,
              const Text(
                "Cidade",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Cidade",
                controller: cidadeController,
                validator: (value) {
                  return Validator.validateNotEmpty(value!);
                },
              ),
              AppUtil.spaceFields,
              //dados de contacto da empresa
              const HorizontalDividerWithLabel(
                  label: "Informaçoes de contactos"),
              AppUtil.spaceFields,
              const Text(
                "Contacto#1",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Contacto",
                controller: contactoControllers[0],
                validator: (value) {
                  return Validator.validateNotEmpty(value!);
                },
              ),
              AppUtil.spaceFields,
              const Text(
                "Contacto#2",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                controller: contactoControllers[1],
                hintText: "Contacto",
              ),
              AppUtil.spaceFields,
              const Text(
                "Email",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Email",
                controller: emailController,
                validator: (value) {
                  return Validator.validateNotEmpty(value!);
                },
              ),
              AppUtil.spaceFields,
              const Text(
                "Website",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                controller: websiteController,
                hintText: "Website",
              ),
              AppUtil.spaceFields,
              //Dados bancarios da empresa
              const HorizontalDividerWithLabel(label: "Informaçoes Bancarias"),
              AppUtil.spaceFields,
              const Text(
                "IBAN #1",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "IBAN",
                controller: ibanControllers[0],
                validator: (value) {
                  return Validator.validateNotEmpty(value!);
                },
              ),
              AppUtil.spaceFields,
              const Text(
                "IBAN #2",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                controller: ibanControllers[1],
                hintText: "IBAN",
              ),
              AppUtil.spaceFields,
              const Text(
                "IBAN #3",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                controller: ibanControllers[2],
                hintText: "IBAN",
              ),
              AppUtil.spaceFields,
              const Text(
                "Numero da Conta #1",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                hintText: "Numero da Conta",
                controller: contaControllers[0],
                validator: (value) {
                  return Validator.validateNotEmpty(value!);
                },
              ),
              AppUtil.spaceFields,
              const Text(
                "Numero da Conta #2",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                controller: contaControllers[1],
                hintText: "Numero da Conta",
              ),
              AppUtil.spaceFields,
              const Text(
                "Numero da Conta #3",
              ),
              AppUtil.spaceLabelField,
              TextFormFieldDecorated(
                controller: contaControllers[2],
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
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final contactos = <ContactoModel>[];
                      final coordenadas = <CoordenadaBancariaModel>[];

                      contactoControllers.forEach(((element) {
                        if (element.value.text.trim().isNotEmpty) {
                          contactos.add(ContactoModel(
                              telefone: element.value.text.trim()));
                        }
                      }));

                      for (var i = 0; i < contaControllers.length; i++) {
                        if (contaControllers[i].value.text.isNotEmpty &&
                            ibanControllers[i].value.text.isNotEmpty) {
                          coordenadas.add(CoordenadaBancariaModel(
                              coordenada: ibanControllers[i].value.text,
                              conta: contaControllers[i].value.text));
                        } else if (contaControllers[i].value.text.isNotEmpty !=
                            ibanControllers[i].value.text.isNotEmpty) {
                          AppUtil.snackBar(context,
                              "Um dos campos bancarios(Numero de Conta, IBAN) numero ${i + 1} nao esta preenchido! Por favor preencha e tente novan«mente");
                          return;
                        }
                      }
                      final controller = EmpresaController();
                      final empresa = EmpresaModel(
                          nome: nomeController.value.text,
                          nif: nifController.value.text,
                          email: emailController.value.text,
                          endereco: enderecoController.value.text,
                          cidade: cidadeController.value.text,
                          contactos: contactos,
                          coordenadas: coordenadas,
                          logos: _logos());

                      final res = await controller.cadastrarEmpresa(empresa);
                      // var res = await _cadastrarEmpresa(EmpresaModel(
                      //     nome: nomeController.value.text,
                      //     nif: nifController.value.text,
                      //     email: emailController.value.text,
                      //     endereco: enderecoController.value.text,
                      //     cidade: cidadeController.value.text,
                      //     contactos: contactos));
                      // await _cadastrarCoordenadas(res, coordenadas);
                      // print("RESULTADO $res");
                      if (res != -1) {
                        AppUtil.snackBar(
                            context, "Empresa Cadastrada com sucesso!!!");
                      } else {
                        AppUtil.snackBar(context,
                            "Falha ao cadastrar a empresa. Verifique se estas informaçoes nao estao sendo utilizadas por outra empresa e tente novamente!");
                      }
                    }
                  },
                  child: const Text("Cadastrar Empresa"))
            ],
          ),
        ));
  }

  List<LogoModel> _logos() {
    // final logoDAO = LogoDAO();
    final logos = <LogoModel>[];

    if (_logoImagePath != "") {
      logos.add(LogoModel(
          logo: _logoImagePath,
          // empresaID: empresaID,
          isFundo: _logoImagePath == _backgroundImagePath));

      if (!(_logoImagePath == _backgroundImagePath) &&
          _backgroundImagePath != "") {
        logos.add(LogoModel(
            logo: _backgroundImagePath,
            // empresaID: empresaID,
            isFundo: _logoImagePath == _backgroundImagePath));
      }
    }
    return logos;
  }

  //   for (var logo in logos) {
  //     try {
  //       await logoDAO.insert(logo);
  //     } catch (e) {
  //       print("Ocorreu um erro nas imagens $e");
  //     }
  //   }
  //   // return ;
  // }

  // Future<void> _cadastrarCoordenadas(
  //     int empresaID, List<CoordenadaBancariaModel> coordenadas) async {
  //   final coorDAO = CoordenadaBancariaDAO();

  //   for (var coordenada in coordenadas) {
  //     try {
  //       await coorDAO.insert(coordenada);
  //     } catch (e) {
  //       // print(coordenadas);
  //       print("Ocorreu um erro nas coordenadas $e");
  //     }
  //   }
  // }

  // Future<int> _cadastrarEmpresa(EmpresaModel empresa) async {
  //   final empDAO = EmpresaDAO();
  //   int empresaID;

  //   try {
  //     empresaID = await empDAO.insert(empresa);
  //   } catch (e) {
  //     empresaID = -1;
  //     print("Ocorreu um erro na empresa");
  //   }

  //   if (empresaID > 0) {
  //     final contDAO = ContactoDAO();

  //     for (var contacto in empresa.contactos) {
  //       contacto.empresaID = empresaID;
  //       try {
  //         await contDAO.insert(contacto);
  //       } catch (e) {
  //         print("Ocorreu um erro nos contactos $e");
  //       }
  //     }

  //     await _cadastrarLogos(empresaID);
  //   }

  // return empresaID;

  // print(empresa);
  // }

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
