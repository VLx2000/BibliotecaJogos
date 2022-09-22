import 'package:biblioteca_jogos/views/Home/widgets/playlist_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaylistsView extends StatelessWidget {
  const PlaylistsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                text: AppLocalizations.of(context)!.collection,
              ),
              Tab(
                text: AppLocalizations.of(context)!.wishlist,
              ),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                PlaylistTab(playlistName: 'colecao'),
                PlaylistTab(playlistName: 'desejos'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
