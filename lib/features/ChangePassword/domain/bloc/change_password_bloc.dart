import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/features/ChangePassword/domain/bloc/change_password_event.dart';
import 'package:lmc/features/ChangePassword/domain/bloc/change_password_state.dart';
import 'package:lmc/features/ChangePassword/helper/change_password_helper.dart';
import 'package:lmc/screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/custom_toast.dart';
import '../../../../utils/global_constant.dart';
import '../model/change_password_model.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState>{
  ChangePasswordBloc() : super(ChangePasswordInitial()){
    on<ChangePasswordPageLoaderEvent>(_pageLoad);
    on<NewPasswordEvent>(_setPassword);
    on<ConfirmPasswordEvent>(_setConfirmPassword);
    on<ChangePasswordSubmitEvent>(changePasswordMethod);
  }

  String password = "";
  String confirmPassword = "";

  bool _isLoader =  false;
  bool get isLoader => _isLoader;

  bool _isPassword = true;
  bool get isPassword => _isPassword;

  ChangePasswordModel _changePasswordModel = ChangePasswordModel();
  ChangePasswordModel get changePasswordModel => _changePasswordModel;
  _pageLoad(ChangePasswordPageLoaderEvent event, emit) {
     password = "";
    _isPassword =  true;
    _isLoader =  false;
  //  _eventCompleted(emit);
  }
  ChangePasswordHelper changePasswordHelper = ChangePasswordHelper();
  _setPassword(NewPasswordEvent event, state){
    password = event.newPassword.trim().toString();
  }
  _setConfirmPassword(ConfirmPasswordEvent event, state){
    confirmPassword = event.confirmPassword.trim().toString();
  }

  changePasswordMethod(ChangePasswordSubmitEvent event, emit) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId  = prefs.getString(GlobalConstants.id);
    _changePasswordModel = ChangePasswordModel();
 //   var textFieldValidationCheck = await ChangePasswordHelper.textFieldValidation(newPassword: password,confirmPassword:confirmPassword ,context: event.context);
   // if(textFieldValidationCheck == true){
      var res = await ChangePasswordHelper.fetchChangePassword(userId, password, confirmPassword);
      if(res != null){
        _changePasswordModel = ChangePasswordModel();
        print("Not Null Data");
        print(res);
        CustomToast.showToast(res);
        Navigator.pushAndRemoveUntil(
          event.context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
              (Route<dynamic> route) => false,
        );
      }else{
        print("Null Data");
      }
  //  }
  }

}