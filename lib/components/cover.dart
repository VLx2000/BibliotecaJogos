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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (jogo.cover != null)
              ? FadeInImage.assetNetwork(
                  placeholder: 'assets/loading.gif',
                  image:
                      'https:${jogo.cover["url"].replaceAll("t_thumb", "t_cover_big")}',
                  height: 200.0,
                )
              : Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 206, 206, 206),
                  ),
                  width: 150,
                  height: 200,
                  child: Center(
                    child: Text(
                      jogo.name,
                      textScaleFactor: 1.7,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
