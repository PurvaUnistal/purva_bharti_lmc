import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart';

class HiveDataBase {


  Future<void> init() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    Directory filesDir = Directory(tempDir.path)..createSync(recursive: true);
    Hive.init(filesDir.path);




  }
}
