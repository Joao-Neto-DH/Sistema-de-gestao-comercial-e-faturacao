import '../model/coordenada_bancaria_model.dart';
import '../model/db.dart';
// import '../model/produto_model.dart';

class CoordenadaBancariaDAO {
  static const _table = "coordenadas";

  Future<List<Map<String, Object?>>> get all async {
    var db = await DB.instace.database;
    return db!.query(_table);
  }

  Future<List<Map<String, Object?>>> getCoordenada(
      CoordenadaBancariaModel coordenada) async {
    var db = await DB.instace.database;
    return db!.query(_table, where: "id = ?", whereArgs: [coordenada.id]);
  }

  Future<int> remove(CoordenadaBancariaModel coordenada) async {
    var db = await DB.instace.database;
    return db!.delete(_table, where: "id = ?", whereArgs: [coordenada.id]);
  }

  Future<int> insert(CoordenadaBancariaModel coordenada) async {
    var db = await DB.instace.database;
    return db!.insert(_table, {}); //  preencher
  }

  Future<int> update(CoordenadaBancariaModel coordenada) async {
    var db = await DB.instace.database;
    return db!.update(_table, {}, where: "id = ?", whereArgs: [coordenada.id]);
  }
}
