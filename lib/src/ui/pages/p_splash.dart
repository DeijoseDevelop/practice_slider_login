// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:practice_slider_login/src/ui/pages/pages.dart';
import 'package:practice_slider_login/src/ui/routes/app_routes.dart';
import 'package:practice_slider_login/src/utils/u_local_repository.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> rotate;
  late Animation<double> scale;
  late AnimationController animationController;

  void _animationPage() async {
    LocalRepository localRepository = LocalRepository();
    String? userString = await localRepository.getLocalStorageString('user');
    bool? isFirstInitApp = await localRepository.getLocalStorageBool('init');
    if (userString == null && isFirstInitApp == null) {
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              const SliderPage(),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const Offset begin = Offset(0.0, 1.0);
            const Offset end = Offset.zero;
            const Curve curve = Curves.easeIn;

            Animatable<Offset> tween = Tween(
              begin: begin,
              end: end,
            ).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
        (Route<dynamic> route) => false,
      );
    }
    if (userString != null && isFirstInitApp != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.home,
        (Route<dynamic> route) => false,
      );
    }
    if (userString == null && isFirstInitApp != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.login,
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    animationController.addListener(() {
      setState(() {});
    });
    scale = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceIn,
      ),
    );
    rotate = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    Future.delayed(
      const Duration(seconds: 4),
      _animationPage,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: RotationTransition(
          turns: rotate,
          child: Transform.scale(
            scale: scale.value,
            child: const Text(
              'Hello World',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
