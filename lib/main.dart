import 'package:biblioteca_jogos/views/Game/game.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca_jogos/views/Home/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:biblioteca_jogos/views/Home/widgets/playlists.dart';

void main() {
  runApp(
    const BibliotecaDeJogos(),
  );
}

class BibliotecaDeJogos extends StatelessWidget {
  const BibliotecaDeJogos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca de Jogos',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('pt', ''), // Portuguese, no country code
      ],
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color.fromARGB(255, 41, 41, 41),
        inputDecorationTheme:
            const InputDecorationTheme(filled: true, fillColor: Colors.white),
        primaryTextTheme: Typography().white,
        textTheme: Typography().white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeView(),
        '/game': (context) => const GameView(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('404!'),
      ),
    );
  }
}
