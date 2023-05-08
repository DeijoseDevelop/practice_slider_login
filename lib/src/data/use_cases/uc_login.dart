import 'package:practice_slider_login/src/data/models/models.dart';
import 'package:practice_slider_login/src/data/repositories/repositories.dart';
import 'package:practice_slider_login/src/data/use_cases/use_cases.dart';

class LoginUseCaseParams extends Params {
  final String email;
  final String password;
  LoginUseCaseParams(this.email, this.password);
}

class LoginUseCase extends UseCase<Map<String, dynamic>, LoginUseCaseParams> {
  ApiRepository repository;
  LoginUseCase({required this.repository});

  @override
  Future<Map<String, dynamic>> call({LoginUseCaseParams? params}) async {
    Map<String, dynamic> response = await repository.login(
      params!.email,
      params.password,
    );
    switch (response['status']) {
      case 200:
        User user = User.fromJson(response['data']);
        response['data'] = user;
        return response;
      default:
        throw UseCaseException(response['message']);
    }
  }
}
