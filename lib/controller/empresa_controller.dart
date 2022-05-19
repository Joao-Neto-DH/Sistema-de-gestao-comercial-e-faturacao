import '../dao/empresa_dao.dart';
// import '../model/coordenada_bancaria_model.dart';
import '../model/empresa_model.dart';
import '../model/logo_model.dart';

class EmpresaController {
  final _dao = EmpresaDAO();

  Future<int?> cadastrarEmpresa(
      EmpresaModel empresa, List<LogoModel> logos) async {
    return await _dao.insert(empresa, logos);
  }
}
