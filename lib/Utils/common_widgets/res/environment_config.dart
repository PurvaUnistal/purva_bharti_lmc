import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      case EnvironmentFlavors.prodPBGPL:
      //  return "https://pbgplc.smartgasnet.com/api/";
        return "https://pbgpluat.smartgasnet.com/api/";
      case EnvironmentFlavors.prodMGL:
        return "https://mgl.smartgasnet.com/api/";
    }
  }

  String get imageBaseURL {
    print("flavor-->${flavors}");
    switch (flavors) {
      case EnvironmentFlavors.prodPBGPL:
        return "https://pbgpluat.smartgasnet.com/";
      case EnvironmentFlavors.prodMGL:
        return "https://mgl.smartgasnet.com/";
    }
  }

  Color get primaryTheme {
    switch (flavors) {
      case EnvironmentFlavors.prodPBGPL:
        return Colors.green.shade800;
      case EnvironmentFlavors.prodMGL:
        return Colors.green.shade800;
    }
  }
}
