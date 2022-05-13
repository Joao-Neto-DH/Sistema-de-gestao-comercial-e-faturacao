import 'package:sistema_de_gestao_comercial/view/model/db.dart';
import 'package:sistema_de_gestao_comercial/view/model/empresa_model.dart';
// import 'package:sistema_de_gestao_comercial/view/model/produto_model.dart';

class EmpresaDAO {
  static const _table = "empresas";
  static const _table2 = "contactos";

  Future<List<Map<String, Object?>>> get all async {
    var db = await DB.instace.database;
    return db!.query(_table);
  }

  Future<List<Map<String, Object?>>> getEmpresa(EmpresaModel empresa) async {
    var db = await DB.instace.database;
    return db!.query(_table, where: "id = ?", whereArgs: [empresa.id]);
  }

  Future<int> remove(EmpresaModel empresa) async {
    var db = await DB.instace.database;
    return db!.delete(_table, where: "id = ?", whereArgs: [empresa.id]);
  }

  Future<int> insert(EmpresaModel empresa) async {
    var db = await DB.instace.database;
    return db!.insert(_table, empresa.toMap); //  preencher
  }

  Future<int> update(EmpresaModel empresa) async {
    var db = await DB.instace.database;
    return db!.update(_table, empresa.toMap,
        where: "id = ?", whereArgs: [empresa.id]);
  }
}
