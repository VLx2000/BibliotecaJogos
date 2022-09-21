import 'dart:convert';
import 'dart:async';
import 'package:biblioteca_jogos/models/jogo.dart';
import 'package:biblioteca_jogos/services/repository.dart';

class APIRequest {
  Future<List<Jogo>> fetchGameRecommendations() async {
    try {
      final Repository repo = Repository();

      final auth = await repo.auth();
      final responseBody = jsonDecode(auth.body);
      final recommendations = await repo.recommendations(responseBody);

      if (auth.statusCode == 200) {
        return List<Jogo>.from(json
            .decode(recommendations.body)
            .map((jogo) => Jogo.fromJson(jogo)));
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<Jogo>> fetchGamesfromPlaylist(List<String> ids) async {
    try {
      final Repository repo = Repository();

      final auth = await repo.auth();
      final responseBody = jsonDecode(auth.body);
      final games = await repo.searchGamesByid(responseBody, ids);
      if (auth.statusCode == 200) {
        return List<Jogo>.from(
            json.decode(games.body).map((jogo) => Jogo.fromJson(jogo)));
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<Jogo>> searchGamesByText(String busca) async {
    try {
      final Repository repo = Repository();

      final auth = await repo.auth();
      final responseBody = jsonDecode(auth.body);
      final recommendations = await repo.searchByText(responseBody, busca);

      if (auth.statusCode == 200) {
        return List<Jogo>.from(json
            .decode(recommendations.body)
            .map((jogo) => Jogo.fromJson(jogo)));
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
