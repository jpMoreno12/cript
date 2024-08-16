/* singleton; e um padrao de projeto que permite que uma
classe gerencia a sua propria instanciacao e que somente 
uma instancia desta classe possa ser criada  */


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  // Contrutor com acesso privado
  DB._();

  //Criar uma instancia de DB
  static final DB instance = DB._();

  //instancia do SQLite
  static Database? _database;

  get database async {
    if(_database != null ) return _database;

    return await _initDatabase();

  }
  _initDatabase() async {
    return await openDatabase (  
      join(await getDatabasesPath(), 'cripto.db'),
      version: 1,
      onCreate: _onCreate, 
    );
  }

  _onCreate(db, versao) async {
    await db.execute(_conta);
    await db.execute(_carteira);
    await db.execute(_historico);
    await db.insert('conta', {'saldo': 0});
  }

  //Criando estruturas das tabelas
  String get _conta => ''' 
    CREATE TABLE conta( 
    id INTERGER  PRIMARY KEY AUTOINCREMENT,
    saldo REAL 
    ); 
  '''; 
  
  String get _carteira => '''
    CREATE TABLE carteira (
    sigla TEXT PRIMARY KEY, 
    moeda TEXT,
    quantidade TEXT
    );
  ''';

  String get _historico => '''
    CREATE TABLE historico (
      id INTEGER PRIMARY KEY AUTO INCREMENT,
      data_operacao INT,
      tipo_operacao TEXT,
      moeda TEXT,
      sigla TEXT,
      valor REAL,
      quantidade TEXT
    );
  ''';
}
