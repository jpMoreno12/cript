import 'dart:collection';

import 'package:criptomoedas/adapters/moeda_hive_adapter.dart';
import 'package:criptomoedas/models/moeda.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritasRepository extends ChangeNotifier {  
  final List<Moeda> _lista = [];
  late LazyBox box;


  FavoritasRepository(){
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readFavoritas();
  }

  _openBox() async{
    Hive.registerAdapter(MoedaHiveAdapter());
    box = await Hive.openLazyBox<Moeda>('moedas_favoritas');
  }

  _readFavoritas() {
    box.keys.forEach((moeda) async {
      Moeda m = await box.get(moeda);
      _lista.add(m);
      notifyListeners();
    });
  }

  UnmodifiableListView<Moeda> get lista => UnmodifiableListView(_lista);
  

  saveAll(List<Moeda> moedas) {
      for (var moeda in moedas) {
        if(!_lista.any((atual) => atual.sigla == moeda.sigla)) {
          _lista.add(moeda);
          box.put(moeda.sigla, moeda) ;
        }
      }}
  remove(Moeda moeda) {
    _lista.remove(moeda);
    box.delete(moeda.sigla);
    notifyListeners();
  }
}
