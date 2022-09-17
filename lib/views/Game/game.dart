import 'package:biblioteca_jogos/views/Game/widgets/playlist_button.dart';
import 'package:biblioteca_jogos/views/Game/widgets/rating_column.dart';
import 'package:biblioteca_jogos/views/Game/widgets/summary_line.dart';
import 'package:biblioteca_jogos/views/Game/widgets/genre_column.dart';
import 'package:biblioteca_jogos/views/Game/widgets/platforms_line.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca_jogos/services/request_api.dart';
import '../../models/jogo.dart';

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
  double distanceItems = 18;

  @override
  void initState() {
    super.initState();
    futureGame = req.searchGameById(widget.id);
    jogo = const Jogo(id: 1, name: '-');
    saved = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca de Jogos',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color.fromARGB(255, 41, 41, 41),
        inputDecorationTheme:
            const InputDecorationTheme(filled: true, fillColor: Colors.white),
        primaryTextTheme: Typography().white,
        textTheme: Typography().white,
      ),
      home: Scaffold(
        body: FutureBuilder<Jogo>(
          future: futureGame,
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Failed to retrieve game"),
              );
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 54,
                ),
                child: Column(
                  children: [
                    // Titulo do jogo e data de lançamento
                    Container(
                      padding: EdgeInsets.only(bottom: distanceItems),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              softWrap: true,
                              snapshot.data!.name,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              snapshot.data!.releaseDates?[0]['human']
                                      .toString() ??
                                  'TBT',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Cover do jogo
                    (snapshot.data!.cover != null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/loading.gif',
                              placeholderFit: BoxFit.scaleDown,
                              image:
                                  'https:${snapshot.data!.cover["url"].replaceAll("t_thumb", "t_cover_big")}',
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Text('no image'),
                    // Botoes para adicionar em playlist
                    const ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      buttonPadding: EdgeInsets.all(12),
                      children: [
                        PlaylistButton(playlist: 'colecao'),
                        PlaylistButton(playlist: 'desejos'),
                        //PlaylistButton(playlist: 'colecao'),
                        //PlaylistButton(playlist: 'playlist3'),
                      ],
                    ),
                    // Linha de generos e nota
                    Padding(
                      padding: EdgeInsets.only(bottom: distanceItems),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GenreColumn(
                              genres: snapshot.data?.genres,
                            ),
                            RatingColumn(
                              rating: snapshot.data?.rating,
                            ),
                          ]),
                    ),
                    // Linha de plataformas
                    Padding(
                      padding: EdgeInsets.only(bottom: distanceItems),
                      child: PlatformsLine(
                        platforms: snapshot.data?.platforms,
                      ),
                    ),
                    // Linha de descrição
                    Padding(
                      padding: EdgeInsets.only(bottom: distanceItems),
                      child: SummaryLine(
                        summary: snapshot.data?.summary,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }
}
