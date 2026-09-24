import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lmc/features/Login/domain/model/login_model.dart';
import 'package:lmc/features/NGC/NGCTable/domain/model/LmcInstallationByNgcModel.dart';

import 'enums.dart';
import 'environment_config.dart';

class AppConfig {
  static AppConfig? instance;
  static String? baseUrl;
  RoleType? roleType;
  Client? client;
  LoginModel loginData = LoginModel();
  InstallationByNgcData ngcData = InstallationByNgcData();

  static AppConfig? instanceInit() {
    instance ??= AppConfig();
    return instance;
  }

  String _buildNumber = "";
  String get buildNumber => _buildNumber;

  static void init(BuildContext context) {
    baseUrl = EnvironmentConfig.of(context)!.generalUrlBaseFlavour;
    log("baseUrl --> $baseUrl");
  }

  setBuildNumber({required String buildNumber}) {
    _buildNumber = buildNumber;
  }

  setLoginData({required LoginModel newLoginData}) {
    this.loginData = newLoginData;
  }

  setClient({required Client client}){
    this.client =  client;
  }

  setNGCData({required InstallationByNgcData newNGCData}){
    this.ngcData =  newNGCData;
  }

  static DeviceType getDeviceType({BuildContext? context}) {
    var isPortrait =  true;
    if(context != null){
      isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    }

    final MediaQueryData data = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single);
    /*   return data.size.shortestSide <= 600
        ? DeviceType.phone
        : DeviceType.tablet;*/
    return isPortrait == true
        ? DeviceType.phone
        : DeviceType.tablet;
  }

  void clear() {
    loginData = LoginModel();
  }
}