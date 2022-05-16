import '../model/db.dart';
import '../model/produto_model.dart';

class ProdutoDAO {
  static const _table = "produtos";

  Future<List<Map<String, Object?>>> get all async {
    var db = await DB.instace.database;
    return db!.query(_table);
  }

  Future<List<Map<String, Object?>>> getProduto(ProdutoModel produto) async {
    var db = await DB.instace.database;
    return db!.query(_table, where: "id = ?", whereArgs: [produto.id]);
  }

  Future<int> remove(ProdutoModel produto) async {
    var db = await DB.instace.database;
    return db!.delete(_table, where: "id = ?", whereArgs: [produto.id]);
  }

  Future<int> insert(ProdutoModel produto) async {
    var db = await DB.instace.database;
    return db!.insert(_table, produto.toMap); //  preencher
  }

  Future<int> update(ProdutoModel produto) async {
    var db = await DB.instace.database;
    return db!.update(_table, {}, where: "id = ?", whereArgs: [produto.id]);
  }
}
