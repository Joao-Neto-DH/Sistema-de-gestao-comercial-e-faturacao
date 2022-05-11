import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static const String _name = "sistema_de_gestao_comercial.db";
  static const int _version = 1;

  DB._privateConstrator();
  static DB instace = DB._privateConstrator();

  static Database? _db;

  Future<Database?> get database async {
    if (_db != null) return _db;
    var paths = await getDatabasesPath();
    var path = join(paths, _name);
    _db = await openDatabase(
      path,
      version: _version,
    );
    await _db!.execute('''
      CREATE TABLE if not exists clientes (
        id       INTEGER AUTO INCREMENT not null,
        nome     VARCHAR (50)             NOT NULL,
        endereco VARCHAR (50)             NOT NULL,
        nif      VARCHAR (14)             NOT NULL,
        email    VARCHAR (30)             NOT NULL,
        credito  DECIMAL (5, 2),
        PRIMARY KEY (
            id
        ),
        UNIQUE (
            nome,
            endereco,
            nif,
            email
        )
    )
''');
    return _db;
  }

  Future<void> close() async {
    if (_db != null && _db!.isOpen) {
      await _db!.close();
      _db = null;
    }
  }

  Future<int> insert() async {
    if (_db != null && _db!.isOpen) {
      return await _db!.insert("clientes", <String, Object>{
        "nome": "Delcio",
        "endereco": "Viana",
        "nif": "123456",
        "email": "joaolima88@gmial.com"
      });
    }
    return -1;
  }

  Future<List<Map<String, Object?>>> get all async {
    if (_db != null && _db!.isOpen) {
      return await _db!.rawQuery("select * from clientes");
    }
    return [];
  }
}
