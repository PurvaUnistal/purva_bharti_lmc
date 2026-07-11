import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';
import 'package:lmc/Utils/common_widgets/res/singleton.dart';

class Apis {


  // static String baseUrl = 'https://pbgplc.smartgasnet.com/api/';
 //  static String baseUrl = 'https://pbgpluat.smartgasnet.com/api/';
  static String basePath = 'https://pbgpluat.smartgasnet.com/';

  static BuildContext? context = Singleton.instanceInit()?.context;

  static final String baseUrl =
      EnvironmentConfig.of(context!)!.generalUrlBaseFlavour;

  static get loginUrl => "auth";
  static get areaList => "getAllArea?schema=";
  static get getLMCFeasibility => "getlmcapi?";
  static get getLMCInstallation => "getlmcInstallationApi?";
  static get getRFCInstallation => "getlmcRFCInstallationApi?";
  static get getConstant => "getConstant?";
  static get getlmcRFCInstallationApi => "getlmcRFCInstallationApi?";
  static get lmcReason => "lmcreason";
  static get meterReplaceType => "meterreplacetype";
  static get ngcReason => "ngcreason";
  static get regulatorType => "regulatortype";
  static get getMeters => "getMeters?";
  static get getMrRegulators => "getMrRegulators?";
  static get getRegulators => "getRegulators";
  static get getNgcMeters => "getNgcMeters?";
  static get getNgcRegulators => "getNgcRegulators";
  static get getAllFreeMaterial => "getAllFreeMaterial?";
  static get getAllFreePipeMaterial => "getAllFreePipeMaterial?";
  static get getExtraPipeDetails => "getExtraPipeDetails?";
  static get saveLmcFeasibility => "saveLmcFeasibility";
  static get saveLmcInstallation => "saveLmcInstallation";
  static get saveLmcRFCInstallation  => "saveLmcRFCInstallation";


  static get getLmcInstallationByNgc => 'getlmcInstallationbyNgc?';
  static get setNGCReport => 'setNGCReport';
  static get list => 'getlmcInstallationbyNgc';

}
