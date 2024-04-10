import 'package:bridgepath/ui/home_bottom_navigation_bar.dart';
import 'package:bridgepath/ui/housing_detail_card.dart';
import 'package:flutter/material.dart';

class WebFavoriteListingsView extends StatelessWidget {
  final int index;
  final List<Map<String, dynamic>> favoriteHousings;
  const WebFavoriteListingsView(
      {super.key, required this.index, required this.favoriteHousings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: favoriteHousings.isEmpty
          ? const Center(
              child: Text('Favorites is empty'),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // number of items in each row
                mainAxisSpacing: 8.0, // spacing between rows
                crossAxisSpacing: 8.0, // spacing between columns
              ),
              padding: const EdgeInsets.all(8.0), // padding around the grid
              itemCount: favoriteHousings.length,
              itemBuilder: (context, index) {
                return HousingDetailCard(
                  inListing: false,
                  favoritesID: favoriteHousings,
                  housingDetail: favoriteHousings[index],
                );
              }),
      bottomNavigationBar: HomeNavigationBar(index: index),
    );
  }
}
