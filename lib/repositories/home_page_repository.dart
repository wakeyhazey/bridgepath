import 'package:bridgepath/api/favorites_api.dart';
import 'package:bridgepath/utils/dummy_data.dart';

class HomePageRepository {
  final FavoritesApi _favoritesApi = FavoritesApi();

  Future<List<String>> getFavorites() async {
    return _favoritesApi.getFavorites();
  }

  List<Map<String, dynamic>> getNursingHomeListings() {
    return dummyNursingHomes;
  }

  Future<List<String>> toggleToFavorites(String nursingHomeId) async {
    return await _favoritesApi.toggleToFavorites(nursingHomeId);
  }
}
