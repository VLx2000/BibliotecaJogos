import 'dart:async';
import 'package:biblioteca_jogos/components/cover.dart';
import 'package:biblioteca_jogos/models/jogo.dart';
import 'package:biblioteca_jogos/services/request_api.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Jogo>>? futureJogos;
  late List<Jogo> listaJogos;
  APIRequest req = APIRequest();

  @override
  void initState() {
    super.initState();
    listaJogos = [];
    futureJogos = req.fetchJogos();
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
        return const CircularProgressIndicator();
      },
    );
  }
}
