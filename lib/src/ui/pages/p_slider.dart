import 'package:flutter/material.dart';
import 'package:practice_slider_login/src/controllers/controllers.dart';
import 'package:practice_slider_login/src/ui/routes/app_routes.dart';
import 'package:provider/provider.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<SliderController>()
          ..initPageController()
          ..saveFirstInitApp();
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (mounted) {
          context.read<SliderController>().disposePageController();
        }
      },
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SliderController sliderController = context.watch<SliderController>();
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
          Size size = Size(width, height);
          return Stack(
            children: <Widget>[
              const _Sliders(),
              _Dots(size: size),
              if (sliderController.page != 0) _PreviousButtonSlider(size: size),
              _NextButtonSlider(size: size)
            ],
          );
        }),
      ),
    );
  }
}

class _PreviousButtonSlider extends StatelessWidget {
  const _PreviousButtonSlider({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    SliderController sliderController = context.watch<SliderController>();
    return Positioned(
      bottom: size.height * 0.01,
      left: size.width * 0.05,
      child: TextButton(
        onPressed: () {
          sliderController.pageController!.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
        child: const Text(
          'Previous',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextButtonSlider extends StatelessWidget {
  const _NextButtonSlider({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    SliderController sliderController = context.watch<SliderController>();
    return Positioned(
      bottom: size.height * 0.01,
      right: size.width * 0.05,
      child: TextButton(
        onPressed: () {
          sliderController.page == 2
              ? Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (Route<dynamic> route) => false,
                )
              : sliderController.pageController!.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
        },
        child: Text(
          sliderController.page == 2 ? 'Skip' : 'Next',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Sliders extends StatelessWidget {
  const _Sliders();

  @override
  Widget build(BuildContext context) {
    SliderController sliderController = context.watch<SliderController>();
    return PageView.builder(
      onPageChanged: sliderController.changePage,
      controller: sliderController.pageController,
      itemCount: sliderController.images.length,
      itemBuilder: (BuildContext context, int index) => _Slider(
        image: sliderController.images[index],
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  const _Slider({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: size.height * 0.05,
      left: size.width * 0.4,
      child: Row(
        children: const <Widget>[
          _Dot(index: 0),
          SizedBox(width: 10.0),
          _Dot(index: 1),
          SizedBox(width: 10.0),
          _Dot(index: 2),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    SliderController sliderController = context.watch<SliderController>();
    return CircleAvatar(
      backgroundColor:
          sliderController.page == index ? Colors.blue : Colors.white,
      radius: 8,
    );
  }
}
