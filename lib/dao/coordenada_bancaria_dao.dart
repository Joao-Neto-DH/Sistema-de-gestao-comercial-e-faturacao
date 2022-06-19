import '../model/coordenada_bancaria_model.dart';
import '../model/db.dart';
// import '../model/produto_model.dart';

class CoordenadaBancariaDAO {
  static const _table = "coordenadas";
  final _instance = DB.instace;

  Future<List<Map<String, Object?>>> get all async {
    var db = await _instance.database;
    final res = await db!.query(_table);
    await _instance.close();
    return res;
  }

  Future<List<Map<String, Object?>>> getCoordenada(
      CoordenadaBancariaModel coordenada) async {
    var db = await _instance.database;
    final res =
        await db!.query(_table, where: "id = ?", whereArgs: [coordenada.id]);
    await _instance.close();
    return res;
  }

  Future<int> remove(CoordenadaBancariaModel coordenada) async {
    var db = await _instance.database;
    final res =
        await db!.delete(_table, where: "id = ?", whereArgs: [coordenada.id]);
    await _instance.close();
    return res;
  }

  Future<int> insert(CoordenadaBancariaModel coordenada) async {
    var db = await _instance.database;
    final res = await db!.insert(_table, coordenada.toMap); //  preencher
    await _instance.close();
    return res;
  }

  Future<int> update(CoordenadaBancariaModel coordenada) async {
    var db = await _instance.database;
    final res = await db!.update(_table, coordenada.toMap,
        where: "id = ?", whereArgs: [coordenada.id]);
    await _instance.close();
    return res;
  }
}
