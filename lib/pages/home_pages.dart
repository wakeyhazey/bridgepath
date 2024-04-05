import 'package:bridgepath/blocs/home_page_bloc.dart';
import 'package:bridgepath/views/home_page_views/favorites_view.dart';
import 'package:bridgepath/views/home_page_views/listings_view.dart';
import 'package:bridgepath/views/home_page_views/resource_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageStates>(builder: (context, state) {
      if (state is ListingsView) {
        return HousingListingsView(
          selectedFilters: state.selectedFilters,
          listings: state.nursingHomeListings,
          index: state.index,
        );
      } else if (state is FavoritesView) {
        return FavoriteListingsView(
          index: state.index,
        );
      } else if (state is ResourceView) {
        return ResourceCenterView(
          index: state.index,
        );
      }
      return Container();
    });
  }
}
