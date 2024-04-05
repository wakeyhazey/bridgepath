import 'package:bridgepath/ui/home_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class FavoriteListingsView extends StatelessWidget {
  final int index;
  const FavoriteListingsView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Placeholder(),
      bottomNavigationBar: HomeNavigationBar(index: index),
    );
  }
}
