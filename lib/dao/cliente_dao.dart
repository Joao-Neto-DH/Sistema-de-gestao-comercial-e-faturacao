import '../model/cliente_model.dart';
import '../model/db.dart';
// import '../model/produto_model.dart';

class ClienteDAO {
  static const _table = "clientes";
  final instance = DB.instace;

  Future<List<Map<String, Object?>>> get all async {
    var db = await instance.database;
    return await db!.query(_table);
  }

  Future<List<Map<String, Object?>>> getCliente(ClienteModel cliente) async {
    var db = await instance.database;
    final res = await db!.query(_table,
        where: "id = ? or nome like ?",
        whereArgs: [cliente.id, cliente.nome],
        limit: 1);

    await instance.close();

    return res;
  }

  Future<List<Map<String, Object?>>> cliente(String nomeOrID) async {
    var db = await instance.database;
    final res = await db!.query(_table,
        where: "id = ? or nome like ?", whereArgs: [nomeOrID, "%$nomeOrID%"]);
    await instance.close();
    return res;
  }

  Future<int> remove(ClienteModel cliente) async {
    var db = await instance.database;
    final res =
        await db!.delete(_table, where: "id = ?", whereArgs: [cliente.id]);
    await instance.close();
    return res;
  }

  Future<int> insert(ClienteModel cliente) async {
    var db = await instance.database;
    final res = await db!.insert(_table, cliente.toMap);
    await instance.close();
    return res;
  }

  Future<int> update(ClienteModel cliente) async {
    var db = await instance.database;
    final res = await db!.update(_table, cliente.toMap,
        where: "id = ?", whereArgs: [cliente.id]);
    await instance.close();
    return res;
  }
}
