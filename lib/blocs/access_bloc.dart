import 'package:bridgepath/repositories/access_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccessBloc extends Bloc<AccessEvents, AccessStates> {
  final AccessRepository _accessRepository = AccessRepository();

  AccessBloc() : super(AccessLoading()) {
    on<Authenticate>((event, emit) async {
      bool result = await _accessRepository.getUser();
      if (result) {
        emit(Authenticated());
      } else {
        emit(NotAuthenticated());
      }
    });

    on<ShowNotAuthenticated>((event, emit) {
      emit(NotAuthenticated());
    });

    on<ShowRegister>((event, emit) {
      emit(RegisterView());
    });

    on<Login>((event, emit) async {
      emit(AccessLoading());
      bool result = await _accessRepository.logIn(event.cred);

      if (result) {
        emit(Authenticated());
      } else {
        emit(NotAuthenticated());
      }
    });

    on<Register>((event, emit) async {
      emit(AccessLoading());
      bool result = await _accessRepository.register(event.info);

      if (result) {
        emit(Authenticated());
      } else {
        emit(NotAuthenticated());
      }
    });

    on<LogOut>((event, emit) {
      _accessRepository.logOut(event.context);
    });
  }
}

// -------------- STATES ----------------

abstract class AccessStates {}

class NotAuthenticated extends AccessStates {}

class RegisterView extends AccessStates {}

class Authenticated extends AccessStates {}

class AccessLoading extends AccessStates {}

class AccessError extends AccessStates {
  final String errorMessage;

  AccessError({required this.errorMessage});
}

// -------------- EVENTS ----------------

abstract class AccessEvents {}

class Authenticate extends AccessEvents {}

class ShowNotAuthenticated extends AccessEvents {}

class ShowRegister extends AccessEvents {}

class Login extends AccessEvents {
  final Map<String, TextEditingController> cred;

  Login({required this.cred});
}

class Register extends AccessEvents {
  final Map<String, TextEditingController> info;

  Register({required this.info});
}

class LogOut extends AccessEvents {
  final BuildContext context;

  LogOut({required this.context});
}
