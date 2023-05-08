import 'package:practice_slider_login/src/data/repositories/repositories.dart';

class ApiRepository extends BaseRepository {
  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> user = {
      "email" : email,
      "password" : password,
    };
    return Future.delayed(const Duration(seconds: 2), () {
      if ('user@example.com' == email && 'password' == password) {
        return {"message": 'login successful', "status": 200, "data": user};
      } else {
        return {"message": 'login failed', "status": 400};
      }
    });
  }
}
