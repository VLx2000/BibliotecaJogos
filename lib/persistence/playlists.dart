import 'package:shared_preferences/shared_preferences.dart';

class Playlists {
  Playlists();
  Future<List<String>> checkPlaylists(String playlist) async {
    final prefs = await SharedPreferences.getInstance();
    if (playlist == "colecao") {
      return (prefs.getStringList('colecao') ?? []);
    } else {
      return (prefs.getStringList('desejos') ?? []);
    }
  }

  Future<void> savePlaylist(List<String> games, String playlist) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(playlist, games);
  }
}
