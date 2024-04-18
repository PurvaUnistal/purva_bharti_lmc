import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';
import 'package:lmc/features/InternetConnection/domain/bloc/network_bloc.dart';
import 'package:lmc/features/LMC%20Feasibility/domain/bloc/lmc_feasibility_bloc.dart';
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
          BlocProvider(create: (BuildContext context) => LMCFeasibilityBloc()),
          // BlocProvider(create: (BuildContext context) => HomeBloc()),
          //  BlocProvider(create: (BuildContext context) => NGCFormBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor:AppColor.primer,
            hintColor: AppColor.primer,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor:AppColor.primer,),
          ),
          initialRoute: RoutesName.splash,
          onGenerateRoute: Routes.generateRoute,
        )
    );
  }
}






