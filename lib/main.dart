import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:lmc/features/ChangePassword/presentations/Screen/change_password_screen.dart';
import 'package:lmc/model/image_model.dart';
import 'package:lmc/screens/splash_screen.dart';
import 'package:path_provider/path_provider.dart' as pathProvide;

import 'features/ChangePassword/domain/bloc/change_password_bloc.dart';

String dataBoxName="dataBoxName";


void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Directory directory = await pathProvide.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ImageDataModelAdapter());
  await Hive.openBox<ImageDataModel>(dataBoxName);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    SplashScreen.tag: (context) => SplashScreen(),
    '/_ChangePasswordScreenState': (BuildContext context) => ChangePasswordScreen(),
  };
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ChangePasswordBloc()),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'HPCL LMC',
          routes: routes,
          home: SplashScreen(),
        )
      
    );
  }
}
