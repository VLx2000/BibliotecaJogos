import 'package:biblioteca_jogos/models/game.dart';
import 'package:flutter/material.dart';

class Cover extends StatelessWidget {
  final Game jogo;
  const Cover({super.key, required this.jogo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/game', arguments: jogo);
      },
      child: (jogo.cover != null)
          ? Hero(
              tag: 'jogo${jogo.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/loading.gif',
                  placeholderFit: BoxFit.scaleDown,
                  image:
                      'https:${jogo.cover["url"].replaceAll("t_thumb", "t_cover_big")}',
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) => Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(14),
                      ),
                      color: Colors.white70,
                    ),
                    child: Center(
                      child: Text(
                        jogo.name,
                        textScaleFactor: 1.7,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
                color: Colors.white70,
              ),
              child: Center(
                child: Text(
                  jogo.name,
                  textScaleFactor: 1.7,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
