import 'package:biblioteca_jogos/views/Home/widgets/explore.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca_jogos/views/Home/widgets/recommendations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:biblioteca_jogos/views/Home/widgets/playlists.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const RecommendationsView(),
    const ExploreView(),
    const PlaylistsView(),
  ];

  PageController? _pageController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController!.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
        title: Text('${AppLocalizations.of(context)!.appTitle} 🎮'),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
        unselectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore),
            label: AppLocalizations.of(context)!.explore,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.collections),
            label: AppLocalizations.of(context)!.playlist,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}
