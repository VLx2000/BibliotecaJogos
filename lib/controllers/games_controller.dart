import 'dart:convert';
import 'dart:async';
import 'package:biblioteca_jogos/models/game.dart';
import 'package:biblioteca_jogos/services/repository.dart';

class GamesController {
  final Repository repo = Repository();

  Future<List<Game>> fetchRecommendations() async {
    try {
      final auth = await repo.auth();
      final responseBody = jsonDecode(auth.body);
      final recommendations = await repo.recommendations(responseBody);

      if (auth.statusCode == 200) {
        return List<Game>.from(json
            .decode(recommendations.body)
            .map((jogo) => Game.fromJson(jogo)));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Game>> searchGamesByText(String busca) async {
    try {
      final auth = await repo.auth();
      final responseBody = jsonDecode(auth.body);
      final recommendations = await repo.searchByText(responseBody, busca);

      if (auth.statusCode == 200) {
        return List<Game>.from(json
            .decode(recommendations.body)
            .map((jogo) => Game.fromJson(jogo)));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Game>> fetchGamesfromPlaylist(List<String> ids) async {
    try {
      if (ids.isEmpty) {
        return [];
      }
      final auth = await repo.auth();
      final responseBody = jsonDecode(auth.body);
      final games = await repo.searchGamesByid(responseBody, ids);
      if (auth.statusCode == 200) {
        return List<Game>.from(
            json.decode(games.body).map((jogo) => Game.fromJson(jogo)));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
