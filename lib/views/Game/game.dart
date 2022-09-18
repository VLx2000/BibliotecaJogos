import 'package:biblioteca_jogos/models/jogo.dart';
import 'package:biblioteca_jogos/views/Game/widgets/playlist_button.dart';
import 'package:biblioteca_jogos/views/Game/widgets/rating_column.dart';
import 'package:biblioteca_jogos/views/Game/widgets/summary_line.dart';
import 'package:biblioteca_jogos/views/Game/widgets/genre_column.dart';
import 'package:biblioteca_jogos/views/Game/widgets/platforms_line.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late int saved;
  double distanceItems = 18;

  @override
  void initState() {
    super.initState();
    saved = 0;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Jogo;

    return Scaffold(
        body: SingleChildScrollView(
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
                    args.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    args.releaseDates?[0]['human'].toString() ?? 'TBT',
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
          (args.cover != null)
              ? Hero(
                  tag: 'jogo${args.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/loading.gif',
                      placeholderFit: BoxFit.scaleDown,
                      image:
                          'https:${args.cover["url"].replaceAll("t_thumb", "t_cover_big")}',
                      fit: BoxFit.cover,
                    ),
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
                    genres: args.genres,
                  ),
                  RatingColumn(
                    rating: args.rating,
                  ),
                ]),
          ),
          // Linha de plataformas
          Padding(
            padding: EdgeInsets.only(bottom: distanceItems),
            child: PlatformsLine(
              platforms: args.platforms,
            ),
          ),
          // Linha de descrição
          Padding(
            padding: EdgeInsets.only(bottom: distanceItems),
            child: SummaryLine(
              summary: args.summary,
            ),
          ),
        ],
      ),
    ));
  }
}
// Hero(
//             tag: 'jogo${args.id.toString()}',
//             child: )