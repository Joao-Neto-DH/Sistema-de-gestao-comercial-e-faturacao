import 'package:sistema_de_gestao_comercial/view/model/cliente_model.dart';
import 'package:sistema_de_gestao_comercial/view/model/db.dart';
// import 'package:sistema_de_gestao_comercial/view/model/produto_model.dart';

class ClienteDAO {
  static const _table = "clientes";

  Future<List<Map<String, Object?>>> get all async {
    var db = await DB.instace.database;
    return db!.query(_table);
  }

  Future<List<Map<String, Object?>>> getCliente(ClienteModel cliente) async {
    var db = await DB.instace.database;
    return db!.query(_table,
        where: "id = ? like nome = ?",
        whereArgs: [cliente.id, cliente.nome],
        limit: 1);
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
