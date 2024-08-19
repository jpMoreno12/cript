import 'package:criptomoedas/pages/configuracoes_page.dart';
import 'package:criptomoedas/pages/favoritas_page.dart';
import 'package:criptomoedas/pages/moedas_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  @override
  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  abac(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(  
        controller: pc,
        onPageChanged: setPaginaAtual ,
        children: const [  
          MoedasPage(),
          FavoritasPage(),
          ConfiguracoesPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(  
        currentIndex: paginaAtual,
        items: const [  
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todas'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritas'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Conta'),
        ],
        onTap: (pagina) => 
        pc.animateToPage(pagina,
            duration: const Duration(milliseconds: 400), curve: Curves.ease),
      ),
    );
  }
}
