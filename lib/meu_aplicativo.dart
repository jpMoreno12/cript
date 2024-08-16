import 'package:criptomoedas/pages/home_page.dart';
import 'package:flutter/material.dart';

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Moedabase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(  
        primaryColor: Colors.indigo,
        appBarTheme: const AppBarTheme(  
          color: Colors.indigo,
        )
      ), 
      home: const HomePage(),
    );
  }
}
