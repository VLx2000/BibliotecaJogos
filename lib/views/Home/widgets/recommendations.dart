import 'dart:async';
import 'package:biblioteca_jogos/models/game.dart';
import 'package:biblioteca_jogos/controllers/games_controller.dart';
import 'package:biblioteca_jogos/views/Home/widgets/games_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecommendationsView extends StatefulWidget {
  const RecommendationsView({super.key});

  @override
  State<RecommendationsView> createState() => _RecommendationsViewState();
}

class _RecommendationsViewState extends State<RecommendationsView>
    with AutomaticKeepAliveClientMixin {
  late Future<List<Game>> futureJogos;
  final GamesController _controller = GamesController();
  bool _loaded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    futureJogos = _controller.fetchRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final int tam = MediaQuery.of(context).size.width ~/ 150;
    return RefreshIndicator(
      onRefresh: () {
        setState(() {
          _loaded = true;
          futureJogos = _controller.fetchRecommendations();
        });
        return futureJogos;
      },
      child: FutureBuilder<List<Game>>(
        future: futureJogos,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return _loaded
                  ? Container()
                  : const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
          }
          List<Game> list = snapshot.data ?? [];
          if (list.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.wifiMsg,
                    style: const TextStyle(
                      color: Colors.white,
                      decorationColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        futureJogos = _controller.fetchRecommendations();
                      });
                    },
                    icon: const Icon(
                      Icons.refresh,
                      size: 24.0,
                    ),
                    label: Text(AppLocalizations.of(context)!.reload),
                  ),
                ],
              ),
            );
          } else {
            return GamesGridView(
              tam: tam,
              list: list,
              heroTag: 'recommendationGame',
            );
          }
        },
      ),
    );
  }
}
