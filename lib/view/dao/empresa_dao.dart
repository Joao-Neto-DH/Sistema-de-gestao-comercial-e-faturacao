import 'package:sistema_de_gestao_comercial/view/model/db.dart';
import 'package:sistema_de_gestao_comercial/view/model/empresa_model.dart';
// import 'package:sistema_de_gestao_comercial/view/model/produto_model.dart';

class EmpresaDAO {
  static const _table = "empresas";

  Future<List<Map<String, Object?>>> get all async {
    var db = await DB.instace.database;
    return db!.query(_table);
  }

  Future<List<Map<String, Object?>>> getEmpresa(EmpresaModel produto) async {
    var db = await DB.instace.database;
    return db!.query(_table, where: "id = ?", whereArgs: [produto.id]);
  }

  Future<int> remove(EmpresaModel produto) async {
    var db = await DB.instace.database;
    return db!.delete(_table, where: "id = ?", whereArgs: [produto.id]);
  }

  Future<int> insert(EmpresaModel produto) async {
    var db = await DB.instace.database;
    return db!.insert(_table, {}); //  preencher
  }
}
