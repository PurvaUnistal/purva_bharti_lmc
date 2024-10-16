import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:new_lmc/Utils/common_widgets/Routes/routes.dart';
import 'package:new_lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:new_lmc/Utils/common_widgets/res/app_color.dart';
import 'package:new_lmc/features/Feasibility/FormFeasibility/domain/bloc/form_feasibility_bloc.dart';
import 'package:new_lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_bloc.dart';
import 'package:new_lmc/features/Feasibility/PreviewFeasibility/domain/bloc/preview_feasibility_bloc.dart';
import 'package:new_lmc/features/Home/domain/bloc/home_bloc.dart';
import 'package:new_lmc/features/Installation/FormInstallation/domain/bloc/form_installation_bloc.dart';
import 'package:new_lmc/features/Installation/FormRFCInstallation/domain/bloc/form_rfc_installation_bloc.dart';
import 'package:new_lmc/features/Installation/LMCInstallation/domain/bloc/lmc_installation_bloc.dart';
import 'package:new_lmc/features/Installation/PreviewInstallation/domain/bloc/preview_installation_bloc.dart';
import 'package:new_lmc/features/Login/domain/bloc/login_bloc.dart';
import 'package:new_lmc/features/NGC/NGCForm/domain/bloc/ngc_form_bloc.dart';
import 'package:new_lmc/features/NGC/NGCTable/domain/bloc/ngc_table_bloc.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    checkForUpdate();
    super.initState();
  }

  AppUpdateInfo? _updateInfo;
  bool _flexibleUpdateAvailable = false;

  // Method to check for updates
  void checkForUpdate() async {
    try {
      _updateInfo = await InAppUpdate.checkForUpdate();
      if (_updateInfo?.updateAvailability == UpdateAvailability.updateAvailable) {
        print("Current Update Info: ${_updateInfo?.updateAvailability ?? 'No info'}");
        // Start immediate update if available
        InAppUpdate.performImmediateUpdate()
            .catchError((e) => print(e)); // Handle the error as needed
      } else {
        print('No update available');
      }
    } catch (e) {
      print('Failed to check for updates: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: AppColor.primer
        ));
    
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => LoginBloc()),
          BlocProvider(create: (BuildContext context) => HomeBloc()),
          BlocProvider(create: (BuildContext context) => LMCFeasibilityBloc()),
          BlocProvider(create: (BuildContext context) => PreviewFeasibilityBloc()),
          BlocProvider(create: (BuildContext context) => FormFeasibilityBloc()),
          BlocProvider(create: (BuildContext context) => LMCInstallationBloc()),
          BlocProvider(create: (BuildContext context) => PreviewInstallationBloc()),
          BlocProvider(create: (BuildContext context) => FormInstallationBloc()),
          BlocProvider(create: (BuildContext context) => FormRFCInstallationBloc()),
          BlocProvider(create: (BuildContext context) => NgcTableBloc()),
          BlocProvider(create: (BuildContext context) => NGCFormBloc()),
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