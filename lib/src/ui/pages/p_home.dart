import 'package:flutter/material.dart';
import 'package:practice_slider_login/src/controllers/controllers.dart';
import 'package:practice_slider_login/src/ui/routes/app_routes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      HomeController controller = context.read<HomeController>();
      controller.getUserFromLocalStorage();
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeController controller = context.watch<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              controller.logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.login,
                (Route<dynamic> route) => false,
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: controller.user == null
            ? const CircularProgressIndicator.adaptive()
            : Text('Welcome to the Home ${controller.user!.email}'),
      ),
    );
  }
}
