/* classe responsavel por se conctar com fontes de dados, onde irao estar os
dados da moeda */

import 'package:criptomoedas/models/moeda.dart';

class MoedaRepository {
  static List<Moeda> tabela  = [
    Moeda(
        icone: 'assets/bitcoin.png',
        nome: 'Bitcoin',
        sigla: 'BTC',
        preco: 164603.00
      ),
    
    Moeda(
        icone: 'assets/ethereum.png',
        nome: 'Ethereum',
        sigla: 'EHT',
        preco: 9716.00
      ),

    Moeda(
      icone: 'assets/xrp.png',
      nome: 'XRP',
      sigla: 'XRP',
      preco: 3.34,
    ),

    Moeda(
      icone: 'assets/cardano.png',
      nome: 'Cardano',
      sigla: 'ADA',
      preco: 6.32,
    ),

    Moeda(
      icone: 'assets/dollar.png',
      nome: 'USD coin',
      sigla: 'USD',
      preco: 669.93,
    ),
    

    Moeda(
      icone: 'assets/litecoin.png',
      nome: 'Litecoin',
      sigla: 'LTC',
      preco: 669.93,
    ),
  ];
  
}
