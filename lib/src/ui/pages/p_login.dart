// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:practice_slider_login/src/controllers/controllers.dart';
import 'package:practice_slider_login/src/ui/routes/app_routes.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: Stack(
            children: const <Widget>[
              _BackgroundImage(),
              _BackgroundColor(),
              _LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    LoginController loginController = context.watch<LoginController>();
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email",
                ),
              ),
              const SizedBox(height: 20.0),
              const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  labelText: "Password",
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  await loginController.login();
                  if (loginController.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          loginController.errorMessage!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                  if (loginController.message != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: RichText(
                          text: TextSpan(
                            text: "${loginController.message!}: ",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: loginController.user!.email,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                    if (loginController.errorMessage == null) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.home,
                        (Route<dynamic> route) => false,
                      );
                    }
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: width * 0.35,
                  ),
                  child: const Text("Submit"),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1617634667039-8e4cb277ab46?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bmF0dXJhbGV6YSUyMHBhaXNhamV8ZW58MHx8MHx8&w=1000&q=80'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _BackgroundColor extends StatelessWidget {
  const _BackgroundColor();

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.black.withOpacity(0.4));
  }
}
