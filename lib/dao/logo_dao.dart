import '../model/db.dart';
// import '../model/empresa_model.dart';
import '../model/logo_model.dart';
// import '../model/produto_model.dart';

class LogoDAO {
  static const _table = "imagens";
  final _instance = DB.instace;

  Future<List<Map<String, Object?>>> all(int empresaID) async {
    var db = await _instance.database;
    final res = await db!
        .query(_table, where: "empresa_id = ?", whereArgs: [empresaID]);
    await _instance.close();
    return res;
  }

  Future<List<Map<String, Object?>>> getLogo(LogoModel logo) async {
    var db = await _instance.database;
    final res = await db!.query(_table, where: "id = ?", whereArgs: [logo.id]);
    await _instance.close();
    return res;
  }

  Future<int> remove(LogoModel logo) async {
    var db = await _instance.database;
    final res = await db!.delete(_table, where: "id = ?", whereArgs: [logo.id]);
    await _instance.close();
    return res;
  }

  Future<int> insert(LogoModel logo) async {
    var db = await _instance.database;
    final res = await db!.insert(_table, logo.toMap); //  preencher
    await _instance.close();
    return res;
  }

  Future<int> update(LogoModel logo) async {
    var db = await _instance.database;
    final res = await db!
        .update(_table, logo.toMap, where: "id = ?", whereArgs: [logo.id]);
    await _instance.close();
    return res;
  }
}
