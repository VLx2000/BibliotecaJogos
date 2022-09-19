import 'package:shared_preferences/shared_preferences.dart';

class Playlists {
  Playlists() {
    SharedPreferences.setMockInitialValues({});
  }
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

  // Future<void> saveWishlist() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('wishlist', wishlist);
  // }

  // Future<void> saveLibrary() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('library', library);
  // }
}
