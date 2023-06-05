import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable{}

class LoginLoadingEvent extends LoginEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginEmailEvent extends LoginEvent{
  final String emailId;
  LoginEmailEvent({this.emailId});
  @override
  // TODO: implement props
  List<Object> get props => [emailId];
}

class LoginPasswordEvent extends LoginEvent{
  final String password;
  LoginPasswordEvent({this.password});
  @override
  // TODO: implement props
  List<Object> get props => [password];
}

class LoginHideShowPasswordEvent extends LoginEvent{
  final bool visible;
  LoginHideShowPasswordEvent({this.visible});
  @override
  // TODO: implement props
  List<Object> get props => [visible];
}

class LoginSubmitEvent extends LoginEvent{
  final BuildContext context;
  final bool isLoginPage;
  LoginSubmitEvent({this.context, this.isLoginPage});
  @override
  // TODO: implement props
  List<Object> get props => [context, isLoginPage];
}
