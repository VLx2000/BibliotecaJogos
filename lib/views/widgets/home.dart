import 'dart:async';
import 'package:biblioteca_jogos/components/cover.dart';
import 'package:biblioteca_jogos/models/jogo.dart';
import 'package:biblioteca_jogos/utils/secrets.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:biblioteca_jogos/utils/url_api.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Jogo>>? futureJogos;
  late List<Jogo> listaJogos;

  @override
  void initState() {
    super.initState();
    listaJogos = [];
    futureJogos = fetchJogos();
  }

  List<Jogo> gameFromJson(String str) {
    return List<Jogo>.from(json.decode(str).map((final x) => Jogo.fromJson(x)));
  }

  Future<List<Jogo>> fetchJogos() async {
    final time = (DateTime.now().microsecondsSinceEpoch / 1000000).round();
    //debugPrint(time.toString());
    final authUrl = Uri.https(
      'id.twitch.tv',
      '/oauth2/token',
      {
        'client_id': Secrets.clientID,
        'client_secret': Secrets.clientSecret,
        'grant_type': 'client_credentials',
      },
    );
    //debugPrint(authUrl.toString());
    final auth = await http.post(authUrl);
    final responseBody = jsonDecode(auth.body);
    final searchUrl = Uri.https(API_URL, '/v4/games/');
    //debugPrint(searchUrl.toString());
    final response = await http.post(
      searchUrl,
      headers: {
        "Client-ID": Secrets.clientID,
        "Authorization": "Bearer ${responseBody["access_token"]}",
      },
      body:
          'fields name,cover.url; where follows > 10 & release_dates.date < $time; limit 50; sort first_release_date desc;',
    );

    //debugPrint(response.body);
    if (auth.statusCode == 200) {
      return gameFromJson(response.body);
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final int tam = MediaQuery.of(context).size.width ~/ 150;
    return FutureBuilder<List<Jogo>>(
      future: futureJogos,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Jogo> list = snapshot.data ?? [];
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: tam < 1 ? 1 : tam,
              childAspectRatio: 0.75,
            ),
            padding: const EdgeInsets.all(14),
            itemCount: list.length,
            itemBuilder: (context, i) {
              return Container(
                margin: const EdgeInsets.all(7),
                child: Cover(jogo: snapshot.data![i]),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
