import 'package:criptomoedas/models/moeda.dart';

class Posicao {
  Moeda moeda;
  double quantidade;

  Posicao({
    required this.moeda,
    required this.quantidade,
  });
}
