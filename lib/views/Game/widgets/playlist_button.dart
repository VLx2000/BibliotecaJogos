import 'package:flutter/material.dart';
import 'package:biblioteca_jogos/persistence/playlists.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaylistButton extends StatefulWidget {
  final String playlist;
  final String gameid;
  const PlaylistButton(
      {super.key, required this.playlist, required this.gameid});

  @override
  State<PlaylistButton> createState() => _PlaylistButtonState();
}

class _PlaylistButtonState extends State<PlaylistButton> {
  List<String> _currentPlaylist = [];

  @override
  void initState() {
    super.initState();
    getPlaylist(widget.playlist);
  }

  void getPlaylist(String playlist) async {
    var gamesList = await Playlists().checkPlaylists(playlist);
    setState(() {
      _currentPlaylist = gamesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_currentPlaylist.contains(widget.gameid)) {
          setState(() {
            _currentPlaylist.remove(widget.gameid);
          });
        } else {
          setState(() {
            _currentPlaylist.add(widget.gameid);
          });
        }
        Playlists().savePlaylist(_currentPlaylist, widget.playlist);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: (_currentPlaylist.contains(widget.gameid)
            ? Colors.grey
            : Colors.red),
      ),
      child: Text(
        widget.playlist,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
