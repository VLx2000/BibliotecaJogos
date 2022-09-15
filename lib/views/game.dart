import 'package:flutter/material.dart';
import 'package:biblioteca_jogos/services/request_api.dart';
import '../models/jogo.dart';

class GameView extends StatefulWidget {
  const GameView({super.key, required this.id});
  final String id;
  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late int saved;
  late Future<Jogo> future_game;
  late Jogo jogo;
  APIRequest req = APIRequest();

  @override
  void initState() {
    super.initState();
    future_game = req.searchGameById(widget.id);
    jogo = Jogo(id: 1, name: '-');
    saved = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<Jogo>(
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Failed to retrieve game"),
              );
            } else if (snapshot.hasData) {
              return Center(
                  child: Column(
                children: [
                  Text(snapshot.data!.name),
                  Image.network(
                      'https:${snapshot.data!.cover["url"].replaceAll("t_thumb", "t_cover_big")}')
                ],
              ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ));
  }
}
