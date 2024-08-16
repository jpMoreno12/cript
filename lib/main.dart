import 'package:criptomoedas/configs/app_settings.dart';
import 'package:criptomoedas/configs/hive_config.dart';
import 'package:criptomoedas/meu_aplicativo.dart';
import 'package:criptomoedas/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AppSettings()
        ),
      ChangeNotifierProvider(
        create:  (context) => FavoritasRepository(),
        ),
      ],
      child: const MeuAplicativo(),
    ),
  );
}
