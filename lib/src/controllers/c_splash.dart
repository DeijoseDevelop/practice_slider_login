import 'package:flutter/material.dart';

class SplashController extends ChangeNotifier {
  Animation<double>? rotate;
  Animation<double>? scale;
  AnimationController? animationController;

  void initAnimation(TickerProvider vsync) {
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: vsync,
    );
    scale = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: Curves.bounceIn,
      ),
    );
    rotate = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: Curves.easeIn,
      ),
    );
    notifyListeners();
  }

  void addAnimationListener(void Function() listener) {
    animationController!.addListener(listener);
    notifyListeners();
  }

  void disposeAnimation() {
    animationController!.dispose();
    notifyListeners();
  }
}
