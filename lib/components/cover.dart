import 'package:biblioteca_jogos/models/jogo.dart';
import 'package:flutter/material.dart';

class Cover extends StatelessWidget {
  final Jogo jogo;
  const Cover({super.key, required this.jogo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
          '/jogo',
          arguments: jogo.id.toString(),
        );
      },
      child: (jogo.cover != null)
          ? ClipRRect(
              borderRadius: BorderRadius.circular(14), // Image border
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/loading.gif',
                placeholderFit: BoxFit.scaleDown,
                image:
                    'https:${jogo.cover["url"].replaceAll("t_thumb", "t_cover_big")}',
                fit: BoxFit.cover,
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
