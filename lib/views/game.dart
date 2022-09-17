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
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  Text(snapshot.data!.name),
                  Image.network(
                      'https:${snapshot.data!.cover["url"].replaceAll("t_thumb", "t_cover_big")}'),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {},
                              child: Text("Adicionar a Lista de Desejos"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Title(
                                color: Colors.black,
                                child: Text(
                                  "Gêneros",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.all(8),
                              itemCount: snapshot.data!.genres!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Text(
                                      "- ${snapshot.data!.genres![index]['name']}"),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Title(
                                color: Colors.black,
                                child: Text("Plataformas",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.all(8),
                              itemCount: snapshot.data!.platforms!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Text(
                                      "- ${snapshot.data!.platforms![index]["name"]}"),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Column(
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: () {},
                              child: Text("Adicionar a Coleção")),
                          Padding(
                            padding: const EdgeInsets.all(1),
                            child: Text("${snapshot.data!.rating}"),
                          ),
                        ],
                      )),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, left: 8),
                      child: Title(
                        color: Colors.black,
                        child: Text(
                          "Descrição",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 8, left: 8),
                      child: Text(snapshot.data!.summary))
                ],
              )));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ));
  }
}
