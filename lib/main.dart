import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/bloc/form_feasibility_bloc.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_bloc.dart';
import 'package:lmc/features/Feasibility/PreviewFeasibility/domain/bloc/preview_feasibility_bloc.dart';
import 'package:lmc/features/Home/domain/bloc/home_bloc.dart';
import 'package:lmc/features/InternetConnection/domain/bloc/network_bloc.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/bloc/form_meter_bloc.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/MeterInstallation/domain/bloc/meter_installation_bloc.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/PreviewMeterInstallation/domain/bloc/preview_meter_installation_bloc.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/domain/bloc/form_rfc_bloc.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/PreviewRFCSection/domain/bloc/preview_rfc_bloc.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/RFCSection/domain/bloc/rfc_section_bloc.dart';
import 'package:lmc/features/Login/domain/bloc/login_bloc.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => NetworkBloc()),
          BlocProvider(create: (BuildContext context) => LoginBloc()),
          BlocProvider(create: (BuildContext context) => HomeBloc()),
          BlocProvider(create: (BuildContext context) => LMCFeasibilityBloc()),
          BlocProvider(create: (BuildContext context) => PreviewFeasibilityBloc()),
          BlocProvider(create: (BuildContext context) => FormFeasibilityBloc()),
          BlocProvider(create: (BuildContext context) => MeterInstallationBloc()),
          BlocProvider(create: (BuildContext context) => PreviewMeterInstallationBloc()),
          BlocProvider(create: (BuildContext context) => FormMeterBloc()),
          BlocProvider(create: (BuildContext context) => RFCSectionBloc()),
          BlocProvider(create: (BuildContext context) => PreviewRFCBloc()),
          BlocProvider(create: (BuildContext context) => FormRFCBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColor.primer,
            hintColor: AppColor.primer,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColor.primer,
            ),
          ),
          initialRoute: RoutesName.splash,
          onGenerateRoute: Routes.generateRoute,
        ));
  }
}
