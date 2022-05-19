import 'package:sistema_de_gestao_comercial/model/coordenada_bancaria_model.dart';

import '../model/db.dart';
import '../model/empresa_model.dart';
import '../model/logo_model.dart';
// import '../model/produto_model.dart';

class EmpresaDAO {
  static const _empresaTable = "empresas";
  static const _contactoTable = "contactos";
  static const _coordenadaTable = "coordenadas_bancarias";
  static const _imagemTable = "imagens";

  Future<List<Map<String, Object?>>> get all async {
    var db = await DB.instace.database;
    return db!.query(_empresaTable);
  }

  Future<List<Map<String, Object?>>> getEmpresa(EmpresaModel empresa) async {
    var db = await DB.instace.database;
    return db!.query(_empresaTable, where: "id = ?", whereArgs: [empresa.id]);
  }

  Future<int> remove(EmpresaModel empresa) async {
    var db = await DB.instace.database;
    return db!.delete(_empresaTable, where: "id = ?", whereArgs: [empresa.id]);
  }

  Future<int?> insert(EmpresaModel empresa, List<ContactoModel> contactos,
      List<CoordenadaBancariaModel> coordenadas, List<LogoModel> logos) async {
    // await DB.instace.close();
    var db = await DB.instace.database;
    const int erro = -1;
    const imgs = <int?>[];
    const cts = <int?>[];
    const cords = <int?>[];
    int? id = erro;
    try {
      id = await db?.insert(_empresaTable, empresa.toMap);

      for (var contacto in contactos) {
        contacto.empresaID = id;
        final res = await db?.insert(_contactoTable, contacto.toMap);
        cts.add(res);
      }

      for (var coordenada in coordenadas) {
        coordenada.empresaID = id;
        final res = await db?.insert(_coordenadaTable, coordenada.toMap);
        cords.add(res);
      }

      for (var logo in logos) {
        logo.empresaID = id;
        final res = await db?.insert(_imagemTable, logo.toMap);
        imgs.add(res);
      }

      return id;
    } catch (e) {
      for (var id in cts) {
        await db?.delete(_contactoTable, where: "id = ?", whereArgs: [id]);
      }
      for (var id in cords) {
        await db?.delete(_coordenadaTable, where: "id = ?", whereArgs: [id]);
      }
      for (var id in imgs) {
        await db?.delete(_imagemTable, where: "id = ?", whereArgs: [id]);
      }
      if (id != erro)
        await db?.delete(_empresaTable, where: "id = ? ", whereArgs: [id]);

      print("Erro em transiction $e");
    }
    print(await db?.query(_empresaTable));
    print(await db?.query(_contactoTable));
    print(await db?.query(_coordenadaTable));
    print(await db?.query(_imagemTable));
    return erro; //  preencher
  }

  Future<int> update(EmpresaModel empresa) async {
    var db = await DB.instace.database;
    return db!.update(_empresaTable, empresa.toMap,
        where: "id = ?", whereArgs: [empresa.id]);
  }
}
