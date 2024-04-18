import 'package:bridgepath/ui/home_bottom_navigation_bar.dart';
import 'package:bridgepath/ui/housing_detail_card.dart';
import 'package:bridgepath/ui/web/listing_locations_map.dart';
import 'package:bridgepath/ui/web/web_listings_bar.dart';
import 'package:flutter/material.dart';

class WebListingsViewWidget extends StatelessWidget {
  final int index;
  final List<Map<String, dynamic>> listings;
  final Map<String, dynamic> selectedFilters;
  final List<String> favoriteHousings;
  const WebListingsViewWidget(
      {super.key,
      required this.selectedFilters,
      required this.index,
      required this.listings,
      required this.favoriteHousings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nursing Homes'),
        automaticallyImplyLeading: false,
      ),
      body: Column(children: [
        SizedBox(
            height: 100,
            child: WebTopBarListsingWidget(selectedFilters: selectedFilters)),
        if (listings.isEmpty)
          const Center(
            child: Text('No housings with these filters'),
          )
        else
          Expanded(
              flex: 8,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListingsLocationsMap(listings: listings),
                  ),
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
                  )
                ],
              ))
      ]),
      bottomNavigationBar: HomeNavigationBar(
        index: index,
      ),
    );
  }
}
