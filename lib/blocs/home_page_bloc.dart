import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bridgepath/repositories/home_page_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBloc extends Bloc<HomePageEvents, HomePageStates> {
  final HomePageRepository _repo = HomePageRepository();
  final TextEditingController searchTerm = TextEditingController();

  List<Map<String, dynamic>> filteredNursingHomes = [];
  List<Map<String, dynamic>> listings = [];

  List<String> favoritesIds = [];

  Map<String, dynamic> selectedFilters = {
    'price': [
      TextEditingController(text: '0'),
      TextEditingController(text: '0')
    ],
    "type": [],
    "rating": [
      TextEditingController(text: '0'),
      TextEditingController(text: '0')
    ],
    "medical care level": [],
    "location": TextEditingController(text: '0'),
    "accessibility features": []
  };

  HomePageBloc() : super(HomePageLoading()) {
    on<InitialiazeHomePageData>((event, emit) {
      filteredNursingHomes = listings = _repo.getNursingHomeListings();

      emit(ListingsView(
          favoritehousings: favoritesIds,
          index: 0,
          nursingHomeListings: filteredNursingHomes,
          selectedFilters: selectedFilters));
    });

    on<SearchListings>((event, emit) {
      if (event.searchString.isEmpty) {
        add(ShowListingsView());
      } else {
        emit(ListingsView(
            favoritehousings: favoritesIds,
            index: 0,
            nursingHomeListings: filteredNursingHomes
                .where((housing) =>
                    housing['name']
                        .toLowerCase()
                        .contains(event.searchString) ||
                    housing['medical_care_level']
                        .toLowerCase()
                        .contains(event.searchString) ||
                    housing['accessibility_features']
                        .contains(event.searchString) ||
                    housing['description']
                        .toLowerCase()
                        .contains(event.searchString) ||
                    housing['type'].toLowerCase().contains(event.searchString))
                .toList(),
            selectedFilters: selectedFilters));
      }
    }, transformer: droppable());

    on<ShowListingsView>((event, emit) {
      emit(ListingsView(
          favoritehousings: favoritesIds,
          index: 0,
          nursingHomeListings: filteredNursingHomes,
          selectedFilters: selectedFilters));
    });

    on<ShowFavoritesView>((event, emit) async {
      favoritesIds = await _repo.getFavorites();
      emit(FavoritesView(
          index: 1,
          favoriteHousings: listings
              .where((housing) => favoritesIds.contains(housing['id']))
              .toList()));
    });

    on<ShowResourceView>((event, emit) {
      emit(ResourceView(index: 2));
    });

    on<UpdateFilter>((event, emit) {
      if (event.filterName == 'price') {
      } else if (event.filterName == 'rating') {
      } else if (event.filterName == 'location') {
      } else {
        selectedFilters[event.filterName] = event.filter;
      }
    });

    on<ApplyFilter>((event, emit) {
      filteredNursingHomes = listings.where((listing) {
        bool flag = true;
        if (selectedFilters['medical care level'].isNotEmpty) {
          flag &= selectedFilters['medical care level']
              .contains(listing['medical_care_level']);
        }
        if (selectedFilters['accessibility features'].isNotEmpty) {
          flag &= selectedFilters['accessibility features']
              .contains(listing['accessibility_features']);
        }
        if (selectedFilters['type'].isNotEmpty) {
          flag &= selectedFilters['type'].contains(listing['type']);
        }

        if (double.parse(selectedFilters['price'][0].text) !=
            double.parse(selectedFilters['price'][1].text)) {
          flag &= (double.parse(selectedFilters['price'][0].text) <=
              listing['price']);
          flag &= (double.parse(selectedFilters['price'][1].text) >=
              listing['price']);
        }
        return flag;
      }).toList();
      searchTerm.clear();
      add(ShowListingsView());
    });

    on<ClearFilters>((event, emit) {
      selectedFilters = {
        'price': null,
        "type": [],
        "rating": -1,
        "medical care level": [],
        "location": null,
        "accessibility features": []
      };

      filteredNursingHomes = listings;

      add(ShowListingsView());
    });

    on<ToggleToWishList>((event, emit) async {
      favoritesIds = await _repo.toggleToFavorites(event.housingID);

      if (event.inListing) {
        add(ShowListingsView());
      } else {
        add(ShowFavoritesView());
      }
    });
  }
}

// ------------------ STATES -------------------------

abstract class HomePageStates {}

class HomePageLoading extends HomePageStates {}

class ListingsView extends HomePageStates {
  final int index;
  final List<Map<String, dynamic>> nursingHomeListings;
  final Map<String, dynamic> selectedFilters;
  final List<String> favoritehousings;

  ListingsView(
      {required this.index,
      required this.nursingHomeListings,
      required this.selectedFilters,
      required this.favoritehousings});
}

class FavoritesView extends HomePageStates {
  final int index;
  final List<Map<String, dynamic>> favoriteHousings;
  FavoritesView({required this.index, required this.favoriteHousings});
}

class ResourceView extends HomePageStates {
  final int index;

  ResourceView({required this.index});
}

// ------------------ EVENTS -------------------------

abstract class HomePageEvents {}

class InitialiazeHomePageData extends HomePageEvents {}

class SearchListings extends HomePageEvents {
  final String searchString;

  SearchListings({required this.searchString});
}

class ShowListingsView extends HomePageEvents {}

class ShowFavoritesView extends HomePageEvents {}

class ShowResourceView extends HomePageEvents {}

class UpdateFilter extends HomePageEvents {
  final String filterName;
  final dynamic filter;

  UpdateFilter({required this.filterName, required this.filter});
}

class ApplyFilter extends HomePageEvents {}

class ClearFilters extends HomePageEvents {}

class ToggleToWishList extends HomePageEvents {
  final String housingID;
  final bool inListing;

  ToggleToWishList({required this.housingID, required this.inListing});
}
