import 'package:practice_slider_login/src/controllers/controllers.dart';
import 'package:practice_slider_login/src/data/repositories/repositories.dart';
import 'package:practice_slider_login/src/data/use_cases/use_cases.dart';
import 'package:practice_slider_login/src/settings/settings_controller.dart';
import 'package:practice_slider_login/src/settings/settings_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Injector {
  static List<SingleChildWidget> dependencies = [
    ChangeNotifierProvider(
        create: (_) => SettingsController(SettingsService())),
    ChangeNotifierProvider(create: (_) => SplashController()),
    ChangeNotifierProvider(create: (_)=> SliderController()),
    ChangeNotifierProvider(
      create: (_) => LoginController(
        loginUseCase: LoginUseCase(
          repository: ApiRepository(),
        ),
      ),
    ),
    ChangeNotifierProvider(create: (_)=> HomeController()),
  ];
}
