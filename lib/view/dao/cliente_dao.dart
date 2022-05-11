import 'package:sistema_de_gestao_comercial/view/model/cliente_model.dart';
import 'package:sistema_de_gestao_comercial/view/model/db.dart';
import 'package:sistema_de_gestao_comercial/view/model/produto_model.dart';

class ClienteDAO {
  static const _table = "clientes";

  Future<List<Map<String, Object?>>> get all async {
    var db = await DB.instace.database;
    return db!.query(_table);
  }

  Future<List<Map<String, Object?>>> getProduto(ClienteModel produto) async {
    var db = await DB.instace.database;
    return db!.query(_table, where: "id = ?", whereArgs: [produto.id]);
  }

  Future<int> remove(ClienteModel produto) async {
    var db = await DB.instace.database;
    return db!.delete(_table, where: "id = ?", whereArgs: [produto.id]);
  }

  Future<int> insert(ClienteModel produto) async {
    var db = await DB.instace.database;
    return db!.insert(_table, {}); //  preencher
  }
}
