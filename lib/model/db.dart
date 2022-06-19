import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static const String _name = "sistema_de_gestao_comercial.db";
  static const int _version = 1;

  DB._privateConstrator();
  static DB instace = DB._privateConstrator();

  static Database? _db;

  Future<Database?> get database async {
    // print("BD START: $_db");
    if (_db != null) return _db;
    var paths = await getDatabasesPath();
    var path = join(paths, _name);
    _db = await openDatabase(
      path,
      version: _version,
    );
    try {
      await _generateTable(_db);
      // ignore: empty_catches
    } catch (e) {}
    // print("BD END: $_db");
    return _db;
  }

  Future<void> _generateTable(Database? db) async {
    await db!.execute('''
    CREATE TABLE if not exists usuarios (
        id    INTEGER      PRIMARY KEY AUTOINCREMENT,
        nome  VARCHAR (60) NOT NULL,
        email VARCHAR (60) NOT NULL
                          UNIQUE,
        senha VARCHAR (40) NOT NULL
    )''');

    await db.execute('''CREATE TABLE if not exists empresas (
        id         INTEGER      PRIMARY KEY AUTOINCREMENT,
        nome       VARCHAR (60) NOT NULL UNIQUE,
        nif        VARCHAR (20) NOT NULL UNIQUE,
        endereco   VARCHAR (60) NOT NULL UNIQUE,
        cidade     VARCHAR (60) NOT NULL,
        website    VARCHAR (60),
        email      VARCHAR (60)
    )''');

    await db.execute('''CREATE TABLE if not exists clientes (
        id       INTEGER        PRIMARY KEY AUTOINCREMENT,
        nome     VARCHAR (60)   NOT NULL,
        endereco VARCHAR (60),
        nif      VARCHAR (20),
        email    VARCHAR (60),
        credito  DECIMAL (8, 2),
        UNIQUE (
            nif,
            email
        )
    )''');

    await db.execute('''CREATE TABLE if not exists contactos (
        id         INTEGER      PRIMARY KEY AUTOINCREMENT,
        empresa_id INTEGER      NOT NULL
                                REFERENCES empresa (id),
        telefone   VARCHAR (14) NOT NULL,
        UNIQUE (
            telefone
        )
    )''');

    await db.execute('''CREATE TABLE if not exists coordenadas_bancarias (
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
    )''');

    await db.execute('''CREATE TABLE if not exists imagens (
        id         INTEGER       PRIMARY KEY AUTOINCREMENT,
        empresa_id INTEGER       NOT NULL
                                REFERENCES empresa (id),
        logo       VARCHAR (100) NOT NULL,
        logo_marca BOOLEAN       DEFAULT false
    )''');

    await db.execute('''CREATE TABLE if not exists produtos (
        id    INTEGER         PRIMARY KEY AUTOINCREMENT,
        nome  VARCHAR (60)    NOT NULL UNIQUE,
        preco DECIMAL (12, 2) NOT NULL,
        iva   BOOLEAN         NOT NULL
                              DEFAULT false,
        stock INTEGER         NOT NULL
                              DEFAULT -1
    )''');

    await db.execute('''CREATE TABLE if not exists vendidos (
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
    )
    ''');
  }

  Future<void> close() async {
    if (_db != null && _db!.isOpen) {
      // print("fechando a conexao");
      await _db!.close();
      _db = null;
    }
  }
}
