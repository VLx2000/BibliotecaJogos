import 'package:biblioteca_jogos/controllers/games_controller.dart';
import 'package:biblioteca_jogos/models/game.dart';
import 'package:biblioteca_jogos/persistence/playlists.dart';
import 'package:biblioteca_jogos/views/Home/widgets/games_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaylistTab extends StatefulWidget {
  final String playlistName;

  const PlaylistTab({super.key, required this.playlistName});

  @override
  State<PlaylistTab> createState() => _PlaylistTabState();
}

class _PlaylistTabState extends State<PlaylistTab>
    with AutomaticKeepAliveClientMixin {
  late Future<List<Game>> futureJogos;
  final GamesController _controller = GamesController();
  final bool _loaded = false;

  Future<List<Game>> loadGames(String playlist) async {
    List<String> gameIds = await Playlists().checkPlaylists(playlist);
    return _controller.fetchGamesfromPlaylist(gameIds);
  }

  @override
  void initState() {
    futureJogos = loadGames(widget.playlistName);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final int tam = MediaQuery.of(context).size.width ~/ 150;

    return RefreshIndicator(
      onRefresh: () {
        setState(() {
          futureJogos = loadGames(widget.playlistName);
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

          var connectionTest = snapshot.data ?? -1;
          List<Game> list = snapshot.data ?? [];
          if (connectionTest == -1) {
            return _buildNoConnectionScreen();
          } else if (list.isEmpty) {
            return _buildEmptyPlaylistScreen();
          } else {
            return GamesGridView(tam: tam, list: list, heroTag: 'playlistGame');
          }
        },
      ),
    );
  }

  Widget _buildNoConnectionScreen() {
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
              futureJogos = loadGames(widget.playlistName);
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
  }

  Widget _buildEmptyPlaylistScreen() {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.emtpydb,
        style: const TextStyle(
          color: Colors.white,
          decorationColor: Colors.white,
        ),
      ),
    );
  }
}
