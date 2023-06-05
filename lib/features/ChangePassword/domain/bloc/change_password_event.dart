/*
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ChangePasswordEvent extends Equatable{}

class ChangePasswordLoadingEvent extends ChangePasswordEvent {
  @override
  List<Object> get props => [];
}

class NewPasswordEvent extends ChangePasswordEvent{
  final String newPassword;
  NewPasswordEvent({this.newPassword});
  @override
  // TODO: implement props
  List<Object> get props => [newPassword];
}

class ConfirmPasswordEvent extends ChangePasswordEvent{
  final String confirmPassword;
  ConfirmPasswordEvent({this.confirmPassword});
  @override
  // TODO: implement props
  List<Object> get props => [confirmPassword];
}

class ChangePwdSubmitData extends ChangePasswordEvent{
  final BuildContext context;
  ChangePwdSubmitData({this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}



*/


import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ChangePasswordEvent extends Equatable{}


class ChangePasswordPageLoaderEvent extends ChangePasswordEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChangePasswordSubmitEvent extends ChangePasswordEvent{
  final BuildContext context;
  ChangePasswordSubmitEvent({this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
class NewPasswordEvent extends ChangePasswordEvent{
  final String newPassword;
  NewPasswordEvent({this.newPassword});
  @override
  // TODO: implement props
  List<Object> get props => [newPassword];
}

class ConfirmPasswordEvent extends ChangePasswordEvent{
  final String confirmPassword;
  ConfirmPasswordEvent({this.confirmPassword});
  @override
  // TODO: implement props
  List<Object> get props => [confirmPassword];
}

class NewPasswordHideEvent extends ChangePasswordEvent{
  final bool isNewPassword;
  NewPasswordHideEvent({this.isNewPassword});
  @override
  // TODO: implement props
  List<Object> get props => [isNewPassword];
}

class ConfirmPasswordHideEvent extends ChangePasswordEvent{
  final bool isConfirmPassword;
  ConfirmPasswordHideEvent({this.isConfirmPassword});
  @override
  // TODO: implement props
  List<Object> get props => [isConfirmPassword];
}
