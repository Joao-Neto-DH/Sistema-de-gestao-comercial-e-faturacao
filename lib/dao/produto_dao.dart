import '../model/db.dart';
import '../model/produto_model.dart';

class ProdutoDAO {
  static const _table = "produtos";
  final _instance = DB.instace;

  Future<List<Map<String, Object?>>> get all async {
    var db = await _instance.database;
    final res = await db!.query(_table);
    await _instance.close();
    return res;
  }

  Future<List<Map<String, Object?>>> getProduto(ProdutoModel produto) async {
    var db = await _instance.database;
    final res = await db!
        .query(_table, where: "id = ? or nome = ?", whereArgs: [produto.id]);
    await _instance.close();
    return res;
  }

  Future<List<Map<String, Object?>>> getProdutoByNomeOrId(
      String nomeOrId) async {
    var db = await _instance.database;
    final res = await db!.query(_table,
        where: "id = ? or nome like ?", whereArgs: [nomeOrId, "%$nomeOrId%"]);
    await _instance.close();
    return res;
  }

  Future<int> remove(ProdutoModel produto) async {
    var db = await _instance.database;
    final res =
        await db!.delete(_table, where: "id = ?", whereArgs: [produto.id]);
    await _instance.close();
    return res;
  }

  Future<int> insert(ProdutoModel produto) async {
    var db = await _instance.database;
    final res = await db!.insert(_table, produto.toMap); //  preencher
    await _instance.close();
    return res;
  }

  Future<int> update(ProdutoModel produto) async {
    var db = await _instance.database;
    final res = await db!.update(_table, produto.toMap,
        where: "id = ?", whereArgs: [produto.id]);
    await _instance.close();
    return res;
  }
}
