import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class LoginStateInit extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFetchDataState extends LoginStateInit {
  final bool isLoader;
  final bool isPassword;
  LoginFetchDataState({this.isLoader, this.isPassword});
  @override
  List<Object> get props => [isLoader, isPassword];
}