import '../model/db.dart';
import '../model/empresa_model.dart';
// import '../model/produto_model.dart';

class ContactoDAO {
  static const _table = "contactos";
  final _instance = DB.instace;

  Future<List<Map<String, Object?>>> all(int empresaID) async {
    var db = await _instance.database;
    final res = await db!
        .query(_table, where: "empresa_id = ?", whereArgs: [empresaID]);
    await _instance.close();
    return res;
  }

  Future<List<Map<String, Object?>>> getContacto(ContactoModel contacto) async {
    var db = await _instance.database;
    final res =
        await db!.query(_table, where: "id = ?", whereArgs: [contacto.id]);
    await _instance.close();
    return res;
  }

  Future<int> remove(ContactoModel contacto) async {
    var db = await _instance.database;
    final res =
        await db!.delete(_table, where: "id = ?", whereArgs: [contacto.id]);
    await _instance.close();
    return res;
  }

  Future<int> insert(ContactoModel contacto) async {
    var db = await _instance.database;
    final res = await db!.insert(_table, contacto.toMap); //  preencher
    await _instance.close();
    return res;
  }

  Future<int> update(ContactoModel contacto) async {
    var db = await _instance.database;
    final res = await db!.update(_table, contacto.toMap,
        where: "id = ?", whereArgs: [contacto.id]);
    await _instance.close();
    return res;
  }
}
