import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/Utils/common_widgets/res/enums.dart';
import 'package:lmc/Utils/common_widgets/res/singleton.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/bloc/form_feasibility_bloc.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_bloc.dart';
import 'package:lmc/features/Feasibility/PreviewFeasibility/domain/bloc/preview_feasibility_bloc.dart';
import 'package:lmc/features/Home/domain/bloc/home_bloc.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_bloc.dart';
import 'package:lmc/features/Installation/FormRFCInstallation/domain/bloc/form_rfc_installation_bloc.dart';
import 'package:lmc/features/Installation/LMCInstallation/domain/bloc/lmc_installation_bloc.dart';
import 'package:lmc/features/Installation/PreviewInstallation/domain/bloc/preview_installation_bloc.dart';
import 'package:lmc/features/Login/domain/bloc/login_bloc.dart';
import 'package:lmc/features/NGC/NGCForm/domain/bloc/ngc_form_bloc.dart';
import 'package:lmc/features/NGC/NGCTable/domain/bloc/ngc_table_bloc.dart';

class Root extends StatefulWidget {
  final Client client;
  const Root({required this.client});
  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {

  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Singleton.instanceInit()?.context = context;
    AppConfig.instanceInit()!.setClient(client: widget.client);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColor.primer));
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