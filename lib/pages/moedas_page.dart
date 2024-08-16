import 'package:criptomoedas/configs/app_settings.dart';
import 'package:criptomoedas/models/moeda.dart';
import 'package:criptomoedas/pages/moedas_detalhes_page.dart';
import 'package:criptomoedas/repositories/favoritas_repository.dart';
import 'package:criptomoedas/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
    final tabela = MoedaRepository.tabela;
    late NumberFormat real;
    late Map<String, String> loc;
    List<Moeda> selecionadas = [];
    late FavoritasRepository favoritas;

  readNumeberFormat() { 
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
      icon: const Icon(Icons.language),
      itemBuilder: (context) => [
        PopupMenuItem(child: ListTile(  
          leading: const Icon(Icons.swap_vert),
          title: Text('Usar $locale'),
          onTap: (){  
            context.read<AppSettings>().setlocale(locale, name);
            Navigator.pop(context);
          },
        ))
      ],
    );
  }




  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: const Text(
          'Cripto Moedas',
          style: TextStyle( 
            color: Colors.white,
          ),
        ),
        actions: [  
          changeLanguageButton(),
        ],
        centerTitle: true,
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text(  
          '${selecionadas.length} selecionadas',
        ),
        backgroundColor: Colors.blueGrey[50],
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87,),
      );
    }
  }

    mostrarDetalhes(Moeda moeda) {
      Navigator.push(context, MaterialPageRoute(
          builder: (_) => MoedasDetalhesPage(moeda: moeda), 
          ),
        );
       
  }

  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {

    favoritas = context.watch<FavoritasRepository>();
    readNumeberFormat();

    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int moeda){
            return ListTile(  
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ), 
            leading:  (selecionadas.contains(tabela[moeda]))
              ? const CircleAvatar(
                child: Icon(Icons.check),
              )

            : SizedBox(
              width: 40,
              height: 40,
              child: Image.asset(tabela[moeda].icone),
            ),
            title: Row(
              children: [
                Text(
                  tabela[moeda].nome,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                  if (favoritas.lista
                      .contains((fav) => fav.sigla == tabela[moeda].sigla))
                  const Icon(Icons.circle, color:  Colors.amber, size: 8,),
              ],
            ),
              trailing: Text(real.format(tabela[moeda].preco),
              ),
              selected: selecionadas.contains(tabela[moeda]),
              selectedTileColor: Colors.indigo[50],
              onLongPress: (){
                setState(() {
                   (selecionadas.contains(tabela[moeda])) 
                    ? selecionadas.remove(tabela[moeda])
                    : selecionadas.add(tabela[moeda]);
                });

                debugPrint(tabela[moeda].nome);
              },

              onTap: () => mostrarDetalhes(tabela[moeda]),
              
            );
          },
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: tabela.length,
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty 
      ? FloatingActionButton.extended(
        onPressed: (){
          favoritas.saveAll(selecionadas);
          limparSelecionadas();
          
        }, 
        icon: const Icon(
          Icons.star,
        ),
        label: const Text(
          'FAVORITAR',
          style: TextStyle(  
            letterSpacing: 0,
            fontWeight: FontWeight.bold, 
            ),
          ), 
        ) 
        :null
    );
  }
  

}
