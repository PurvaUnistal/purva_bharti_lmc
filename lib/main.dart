import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:lmc/model/image_model.dart';
import 'package:lmc/screens/splash_screen.dart';
import 'package:path_provider/path_provider.dart' as pathProvide;

String dataBoxName="dataBoxName";


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Directory directory = await pathProvide.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ImageDataModelAdapter());
  await Hive.openBox<ImageDataModel>(dataBoxName);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HPCL LMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      home: SplashScreen(),
    );
  }
}