import 'package:shared_preferences/shared_preferences.dart';

class FavoritesApi {
  Future<List<String>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  Future<List<String>> toggleToFavorites(String nursingHomeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    if (favorites.contains(nursingHomeId)) {
      favorites.remove(nursingHomeId);
    } else {
      favorites.add(nursingHomeId);
    }
    await prefs.setStringList('favorites', favorites);
    return favorites;
  }
}
