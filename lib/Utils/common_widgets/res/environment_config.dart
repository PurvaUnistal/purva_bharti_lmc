import 'package:flutter/cupertino.dart';
import 'enums.dart';

class EnvironmentConfig extends InheritedWidget {
  final EnvironmentFlavors flavors;

  const EnvironmentConfig({required super.child, required this.flavors});

  static EnvironmentConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    throw UnimplementedError();
  }

  String get generalUrlBaseFlavour {
    print("flavor-->${flavors}");
    switch (flavors) {
      case EnvironmentFlavors.pbgplLMC:
        return "https://pbgplc.smartgasnet.com/api/";
     //   return "https://pbgpluat.smartgasnet.com/api/";
      case EnvironmentFlavors.mglLMC:
        return "https://mgluat.smartgasnet.com/api/";
    }
  }
}
