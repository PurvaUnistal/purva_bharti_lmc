import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/features/login/domain/bloc/login_event.dart';
import 'package:lmc/features/login/domain/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  LoginBloc() : super(LoginStateInit()){
  //  on<LoginLoadingEvent>(_pageLoad);

  }

  bool _isLoader = false;
  bool get isLoader => _isLoader;

  bool _isPassword = false;
  bool get isPassword => _isPassword;

  String emailId = "";
  String password = "";

  pageLoader(LoginLoadingEvent event, emit){
    emailId = "";
    password = "";
    _isPassword = true;
    _isLoader = false;
    _eventComplete(emit);

  }

  _setEmailId(LoginEmailEvent event, emit){
    emailId = event.emailId.toString();
  }
  _setPassword(LoginPasswordEvent event, emit){
    password = event.password.toString();
  }
  _setHideShow(LoginHideShowPasswordEvent event, emit){
    _isPassword = event.visible;
  }

  _eventComplete(Emitter<LoginState> emit){
    emit(LoginFetchDataState(isLoader:isLoader,isPassword: isPassword ));

  }

}
