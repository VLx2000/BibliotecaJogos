import 'package:biblioteca_jogos/models/game.dart';
import 'package:biblioteca_jogos/controllers/games_controller.dart';
import 'package:biblioteca_jogos/views/Home/widgets/games_gridview.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

Future<List<Game>> setList() async {
  return [];
}

class _ExploreViewState extends State<ExploreView> {
  late Future<List<Game>>? futureJogos;
  GamesController controller = GamesController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    futureJogos = setList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(21),
          child: TextField(
            keyboardType: TextInputType.text,
            style: const TextStyle(
              color: Colors.white,
              decorationColor: Colors.white,
            ),
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 24, 24, 24),
              hintText: AppLocalizations.of(context)!.searchPlaceholder,
              hintStyle: const TextStyle(color: Colors.white38),
            ),
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                setState(() {
                  futureJogos = controller.searchGamesByText(value);
                });
              });
            },
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Game>>(
            future: futureJogos,
            builder: (context, snapshot) {
              final int tam = MediaQuery.of(context).size.width ~/ 150;

              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
              }
              List<Game> list = snapshot.data ?? [];
              return GamesGridView(
                  tam: tam, list: list, heroTag: 'exploreGame');
            },
          ),
        ),
      ],
    );
  }
}
