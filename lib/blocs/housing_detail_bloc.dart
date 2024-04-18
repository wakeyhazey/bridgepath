import 'package:bridgepath/repositories/housing_details_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HousingDetailBloc extends Bloc<HousingDetailEvents, HousingDetailStates> {
  final HousingDetailsRepository _housingDetailsRepository =
      HousingDetailsRepository();
  List<String> favoritesIds = [];

  HousingDetailBloc() : super(HousingDetailsPageLoading()) {
    on<InitializeHousingDetailData>((event, emit) async {
      favoritesIds = await _housingDetailsRepository.getFavorites();
      emit(HousingDetailsPageLoaded(favoritesID: favoritesIds));
    });

    on<ToggleToWishList>((event, emit) async {
      favoritesIds =
          await _housingDetailsRepository.toggleToFavorites(event.housingID);

      emit(HousingDetailsPageLoaded(favoritesID: favoritesIds));
    });
  }
}

// ---------------------- STATES --------------------------

abstract class HousingDetailStates {}

class HousingDetailsPageLoading extends HousingDetailStates {}

class HousingDetailsPageLoaded extends HousingDetailStates {
  final List<String> favoritesID;

  HousingDetailsPageLoaded({required this.favoritesID});
}

// ---------------------- EVENTS --------------------------

abstract class HousingDetailEvents {}

class InitializeHousingDetailData extends HousingDetailEvents {}

class ToggleToWishList extends HousingDetailEvents {
  final String housingID;

  ToggleToWishList({required this.housingID});
}
