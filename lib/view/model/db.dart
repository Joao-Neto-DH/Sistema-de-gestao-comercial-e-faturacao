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
    await _generateTable(_db);
    return _db;
  }

  Future<void> _generateTable(Database? db) async {
    await db!.execute('''
    CREATE TABLE IF NOT EXISTS usuarios (
        id    INTEGER      PRIMARY KEY AUTOINCREMENT,
        email VARCHAR (60) NOT NULL
                          UNIQUE,
        nome  VARCHAR (60) NOT NULL,
        senha VARCHAR (60) NOT NULL
    );
    
    CREATE TABLE IF NOT EXISTS clientes (
        id       INTEGER        PRIMARY KEY AUTOINCREMENT,
        nome     VARCHAR (60)   NOT NULL,
        endereco VARCHAR (60)   NOT NULL,
        nif      VARCHAR (20)   NOT NULL,
        email    VARCHAR (60)   NOT NULL,
        credito  DECIMAL (8, 2),
        UNIQUE (
            nome,
            endereco,
            nif,
            email
        )
    );

    CREATE TABLE IF NOT EXISTS contactos (
        id         INTEGER      PRIMARY KEY AUTOINCREMENT,
        empresa_id INTEGER      NOT NULL
                                REFERENCES empresa (id),
        telefone   VARCHAR (14) NOT NULL,
        website    VARCHAR (60),
        email      VARCHAR (60) NOT NULL,
        UNIQUE (
            telefone,
            website,
            email
        )
    );

    CREATE TABLE IF NOT EXISTS coordenadas_bancarias (
        id         INTEGER      PRIMARY KEY AUTOINCREMENT,
        empresa_id INTEGER      NOT NULL,
        coordenada VARCHAR (25) NOT NULL,
        conta      VARCHAR (25),
        UNIQUE (
            coordenada,
            conta
        ),
        FOREIGN KEY (
            empresa_id
        )
        REFERENCES empresa (id) 
    );

    CREATE TABLE IF NOT EXISTS empresas (
        id       INTEGER      PRIMARY KEY AUTOINCREMENT,
        nome     VARCHAR (60) NOT NULL,
        nif      VARCHAR (20) NOT NULL,
        endereco VARCHAR (60) NOT NULL,
        cidade   VARCHAR (60) NOT NULL,
        UNIQUE (
            nome,
            nif,
            endereco,
            cidade
        )
    );

    CREATE TABLE IF NOT EXISTS imagens (
        id         INTEGER       PRIMARY KEY AUTOINCREMENT,
        empresa_id INTEGER       NOT NULL
                                REFERENCES empresa (id),
        logo       VARCHAR (100) NOT NULL,
        logo_marca BOOLEAN       DEFAULT false,
        UNIQUE (
            logo
        )
    );

    CREATE TABLE IF NOT EXISTS produtos (
        id    INTEGER         PRIMARY KEY AUTOINCREMENT,
        nome  VARCHAR (60)    NOT NULL,
        preco DECIMAL (12, 2) NOT NULL,
        iva   BOOLEAN         NOT NULL
                              DEFAULT false,
        stock INTEGER         NOT NULL
                              DEFAULT -1,
        UNIQUE (
            nome
        )
    );

    CREATE TABLE IF NOT EXISTS vendidos (
        id          INTEGER         PRIMARY KEY AUTOINCREMENT,
        produto_id  INTEGER         NOT NULL,
        cliente_id  INTEGER         NOT NULL,
        quantidade  INTEGER         NOT NULL,
        preco       DECIMAL (12, 2) NOT NULL,
        data_compra DATETIME        NOT NULL
                                    DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (
            produto_id
        )
        REFERENCES produtos (id),
        FOREIGN KEY (
            cliente_id
        )
        REFERENCES clientes (id) 
    );

    ''');
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
