// import 'package:sistema_de_gestao_comercial/model/coordenada_bancaria_model.dart';

import '../model/db.dart';
import '../model/empresa_model.dart';
// import '../model/logo_model.dart';
// import '../model/produto_model.dart';

class EmpresaDAO {
  static const _empresaTable = "empresas";
  static const _contactoTable = "contactos";
  static const _coordenadaTable = "coordenadas_bancarias";
  static const _imagemTable = "imagens";
  final _instance = DB.instace;

  Future<List<Map<String, Object?>>> get all async {
    var db = await _instance.database;
    final res = await db!.query(_empresaTable);
    await _instance.close();
    return res;
  }

  Future<List<Map<String, Object?>>> getEmpresa(EmpresaModel empresa) async {
    var db = await _instance.database;
    final res = await db!
        .query(_empresaTable, where: "id = ?", whereArgs: [empresa.id]);
    await _instance.close();
    return res;
  }

  Future<List<Map<String, Object?>>> empresa(String nomeOrID) async {
    var db = await _instance.database;
    final res = await db!.query(_empresaTable,
        where: "id = ? or nome like ?", whereArgs: [nomeOrID, "%$nomeOrID%"]);
    await _instance.close();
    return res;
  }

  Future<List<Map<String, Object?>>> empresaDados(
      String table, int empresaID) async {
    var db = await _instance.database;
    final res = await db!.rawQuery(
        "select * from $table as t where t.empresa_id = ?", [empresaID]);
    await _instance.close();
    return res;
  }

  Future<int> remove(EmpresaModel empresa) async {
    var db = await _instance.database;
    final res = await db!
        .delete(_empresaTable, where: "id = ?", whereArgs: [empresa.id]);
    await _instance.close();
    return res;
  }

  Future<int?> insert(EmpresaModel empresa) async {
    // await _instance.close();
    var db = await _instance.database;
    const int erro = -1;
    var imgs = <int?>[];
    var cts = <int?>[];
    var cords = <int?>[];
    int? id = erro;
    try {
      id = await db?.insert(_empresaTable, empresa.toMap);

      for (var contacto in empresa.contactos) {
        contacto.empresaID = id;
        final res = await db?.insert(_contactoTable, contacto.toMap);
        cts.add(res);
      }

      for (var coordenada in empresa.coordenadas) {
        coordenada.empresaID = id;
        final res = await db?.insert(_coordenadaTable, coordenada.toMap);
        cords.add(res);
      }

      for (var logo in empresa.logos) {
        logo.empresaID = id;
        final res = await db?.insert(_imagemTable, logo.toMap);
        imgs.add(res);
      }

      await _instance.close();
      return id;
    } catch (e) {
      for (var id in cts) {
        // print("contactos $cts");
        await db?.delete(_contactoTable, where: "id = ?", whereArgs: [id]);
      }
      for (var id in cords) {
        // print("coordenadas $cords");
        await db?.delete(_coordenadaTable, where: "id = ?", whereArgs: [id]);
      }
      for (var id in imgs) {
        // print("imagens $imgs");
        await db?.delete(_imagemTable, where: "id = ?", whereArgs: [id]);
      }
      await db?.delete(_empresaTable, where: "id = ? ", whereArgs: [id]);

      // print("Erro $e");
    }
    // print(await db?.query(_empresaTable));
    // print(await db?.query(_contactoTable));
    // print(await db?.query(_coordenadaTable));
    // print(await db?.query(_imagemTable));

    await _instance.close();
    return erro; //  preencher
  }

  Future<int> update(EmpresaModel empresa) async {
    var db = await _instance.database;
    final res = await db!.update(_empresaTable, empresa.toMap,
        where: "id = ?", whereArgs: [empresa.id]);
    await _instance.close();
    return res;
  }
}
