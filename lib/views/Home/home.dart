import 'package:biblioteca_jogos/views/Home/widgets/explore.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca_jogos/views/Home/widgets/recommendations.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    RecommendationsView(),
    ExploreView(),
    Text('tela playlist'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca de Jogos',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color.fromARGB(255, 41, 41, 41),
        inputDecorationTheme:
            const InputDecorationTheme(filled: true, fillColor: Colors.white),
        primaryTextTheme: Typography().white,
        textTheme: Typography().white,
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 24, 24, 24),
          title: const Text('Biblioteca de Jogos 🎮'),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 24, 24, 24),
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explorar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.collections),
              label: 'Playlists',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red,
          onTap: _onItemTapped,
        ),
      ),
      debugShowCheckedModeBanner: false, //Removing Debug Banner
    );
  }
}
