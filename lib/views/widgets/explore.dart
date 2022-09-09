import 'package:biblioteca_jogos/models/jogo.dart';
import 'package:biblioteca_jogos/services/request_api.dart';
import 'package:biblioteca_jogos/views/widgets/games_gridview.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  late Future<List<Jogo>>? futureJogos;
  late List<Jogo> listaJogos;
  APIRequest req = APIRequest();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    listaJogos = [];
    futureJogos = req.searchGamesByText('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.text,
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                setState(() {
                  futureJogos = req.searchGamesByText(value);
                });
              });
            },
          ),
          Expanded(
              child: FutureBuilder(
            future: futureJogos,
            builder: (context, snapshot) {
              final int tam = MediaQuery.of(context).size.width ~/ 150;

              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
              }
              List<Jogo> list = snapshot.data ?? [];
              return GamesGridView(tam: tam, snapshot: snapshot, list: list);
            },
          ))
        ],
      ),
    );
  }
}
