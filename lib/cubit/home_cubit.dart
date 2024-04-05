import 'package:bridgepath/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeLoading());

  void initializeHomeData() async {}

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.listings:
        emit(NavigationState(NavbarItem.listings, 0));
        break;
      case NavbarItem.favorites:
        emit(NavigationState(NavbarItem.favorites, 1));
        break;
      case NavbarItem.resource:
        emit(NavigationState(NavbarItem.resource, 2));
        break;
    }
  }
}

// -------------- STATES -----------------------

abstract class HomeStates {}

class NavigationState extends HomeStates {
  final NavbarItem navbarItem;
  final int index;

  NavigationState(this.navbarItem, this.index);
}

class HomeLoading extends HomeStates {}
