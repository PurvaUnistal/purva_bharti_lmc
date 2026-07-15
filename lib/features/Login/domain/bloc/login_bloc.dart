import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/connectivity_helper.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/Utils/common_widgets/res/enums.dart';
import 'package:lmc/features/Login/domain/bloc/login_event.dart';
import 'package:lmc/features/Login/domain/bloc/login_state.dart';
import 'package:lmc/features/Login/domain/model/login_model.dart';
import 'package:lmc/features/Login/helper/login_helper.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitState()) {
    on<LoginPageLoadingEvent>(_pageLoad);
    on<LoginHideShowPasswordEvent>(_setHideShowPassword);
    on<LoginSubmitDataEvent>(_setSubmitLoginData);
  }

  bool _isPageLoader = false;
  bool get isPageLoader => _isPageLoader;

  bool _isPassword = false;
  bool get isPassword => _isPassword;

  LoginModel _loginModel = LoginModel();
  LoginModel get loginModel => _loginModel;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var client = AppConfig.instanceInit()!.client == Client.agcl;

  _pageLoad(LoginPageLoadingEvent event, emit) async {
    emailController.text = "";
    passwordController.text = "";
    _isPassword = true;
    _isPageLoader = false;
    client = AppConfig.instanceInit()!.client == Client.agcl;
    _eventCompleted(emit);
  }

  _setHideShowPassword(LoginHideShowPasswordEvent event, emit) {
    _isPassword = event.isHideShow;
    _eventCompleted(emit);
  }

  _setSubmitLoginData(LoginSubmitDataEvent event, emit) async {
    if (await ConnectivityHelper.allConnectivityCheck(context: event.context) == false) {
      return;
    }

    var validationCheck = await LoginHelper.textFieldValidation(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      context: event.context,
    );

    if (validationCheck != true) {
      return;
    }

    try {
      _isPageLoader = true;
      _eventCompleted(emit);

      var res = await LoginHelper.loginData(
        emailId: emailController.text.trim(),
        password: passwordController.text.trim(),
        context: event.context,
      );

      final role = res?.user?.role?.toLowerCase();

      // AGCL client also allows "feasibility" role; other clients only ngc/lmc
      final isAllowedRole = client
          ? (role == "feasibility" || role == "lmc" || role == "ngc")
          : (role == "ngc" || role == "lmc");

      if (res == null || res.user == null || !isAllowedRole) {
        _isPageLoader = false;
        _eventCompleted(emit);
        return Utils.errorSnackBar(
          msg: "Invalid user accessed",
          context: event.context,
        );
      }

      if (res.status != 200) {
        _isPageLoader = false;
        _eventCompleted(emit);
        return Utils.errorSnackBar(msg: "Invalid user accessed", context: event.context,);
      }
      _isPageLoader = false;
      _loginModel = res;

      await Utils.successSnackBar(msg: res.messages!, context: event.context);
      await SharedPref.setString(key: PrefsValue.emailVal, value: emailController.text);
      await SharedPref.setString(key: PrefsValue.passwordVal, value: passwordController.text);

      final userJson = jsonEncode(res.toJson());
      await SharedPref.setString(key: PrefsValue.userInfo, value: userJson);

      await AppConfig.instanceInit()?.setLoginData(newLoginData: _loginModel);

      final packageInfo = await PackageInfo.fromPlatform();
      await SharedPref.setString(key: PrefsValue.buildNumber, value: packageInfo.buildNumber);

      _eventCompleted(emit);
      Navigator.pushReplacementNamed(event.context, RoutesName.home);
    } catch (e) {
      _isPageLoader = false;
      _eventCompleted(emit);
      log("catchLoginBloc-->${e.toString()}");
      Utils.errorSnackBar(
        msg: "Something went wrong. Please try again.",
        context: event.context,
      );
    }
  }

  _eventCompleted(Emitter<LoginState> emit) {
    emit(LoginFetchDataState(
        isPageLoader: isPageLoader,
        isPassword: isPassword,
        emailController: emailController,
        passwordController: passwordController,
      ),
    );
  }
}
