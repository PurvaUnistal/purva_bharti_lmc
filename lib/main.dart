import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widget/app_color.dart';
import 'package:lmc/Utils/common_widget/app_string.dart';
import 'package:lmc/Utils/routes/routes.dart';
import 'package:lmc/Utils/routes/routes_name.dart';
import 'package:lmc/features/Login/domain/bloc/login_bloc.dart';

void main() async{

  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LoginBloc()),
     //   BlocProvider(create: (BuildContext context) => ChangePasswordBloc()),
      ],
      child: MaterialApp(
        title: AppString.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColor.primer,
          hintColor: AppColor.primer,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primer),
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
      
    );
  }
}
