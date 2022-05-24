import '../model/cliente_model.dart';
import '../model/db.dart';
// import '../model/produto_model.dart';

class ClienteDAO {
  static const _table = "clientes";

  Future<List<Map<String, Object?>>> get all async {
    var db = await DB.instace.database;
    return db!.query(_table);
  }

  Future<List<Map<String, Object?>>> getCliente(ClienteModel cliente) async {
    var db = await DB.instace.database;
    return db!.query(_table,
        where: "id = ? or nome like ?",
        whereArgs: [cliente.id, cliente.nome],
        limit: 1);
  }

  Future<List<Map<String, Object?>>> cliente(String nomeOrID) async {
    var db = await DB.instace.database;
    return db!.query(_table,
        where: "id = ? or nome like ?", whereArgs: [nomeOrID, "%$nomeOrID%"]);
  }

  Future<int> remove(ClienteModel cliente) async {
    var db = await DB.instace.database;
    return db!.delete(_table, where: "id = ?", whereArgs: [cliente.id]);
  }

  Future<int> insert(ClienteModel cliente) async {
    var db = await DB.instace.database;
    return db!.insert(_table, cliente.toMap);
  }

  Future<int> update(ClienteModel cliente) async {
    var db = await DB.instace.database;
    return db!.update(_table, cliente.toMap,
        where: "id = ?", whereArgs: [cliente.id]);
  }
}
