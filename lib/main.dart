import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/bloc/form_feasibility_bloc.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_bloc.dart';
import 'package:lmc/features/Feasibility/PreviewFeasibility/domain/bloc/preview_feasibility_bloc.dart';
import 'package:lmc/features/Home/domain/bloc/home_bloc.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_bloc.dart';
import 'package:lmc/features/Installation/LMCInstallation/domain/bloc/lmc_installation_bloc.dart';
import 'package:lmc/features/Installation/PreviewInstallation/domain/bloc/preview_installation_bloc.dart';
import 'package:lmc/features/Login/domain/bloc/login_bloc.dart';
import 'package:lmc/features/NGC/NGCForm/domain/bloc/ngc_form_bloc.dart';
import 'package:lmc/features/NGC/NGCTable/domain/bloc/ngc_table_bloc.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        //  home: Ima(),
        ));
  }
}

class Ima extends StatelessWidget {
  const Ima({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Image in a Container'),
      ),
      body:Card(
        child: Container(
          width: MediaQuery.of(context).size.width *0.23,
          height:MediaQuery.of(context).size.height* 0.12,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.primer),
          ),
          child:  Image.network("http://142.79.231.30:8097/uploads/chk902/installation/2024/aug/meter_photo_70451724137589.jpg".toString(), fit: BoxFit.cover,),
        ),
      ),

    );
  }
}
