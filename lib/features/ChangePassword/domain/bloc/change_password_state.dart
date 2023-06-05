import 'package:equatable/equatable.dart';
import 'package:lmc/features/ChangePassword/domain/model/change_password_model.dart';

abstract class ChangePasswordState extends Equatable{}

class ChangePasswordInitial extends ChangePasswordState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChangePasswordLoading extends ChangePasswordState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChangePasswordSuccess extends ChangePasswordState{
  final ChangePasswordModel changePasswordModel;
  ChangePasswordSuccess({this.changePasswordModel});
  @override
  // TODO: implement props
  List<Object> get props => [changePasswordModel];
}

class ChangePasswordError extends ChangePasswordState{
  final String error;
  ChangePasswordError({this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}


/*
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ChangePasswordState extends Equatable{}

class ChangePasswordInitState extends ChangePasswordState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChangePasswordPageLoadState extends ChangePasswordInitState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChangePasswordSuccessState extends ChangePasswordInitState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchChangePasswordState extends ChangePasswordInitState{

  final bool isLoader;
  final TextEditingController newPasswordTextFieldController;
  final TextEditingController confirmPasswordTextFieldController;
  final bool isNewPassword;
  final bool isConfirmPassword;

  FetchChangePasswordState({
     this.isLoader,
     this.newPasswordTextFieldController,
     this.confirmPasswordTextFieldController,
     this.isNewPassword,
     this.isConfirmPassword,
  });

  @override
  List<Object> get props => [
    isLoader,
    isNewPassword,
    isConfirmPassword,
    newPasswordTextFieldController,
    confirmPasswordTextFieldController];
}

*/
