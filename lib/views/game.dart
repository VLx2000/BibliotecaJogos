import 'package:flutter/material.dart';

import '../models/jogo.dart';

class GameView extends StatefulWidget {
  const GameView({super.key, required this.index});
  //late Jogo game;
  final index;
  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late int saved;

  @override
  void initState() {
    super.initState();
    saved = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Teste!'),
      ),
    );
  }
}
