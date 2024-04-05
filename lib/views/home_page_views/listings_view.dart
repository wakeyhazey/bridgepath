import 'package:bridgepath/ui/filter_drawer.dart';
import 'package:bridgepath/ui/home_bottom_navigation_bar.dart';
import 'package:bridgepath/ui/housing_detail_card.dart';
import 'package:bridgepath/ui/search_bar.dart';
import 'package:flutter/material.dart';

class HousingListingsView extends StatelessWidget {
  final int index;
  final List<Map<String, dynamic>> listings;
  final Map<String, dynamic> selectedFilters;
  const HousingListingsView(
      {super.key,
      required this.index,
      required this.listings,
      required this.selectedFilters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nursing Homes'),
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
                      housingDetail: nusringHome,
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
