import '../../ExportFile/export_file.dart';

class Injector{

  static final Injector _singleton = new Injector._internal();

  factory Injector(){
    return _singleton;
  }
  Injector._internal();

  DataRepository get dataRepository{
    return new Service();
  }
}