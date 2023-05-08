import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practice_slider_login/src/data/models/models.dart';
import 'package:practice_slider_login/src/utils/u_local_repository.dart';

class HomeController extends ChangeNotifier {
  User? user;

  void getUserFromLocalStorage() async {
    LocalRepository prefs = LocalRepository();
    String? userString = await prefs.getLocalStorageString('user');
    user = User.fromJson(json.decode(userString!));
    notifyListeners();
  }

  void logout() async {
    LocalRepository prefs = LocalRepository();
    await prefs.removeLocalStorage('user');
  }
}
