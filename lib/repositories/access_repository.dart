import 'package:bridgepath/api/auth_api.dart';
// import 'package:bridgepath/api/db_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccessRepository {
  final AuthApi _authApi = AuthApi();
  // final DbApi _dbApi = DbApi();
  // final LocationApi _locationApi = LocationApi();
  // final UserManager _userManager = getIt<UserManager>();

  Future<bool> getUser() async {
    User? user = _authApi.getUser();

    if (user != null) {
      // TO DO: get user do for further infomration but not necessary right now
      // DocumentSnapshot<Map<String, dynamic>>? userDoc =
      //     await _dbApi.getUserDoc(user.uid);

      // if (userDoc != null) {
      return true;
      // }

      // await logOut();

      // return false;
    } else {
      return false;
    }
  }

  Future<bool> logIn(Map<String, TextEditingController> credentials) async {
    User? user = await _authApi.logIn(credentials);
    if (user != null) {
      // DocumentSnapshot<Map<String, dynamic>>? userDoc =
      //     await _dbApi.getUserDoc(user.uid);

      // if (userDoc != null) {
      //   _userManager.toModel(userDoc);

      return true;
      // }

      // await logOut();

      // return false;
    } else {
      return false;
    }
  }

  Future<bool> register(Map<String, TextEditingController> credentials) async {
    User? user = await _authApi.register(credentials);

    if (user != null) {
      // _userManager.docID = user.uid;
      // _userManager.email = user.email;
      // bool result =
      //     await _dbApi.addUserDatabase(_userManager.toMap(), user.uid);
      // if (result) {
      return true;
      // } else {
      //   await logOut();

      //   // TO DO maybe this logic is not correct, cause user will
      //   // still be registered
      //   return false;
      // }
    } else {
      debugPrint('register did not succeed');
      return false;
    }
  }

  logOut(BuildContext context) async {
    await _authApi.logOut(context);
  }
}
