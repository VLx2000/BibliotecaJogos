import 'dart:convert';
import 'dart:async';
import 'package:biblioteca_jogos/models/jogo.dart';
import 'package:biblioteca_jogos/services/repository.dart';

class APIRequest {
  Future<List<Jogo>> fetchJogos() async {
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
}
