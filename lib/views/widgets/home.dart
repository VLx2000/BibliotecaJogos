import 'dart:async';
import 'package:biblioteca_jogos/components/cover.dart';
import 'package:biblioteca_jogos/models/jogo.dart';
import 'package:biblioteca_jogos/services/request_api.dart';
import 'package:biblioteca_jogos/views/game.dart';
import 'package:biblioteca_jogos/views/widgets/games_gridview.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Jogo>>? futureJogos;
  late List<Jogo> listaJogos;
  APIRequest req = APIRequest();

  @override
  void initState() {
    super.initState();
    listaJogos = [];
    futureJogos = req.fetchGameRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    final int tam = MediaQuery.of(context).size.width ~/ 150;
    return FutureBuilder<List<Jogo>>(
      future: futureJogos,
      builder: (context, snapshot) {
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
    );
  }
}
