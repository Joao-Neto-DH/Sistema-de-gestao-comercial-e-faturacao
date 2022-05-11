import 'package:sistema_de_gestao_comercial/view/model/coordenada_bancaria_model.dart';
import 'package:sistema_de_gestao_comercial/view/model/db.dart';
// import 'package:sistema_de_gestao_comercial/view/model/produto_model.dart';

class CoordenadaBancariaDAO {
  static const _table = "coordenadas";

  Future<List<Map<String, Object?>>> get all async {
    var db = await DB.instace.database;
    return db!.query(_table);
  }

  Future<List<Map<String, Object?>>> getProduto(
      CoordenadaBancariaModel produto) async {
    var db = await DB.instace.database;
    return db!.query(_table, where: "id = ?", whereArgs: [produto.id]);
  }

  Future<int> remove(CoordenadaBancariaModel produto) async {
    var db = await DB.instace.database;
    return db!.delete(_table, where: "id = ?", whereArgs: [produto.id]);
  }

  Future<int> insert(CoordenadaBancariaModel produto) async {
    var db = await DB.instace.database;
    return db!.insert(_table, {}); //  preencher
  }
}
