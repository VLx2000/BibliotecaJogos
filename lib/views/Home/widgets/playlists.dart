import 'package:biblioteca_jogos/models/game.dart';
import 'package:biblioteca_jogos/views/Home/widgets/games_gridview.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca_jogos/persistence/playlists.dart';
import 'dart:async';

class PlaylistsView extends StatefulWidget {
  const PlaylistsView({super.key});

  @override
  State<PlaylistsView> createState() => _PlaylistsViewState();
}

class _PlaylistsViewState extends State<PlaylistsView> {
  String playlist = 'colecao';
  late List<String> jogosid;
  //APIRequest req = APIRequest();
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("Tela de Playlists")),
    );
  }
}
