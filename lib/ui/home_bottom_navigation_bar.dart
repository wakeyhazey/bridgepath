import 'package:bridgepath/blocs/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNavigationBar extends StatelessWidget {
  final int index;
  const HomeNavigationBar({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list,
          ),
          label: 'listings',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
          ),
          label: 'favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.help_center,
          ),
          label: 'resource',
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          BlocProvider.of<HomePageBloc>(context).add(ShowListingsView());
        } else if (index == 1) {
          BlocProvider.of<HomePageBloc>(context).add(ShowFavoritesView());
        } else if (index == 2) {
          BlocProvider.of<HomePageBloc>(context).add(ShowResourceView());
        }
      },
    );
  }
}
