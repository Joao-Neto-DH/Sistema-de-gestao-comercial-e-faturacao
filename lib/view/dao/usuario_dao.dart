import 'package:sistema_de_gestao_comercial/view/model/usuario_model.dart';

import '../model/db.dart';

class UsuarioDAO {
  static const _table = "usuarios";

  Future<List<Map<String, Object?>>> get all async {
    var db = await DB.instace.database;
    return db!.query(_table);
  }

  Future<List<Map<String, Object?>>> getUsuario(UsuarioModel usuario) async {
    var db = await DB.instace.database;
    return db!.query(_table,
        where: "id = ? like email = ?",
        whereArgs: [usuario.id, usuario.email],
        limit: 1);
  }

  Future<int> remove(UsuarioModel usuario) async {
    var db = await DB.instace.database;
    return db!.delete(_table, where: "id = ?", whereArgs: [usuario.id]);
  }

  Future<int> insert(UsuarioModel usuario) async {
    var db = await DB.instace.database;
    return db!.insert(_table, usuario.toMap);
  }

  Future<int> update(UsuarioModel usuario) async {
    var db = await DB.instace.database;
    return db!.update(_table, usuario.toMap,
        where: "id = ?", whereArgs: [usuario.id]);
  }
}
