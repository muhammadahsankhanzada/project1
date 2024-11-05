import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project1/Repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final _authRepo = AuthRepository();

  // This method will get data from ui and send to auth_repository
  Future<void> loginApi(dynamic data, BuildContext context) async {
    _authRepo.loginApi(data).then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, StackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
