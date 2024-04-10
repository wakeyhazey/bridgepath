import 'package:bridgepath/api/favorites_api.dart';

class HousingDetailsRepository {
  final FavoritesApi _favoritesApi = FavoritesApi();

  Future<List<String>> getFavorites() async {
    return _favoritesApi.getFavorites();
  }

  Future<List<String>> toggleToFavorites(String nursingHomeId) async {
    return await _favoritesApi.toggleToFavorites(nursingHomeId);
  }
}
