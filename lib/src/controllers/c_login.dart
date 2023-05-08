import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practice_slider_login/src/data/models/user.dart';
import 'package:practice_slider_login/src/data/use_cases/use_cases.dart';
import 'package:practice_slider_login/src/utils/u_local_repository.dart';

class LoginController extends ChangeNotifier {
  User? user;
  String? message;
  String? errorMessage;
  final LoginUseCase loginUseCase;

  LoginController({
    required this.loginUseCase,
  });

  Future<void> login() async {
    formatVariables();
    try {
      Map<String, dynamic> response = await loginUseCase.call(
        params: LoginUseCaseParams('user@example.com', 'password'),
      );
      user = response['data'];
      message = response['message'];
      saveUserLocalRepository(user!);
    } on UseCaseException catch (error) {
      errorMessage = error.message;
    }
    notifyListeners();
  }

  void saveUserLocalRepository(User user) {
    LocalRepository prefs = LocalRepository();
    prefs.setLocalStorageString(
      'user',
      json.encode({"email": user.email, "password": user.password}),
    );
    notifyListeners();
  }

  void formatVariables() {
    user = null;
    message = null;
    errorMessage = null;
    notifyListeners();
  }
}
