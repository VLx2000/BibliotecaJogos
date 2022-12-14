import 'package:biblioteca_jogos/views/Home/widgets/cover.dart';
import 'package:biblioteca_jogos/models/game.dart';
import 'package:flutter/material.dart';

class GamesGridView extends StatefulWidget {
  final int? tam;
  final AsyncSnapshot? snapshot;
  final List<Game>? list;
  final String heroTag;
  const GamesGridView(
      {super.key, this.tam, this.snapshot, this.list, required this.heroTag});

  @override
  State<GamesGridView> createState() => _GamesGridViewState();
}

class _GamesGridViewState extends State<GamesGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.tam! < 1 ? 1 : widget.tam!,
        childAspectRatio: 0.75,
      ),
      padding: const EdgeInsets.all(14),
      itemCount: widget.list?.length,
      itemBuilder: (context, i) {
        widget.list![i].setHeroTag = widget.heroTag;
        return Container(
          margin: const EdgeInsets.all(7),
          child: Cover(
            jogo: widget.list![i],
            heroTag: widget.heroTag,
          ),
        );
      },
    );
  }
}
