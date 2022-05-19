import '../model/db.dart';
// import '../model/empresa_model.dart';
import '../model/logo_model.dart';
// import '../model/produto_model.dart';

class LogoDAO {
  static const _table = "imagens";

  Future<List<Map<String, Object?>>> all(int empresaID) async {
    var db = await DB.instace.database;
    return db!.query(_table, where: "empresa_id = ?", whereArgs: [empresaID]);
  }

  Future<List<Map<String, Object?>>> getLogo(LogoModel logo) async {
    var db = await DB.instace.database;
    return db!.query(_table, where: "id = ?", whereArgs: [logo.id]);
  }

  Future<int> remove(LogoModel logo) async {
    var db = await DB.instace.database;
    return db!.delete(_table, where: "id = ?", whereArgs: [logo.id]);
  }

  Future<int> insert(LogoModel logo) async {
    var db = await DB.instace.database;
    return db!.insert(_table, logo.toMap); //  preencher
  }

  Future<int> update(LogoModel logo) async {
    var db = await DB.instace.database;
    return db!
        .update(_table, logo.toMap, where: "id = ?", whereArgs: [logo.id]);
  }
}
