import 'dart:async';
import 'package:biblioteca_jogos/models/jogo.dart';
import 'package:biblioteca_jogos/services/request_api.dart';
import 'package:biblioteca_jogos/views/Home/widgets/games_gridview.dart';
import 'package:flutter/material.dart';

class RecommendationsView extends StatefulWidget {
  const RecommendationsView({super.key});

  @override
  State<RecommendationsView> createState() => _RecommendationsViewState();
}

class _RecommendationsViewState extends State<RecommendationsView> {
  late Future<List<Jogo>> futureJogos;
  APIRequest req = APIRequest();

  @override
  void initState() {
    super.initState();
    futureJogos = req.fetchGameRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    final int tam = MediaQuery.of(context).size.width ~/ 150;
    return RefreshIndicator(
      onRefresh: () {
        setState(() {
          futureJogos = req.fetchGameRecommendations();
        });
        return futureJogos;
      },
      child: FutureBuilder<List<Jogo>>(
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
          if (list.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Verifique sua conexão',
                  style: TextStyle(
                    color: Colors.white,
                    decorationColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      futureJogos = req.fetchGameRecommendations();
                    });
                  },
                  icon: const Icon(
                    Icons.refresh,
                    size: 24.0,
                  ),
                  label: const Text('Recarregar'),
                ),
              ],
            );
          } else {
            return GamesGridView(tam: tam, list: list);
          }
        },
      ),
    );
  }
}
