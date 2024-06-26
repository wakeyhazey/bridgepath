import 'package:bridgepath/blocs/home_page_bloc.dart';
import 'package:bridgepath/views/home_page_views/favorites_view.dart';
import 'package:bridgepath/views/home_page_views/listings_view.dart';
import 'package:bridgepath/views/home_page_views/resource_view.dart';
import 'package:bridgepath/views/home_page_views/web/web_favorites_view.dart';
import 'package:bridgepath/views/home_page_views/web/web_listings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    return BlocBuilder<HomePageBloc, HomePageStates>(builder: (context, state) {
      if (state is ListingsView) {
        if (widthSize > 600) {
          return WebListingsViewWidget(
            favoriteHousings: state.favoritehousings,
            selectedFilters: state.selectedFilters,
            index: state.index,
            listings: state.nursingHomeListings,
          );
        }
        return HousingListingsView(
          favoriteHousings: state.favoritehousings,
          selectedFilters: state.selectedFilters,
          listings: state.nursingHomeListings,
          index: state.index,
        );
      } else if (state is FavoritesView) {
        if (widthSize > 600) {
          return WebFavoriteListingsView(
              index: state.index, favoriteHousings: state.favoriteHousings);
        }
        return FavoriteListingsView(
            index: state.index, favoriteHousings: state.favoriteHousings);
      } else if (state is ResourceView) {
        return ResourceCenterView(
          index: state.index,
        );
      }
      return Container();
    });
  }
}
