import 'package:biblioteca_jogos/models/jogo.dart';
import 'package:biblioteca_jogos/views/Game/widgets/playlist_button.dart';
import 'package:biblioteca_jogos/views/Game/widgets/rating_column.dart';
import 'package:biblioteca_jogos/views/Game/widgets/summary_line.dart';
import 'package:biblioteca_jogos/views/Game/widgets/genre_column.dart';
import 'package:biblioteca_jogos/views/Game/widgets/platforms_line.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca_jogos/persistence/playlists.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});
  final double distanceItems = 18;

//   @override
//   void initState() {
//     super.initState();
//   }

  // void getPlaylists(String playlist) async {
  //   if (playlist == "desejos") {
  //     var wishlist = await Playlists().checkWishlist();
  //     setState(() {
  //       _wishlist = wishlist;
  //     });
  //   } else if (playlist == "colecao") {
  //     var collection = await Playlists().checkCollection();
  //     setState(() {
  //       _collection = collection;
  //     });
  //   }
  // }

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
          _buildTitleSection(args),
          (args.cover != null) ? _buildGameCard(args) : const Text('no image'),
          _buildButtonBar(args),
          _buildGameDataSection(args)
        ],
      ),
    ));
  }

  Widget _buildTitleSection(Jogo args) {
    return Container(
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
    );
  }

  Widget _buildGameCard(Jogo args) {
    return Hero(
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
    );
  }

  Widget _buildButtonBar(Jogo args) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      buttonPadding: const EdgeInsets.all(12),
      children: [
        PlaylistButton(
          playlist: 'colecao',
          gameid: args.id.toString(),
        ),
        PlaylistButton(
          playlist: 'desejos',
          gameid: args.id.toString(),
        ),
        //PlaylistButton(playlist: 'colecao'),
        //PlaylistButton(playlist: 'playlist3'),
      ],
    );
  }

  Widget _buildGameDataSection(Jogo args) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: distanceItems),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
    );
  }
}
