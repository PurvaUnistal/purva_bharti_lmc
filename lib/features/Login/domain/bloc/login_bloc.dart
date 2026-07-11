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

  _pageLoad(LoginPageLoadingEvent event, emit) async {
    emailController.text = "";
    passwordController.text = "";
    _isPassword = true;
    _isPageLoader = false;
    _eventCompleted(emit);
  }

  _setHideShowPassword(LoginHideShowPasswordEvent event, emit) {
    _isPassword = event.isHideShow;
    _eventCompleted(emit);
  }

  _setSubmitLoginData(LoginSubmitDataEvent event, emit) async {
    // 1. Connectivity check
    if (await ConnectivityHelper.allConnectivityCheck(context: event.context) ==
        false) {
      return;
    }

    // 2. Field validation
    var validationCheck = await LoginHelper.textFieldValidation(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      context: event.context,
    );
    if (validationCheck != true) {
      _eventCompleted(emit);
      return;
    }

    try {
      // 3. Show loader and call API
      _isPageLoader = true;
      _eventCompleted(emit);

      var res = await LoginHelper.loginData(
        emailId: emailController.text.trim(),
        password: passwordController.text.trim(),
        context: event.context,
      );

      // 4. Hide loader
      _isPageLoader = false;

      // 5. Fail fast: null response or missing user (e.g. 401 Unauthorised)
      if (res == null || res.user == null) {
        _eventCompleted(emit);
        Utils.errorSnackBar(
          msg: "Invalid email or password",
          context: event.context,
        );
        return;
      }

      // 6. Single role + status check
      final role = res.user!.role?.toLowerCase() ?? "";
      final isValidRole = role == "lmc" || role == "ngc";

      if (res.status == 200 && isValidRole) {
        _loginModel = res;

        await Utils.successSnackBar(
          msg: res.messages ?? "Login successful",
          context: event.context,
        );

        // NOTE: keys were previously swapped — email now goes to emailVal,
        // password to passwordVal.
        await SharedPref.setString(
          key: PrefsValue.emailVal,
          value: emailController.text,
        );
        await SharedPref.setString(
          key: PrefsValue.passwordVal,
          value: passwordController.text,
        );

        String userJson = jsonEncode(res.toJson());
        await SharedPref.setString(
          key: PrefsValue.userInfo,
          value: userJson,
        );

        await AppConfig.instanceInit()?.setLoginData(
          newLoginData: loginModel,
        );

        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        await SharedPref.setString(
          key: PrefsValue.buildNumber,
          value: packageInfo.buildNumber,
        );

        _eventCompleted(emit);

        if (event.context.mounted) {
          Navigator.pushReplacementNamed(event.context, RoutesName.home);
        }
        return;
      }

      // 7. Wrong role or non-200 status
      _eventCompleted(emit);
      Utils.errorSnackBar(
        msg: "Invalid user accessed",
        context: event.context,
      );
    } catch (e) {
      // 8. Any unexpected error (Dio throw, parsing, null, etc.)
      _isPageLoader = false;
      _eventCompleted(emit);
      log("catchLoginBloc-->${e.toString()}");
      Utils.errorSnackBar(
        msg: "Login failed. Please try again.",
        context: event.context,
      );
    }
  }

  _eventCompleted(Emitter<LoginState> emit) {
    emit(
      LoginFetchDataState(
        isPageLoader: isPageLoader,
        isPassword: isPassword,
        emailController: emailController,
        passwordController: passwordController,
      ),
    );
  }
}