
import 'package:criptomoedas/database/db.dart';
import 'package:criptomoedas/models/posicao.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class ContaRepository extends ChangeNotifier{
  late Database db; //recupera a instancia do Banco de dados
  final List<Posicao> _carteira = [];
  double _saldo = 0;

  //retorna o saldo de forma publica
  get saldo => _saldo;
  List<Posicao> get carteira => _carteira;

  ContaRepository() {
    _initRepository();
  }
  
  _initRepository() async {
    await _getSaldo();
  }

  _getSaldo() async {
/*     instanciando o databaase */
    db = await DB.instance.database;
    List conta = await db.query('conta', limit: 1);
    _saldo = conta.first['saldo'];
    notifyListeners();
  }

  setSaldo(double valor) async {
    db = await DB.instance.database;
    db.update('conta', {
      'saldo': valor
    });
    _saldo = valor;
    notifyListeners();
  }
}
