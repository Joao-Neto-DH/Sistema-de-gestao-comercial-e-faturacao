import '../model/usuario_model.dart';
import 'package:sqflite/sqflite.dart';

import '../model/db.dart';

class UsuarioDAO {
  static const _table = "usuarios";
  final _instance = DB.instace;

  Future<List<Map<String, Object?>>> get all async {
    var db = await _instance.database;
    final res = await db!.query(_table);
    await _instance.close();
    return res;
  }

  Future<List<Map<String, Object?>>> getUsuario(UsuarioModel usuario) async {
    var db = await _instance.database;
    // print( await db!.query(_table));
    final res = await db!.query(_table,
        where: "email = ? and senha = ?",
        whereArgs: [usuario.email, usuario.senha],
        limit: 1);
    await _instance.close();
    return res;
  }

  Future<int> remove(UsuarioModel usuario) async {
    var db = await _instance.database;
    final res =
        await db!.delete(_table, where: "id = ?", whereArgs: [usuario.id]);
    await _instance.close();
    return res;
  }

  Future<int> insert(UsuarioModel usuario) async {
    var db = await _instance.database;
    final res = await db!.insert(_table, usuario.toMap,
        conflictAlgorithm: ConflictAlgorithm.rollback);
    await _instance.close();
    return res;
  }

  Future<int> update(UsuarioModel usuario) async {
    var db = await _instance.database;
    final res = await db!.update(_table, usuario.toMap,
        where: "id = ?", whereArgs: [usuario.id]);
    await _instance.close();
    return res;
  }
}
