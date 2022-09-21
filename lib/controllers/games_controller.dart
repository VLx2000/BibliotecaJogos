import 'dart:convert';
import 'dart:async';
import 'package:biblioteca_jogos/models/game.dart';
import 'package:biblioteca_jogos/services/repository.dart';

class GamesController {
  final Repository repo = Repository();

  Future<List<Game>> fetchRecommendations() async {
    final auth = await repo.auth();
    final responseBody = jsonDecode(auth.body);
    final recommendations = await repo.recommendations(responseBody);

    if (auth.statusCode == 200) {
      return List<Game>.from(
          json.decode(recommendations.body).map((jogo) => Game.fromJson(jogo)));
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  Future<List<Game>> searchGamesByText(String busca) async {
    final auth = await repo.auth();
    final responseBody = jsonDecode(auth.body);
    final recommendations = await repo.searchByText(responseBody, busca);

    if (auth.statusCode == 200) {
      return List<Game>.from(
          json.decode(recommendations.body).map((jogo) => Game.fromJson(jogo)));
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  Future<List<Game>> fetchGamesfromPlaylist(List<String> ids) async {
    if (ids.length == 0) {
      return [];
    }
    final auth = await repo.auth();
    final responseBody = jsonDecode(auth.body);
    final games = await repo.searchGamesByid(responseBody, ids);
    if (auth.statusCode == 200) {
      return List<Game>.from(
          json.decode(games.body).map((jogo) => Game.fromJson(jogo)));
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
