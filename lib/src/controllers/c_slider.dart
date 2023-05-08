import 'package:flutter/material.dart';
import 'package:practice_slider_login/src/utils/u_local_repository.dart';

class SliderController extends ChangeNotifier {
  PageController? pageController;
  int page = 0;
  List<String> images = [
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
    'https://thumbs.dreamstime.com/b/paisajes-de-yosemite-46208063.jpg',
    'https://res.cloudinary.com/worldpackers/image/upload/c_fill,f_auto,q_auto,w_1024/v1/guides/article_cover/gfuvmfczfyosqs1k4ema'
  ];

  void changePage(int index) {
    page = index;
    notifyListeners();
  }

  void initPageController() {
    pageController = PageController();
    notifyListeners();
  }

  void disposePageController() {
    pageController!.dispose();
    notifyListeners();
  }

  void saveFirstInitApp() async {
    LocalRepository prefs = LocalRepository();
    prefs.setLocalStorageBool('init', true);
    notifyListeners();
  }
}
