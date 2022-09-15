import 'dart:convert';
import 'dart:async';
import 'package:biblioteca_jogos/models/jogo.dart';
import 'package:biblioteca_jogos/services/repository.dart';

class APIRequest {
  Future<List<Jogo>> fetchGameRecommendations() async {
    final Repository repo = Repository();

    final auth = await repo.auth();
    final responseBody = jsonDecode(auth.body);
    final recommendations = await repo.recommendations(responseBody);

    if (auth.statusCode == 200) {
      return List<Jogo>.from(
          json.decode(recommendations.body).map((jogo) => Jogo.fromJson(jogo)));
    }
    return [];
  }

  Future<List<Jogo>> searchGamesByText(String busca) async {
    final Repository repo = Repository();

    final auth = await repo.auth();
    final responseBody = jsonDecode(auth.body);
    final recommendations = await repo.searchByText(responseBody, busca);

    if (auth.statusCode == 200) {
      return List<Jogo>.from(
          json.decode(recommendations.body).map((jogo) => Jogo.fromJson(jogo)));
    }
    return [];
  }

  Future<Jogo> searchGameById(String id) async {
    final Repository repo = Repository();

    final auth = await repo.auth();
    final responseBody = jsonDecode(auth.body);
    final game = await repo.searchById(responseBody, id);

    if (auth.statusCode == 200) {
      return Jogo.fromJson(json.decode(game.body)[0]);
    }
    return Jogo(id: -1 as int, name: '-' as String);
  }
}
