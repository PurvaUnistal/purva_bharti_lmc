import 'package:flutter/material.dart';
import 'package:lmc/Utils/routes/routes_name.dart';
import 'package:lmc/features/Login/presentation/login_view.dart';
import 'package:lmc/features/Splash/presentation/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginView());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}


