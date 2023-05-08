import 'package:flutter/material.dart';
import 'package:practice_slider_login/src/settings/settings_controller.dart';
import 'package:practice_slider_login/src/settings/settings_service.dart';
import 'package:practice_slider_login/src/settings/settings_view.dart';
import 'package:practice_slider_login/src/ui/pages/pages.dart';
import 'package:practice_slider_login/src/ui/routes/app_routes.dart';

class AppPages {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (_) => SettingsView(
            controller: SettingsController(
              SettingsService(),
            ),
          ),
        );
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.slider:
        return MaterialPageRoute(builder: (_) => const SliderPage());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
