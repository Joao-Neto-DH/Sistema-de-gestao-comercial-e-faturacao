import '../model/db.dart';
import '../model/empresa_model.dart';
// import '../model/produto_model.dart';

class ContactoDAO {
  static const _table = "contactos";

  Future<List<Map<String, Object?>>> all(int empresaID) async {
    var db = await DB.instace.database;
    return db!.query(_table, where: "empresa_id = ?", whereArgs: [empresaID]);
  }

  Future<List<Map<String, Object?>>> getContacto(ContactoModel contacto) async {
    var db = await DB.instace.database;
    return db!.query(_table, where: "id = ?", whereArgs: [contacto.id]);
  }

  Future<int> remove(ContactoModel contacto) async {
    var db = await DB.instace.database;
    return db!.delete(_table, where: "id = ?", whereArgs: [contacto.id]);
  }

  Future<int> insert(ContactoModel contacto) async {
    var db = await DB.instace.database;
    return db!.insert(_table, contacto.toMap); //  preencher
  }

  Future<int> update(ContactoModel contacto) async {
    var db = await DB.instace.database;
    return db!.update(_table, contacto.toMap,
        where: "id = ?", whereArgs: [contacto.id]);
  }
}
