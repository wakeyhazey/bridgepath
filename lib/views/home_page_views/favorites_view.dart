import 'package:bridgepath/ui/home_bottom_navigation_bar.dart';
import 'package:bridgepath/ui/housing_detail_card.dart';
import 'package:flutter/material.dart';

class FavoriteListingsView extends StatelessWidget {
  final int index;
  final List<Map<String, dynamic>> favoriteHousings;
  const FavoriteListingsView(
      {super.key, required this.index, required this.favoriteHousings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: favoriteHousings.isEmpty
          ? const Center(
              child: Text('Favorites is empty'),
            )
          : ListView(
              children: favoriteHousings
                  .map(
                    (nusringHome) => HousingDetailCard(
                      inListing: false,
                      favoritesID: favoriteHousings,
                      housingDetail: nusringHome,
                    ),
                  )
                  .toList(),
            ),
      bottomNavigationBar: HomeNavigationBar(index: index),
    );
  }
}
