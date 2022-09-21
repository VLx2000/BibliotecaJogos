import 'package:biblioteca_jogos/models/game.dart';
import 'package:biblioteca_jogos/views/Home/widgets/games_gridview.dart';
import 'package:biblioteca_jogos/controllers/games_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:biblioteca_jogos/persistence/playlists.dart';
import 'dart:async';

class PlaylistsView extends StatefulWidget {
  const PlaylistsView({super.key});

  @override
  State<PlaylistsView> createState() => _PlaylistsViewState();
}

class _PlaylistsViewState extends State<PlaylistsView>
    with AutomaticKeepAliveClientMixin {
  String playlist = 'colecao';
  late Future<List<Game>> futureJogos;
  final GamesController _controller = GamesController();
  bool _loaded = false;

  Future<List<Game>> LoadGames(String playlist) async {
    var game_ids = await Playlists().checkPlaylists(playlist);
    return _controller.fetchGamesfromPlaylist(game_ids);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    futureJogos = LoadGames(playlist);
  }

  @override
  Widget build(BuildContext context) {
    final int tam = MediaQuery.of(context).size.width ~/ 150;
    return RefreshIndicator(
      onRefresh: () {
        setState(() {
          _loaded = true;
          futureJogos = LoadGames(playlist);
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
          print(list);
          if (list.isEmpty) {
            return Column(
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
                      futureJogos = LoadGames(playlist);
                    });
                  },
                  icon: const Icon(
                    Icons.refresh,
                    size: 24.0,
                  ),
                  label: Text(AppLocalizations.of(context)!.reload),
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
