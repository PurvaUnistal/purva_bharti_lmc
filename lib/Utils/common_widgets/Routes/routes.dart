import 'package:flutter/material.dart';
import 'package:new_lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:new_lmc/features/Feasibility/LMC%20Feasibility/presentation/lmc_feasibility_view.dart';
import 'package:new_lmc/features/Home/presentation/home_view.dart';
import 'package:new_lmc/features/Login/presentation/login_view.dart';
import 'package:new_lmc/features/Splash/presentation/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());
      case RoutesName.lmcFeasibility:
        return MaterialPageRoute(
            builder: (BuildContext context) => const FeasibilityView());
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
