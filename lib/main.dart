import 'package:flutter/material.dart';
import '../ExportFile/export_file.dart';

String dataBoxName="dataBoxName";

void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ImageDataModelAdapter());
  await Hive.openBox<ImageDataModel>(dataBoxName);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    SplashScreen.tag: (context) => SplashScreen(),
  //  '/_ChangePasswordScreenState': (BuildContext context) => ChangePasswordScreen(),
  };
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ChangePasswordBloc()),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'PBG LMC',
          routes: routes,
          home: SplashScreen(),
        )
      
    );
  }
}
