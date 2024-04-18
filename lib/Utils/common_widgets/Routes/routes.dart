import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/features/Home/presentation/home_view.dart';
import 'package:lmc/features/LMC%20Feasibility/presentation/lmc_feasibility_view.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/presentation/meter_installation_view.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/presentation/rfc_section_view.dart';
import 'package:lmc/features/LMC%20Installation/presentation/installation_view.dart';
import 'package:lmc/features/Login/presentation/login_view.dart';
import 'package:lmc/features/Splash/presentation/splash_view.dart';

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
      case RoutesName.lmcInstallation:
        return MaterialPageRoute(
            builder: (BuildContext context) => const InstallationView());
      case RoutesName.meterInstallation:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MeterInstallationView());
      case RoutesName.rfcSection:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RFCSectionView());
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
