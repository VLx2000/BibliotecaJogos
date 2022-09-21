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

class _PlaylistsViewState extends State<PlaylistsView> {
  String _playlist = 'colecao';
  late Future<List<Game>> futureJogos;
  final GamesController _controller = GamesController();
  int _tapped_button = 0;
  bool _loaded = false;

  Future<List<Game>> LoadGames(String playlist) async {
    List<String> game_ids = await Playlists().checkPlaylists(playlist);
    return _controller.fetchGamesfromPlaylist(game_ids);
  }

  // @override
  // bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    futureJogos = LoadGames(_playlist);
  }

  @override
  Widget build(BuildContext context) {
    final int tam = MediaQuery.of(context).size.width ~/ 150;
    return RefreshIndicator(
      onRefresh: () {
        setState(() {
          _loaded = true;
          futureJogos = LoadGames(_playlist);
        });
        return futureJogos;
      },
      child: Center(
          child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _playlist = 'colecao';
                    futureJogos = LoadGames(_playlist);
                    _tapped_button = 0;
                  });
                },
                child: Text('Coleção'),
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _tapped_button == 0 ? Colors.grey : Colors.red),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _playlist = 'desejos';
                    futureJogos = LoadGames(_playlist);
                    _tapped_button = 1;
                  });
                },
                child: Text("Desejos"),
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _tapped_button == 1 ? Colors.grey : Colors.red),
              ),
            ],
          ),
          Expanded(
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
                            futureJogos = LoadGames(_playlist);
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
          )
        ],
      )),
    );
  }
}
