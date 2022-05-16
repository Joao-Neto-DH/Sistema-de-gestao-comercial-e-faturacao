import '../model/db.dart';
import '../model/empresa_model.dart';
// import '../model/produto_model.dart';

class EmpresaDAO {
  static const _table = "empresas";

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
    await DB.instace.close();
    var db = await DB.instace.database;
    print(await db!.query(_table));
    return db.insert(_table, empresa.toMap); //  preencher
  }

  Future<int> update(EmpresaModel empresa) async {
    var db = await DB.instace.database;
    return db!.update(_table, empresa.toMap,
        where: "id = ?", whereArgs: [empresa.id]);
  }
}
