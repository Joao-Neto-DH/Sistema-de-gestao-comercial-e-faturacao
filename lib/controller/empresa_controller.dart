// import 'package:sistema_de_gestao_comercial/dao/coordenada_bancaria_dao.dart';
import 'package:sistema_de_gestao_comercial/model/coordenada_bancaria_model.dart';
import 'package:sistema_de_gestao_comercial/model/logo_model.dart';

import '../dao/empresa_dao.dart';
// import '../model/coordenada_bancaria_model.dart';
import '../model/empresa_model.dart';
// import '../model/logo_model.dart';

class EmpresaController {
  final _dao = EmpresaDAO();

  Future<int?> cadastrarEmpresa(EmpresaModel empresa) async {
    return await _dao.insert(empresa);
  }

  Future<List<EmpresaModel>> getEmpresa(String empresa) async {
    final resEmpresa = await _dao.empresa(empresa);
    final empresas = <EmpresaModel>[];

    for (var empresa in resEmpresa) {
      final lconts = await _dao.empresaDados("contactos", empresa["id"] as int);
      final lcoords = await _dao.empresaDados(
          "coordenadas_bancarias", empresa["id"] as int);
      final limgs = await _dao.empresaDados("imagens", empresa["id"] as int);
      // print(dados);
      // print(empresa);
      final contactos = <ContactoModel>[];
      final bancos = <CoordenadaBancariaModel>[];
      final imgs = <LogoModel>[];

      for (var cont in lconts) {
        contactos.add(ContactoModel.fromMap(cont));
      }

      for (var coors in lcoords) {
        bancos.add(CoordenadaBancariaModel.fromMap(coors));
      }

      for (var img in limgs) {
        imgs.add(LogoModel.fromMap(img));
      }
      empresas.add(EmpresaModel.fromMap(empresa, contactos, bancos, imgs));
    }

    return empresas;
    // print(empresas);
    // return await _dao.insert(empresa);
  }
}
