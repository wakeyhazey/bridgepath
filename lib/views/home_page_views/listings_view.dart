import 'package:bridgepath/blocs/access_bloc.dart';
import 'package:bridgepath/ui/filter_drawer.dart';
import 'package:bridgepath/ui/home_bottom_navigation_bar.dart';
import 'package:bridgepath/ui/housing_detail_card.dart';
import 'package:bridgepath/ui/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HousingListingsView extends StatelessWidget {
  final int index;
  final List<Map<String, dynamic>> listings;
  final Map<String, dynamic> selectedFilters;
  final List<String> favoriteHousings;
  const HousingListingsView(
      {super.key,
      required this.index,
      required this.listings,
      required this.selectedFilters,
      required this.favoriteHousings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nursing Homes'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AccessBloc>().add(LogOut(context: context));
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ))
        ],
      ),
      drawer: FilterDrawer(
        selectedFilters: selectedFilters,
      ),
      body: Column(
        children: [
          SearchAppBar(),
          Expanded(
            child: ListView(
              children: listings
                  .map(
                    (nusringHome) => HousingDetailCard(
                      inListing: true,
                      housingDetail: nusringHome,
                      favoritesID: favoriteHousings,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: HomeNavigationBar(
        index: index,
      ),
    );
  }
}
