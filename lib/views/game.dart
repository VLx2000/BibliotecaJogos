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
  late Future<Jogo> futureGame;
  late Jogo jogo;
  APIRequest req = APIRequest();

  @override
  void initState() {
    super.initState();
    futureGame = req.searchGameById(widget.id);
    jogo = Jogo(id: 1, name: '-');
    saved = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<Jogo>(
          future: futureGame,
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
                      'https:${snapshot.data!.cover["url"].replaceAll("t_thumb", "t_cover_big")}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Adicionar a Lista de Desejos"),
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: Text("Adicionar a Coleção"))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: snapshot.data!.genres!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Center(
                                child:
                                    Text("- ${snapshot.data!.genres![index]}")),
                          );
                        },
                      ),
                    ],
                  ),
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
