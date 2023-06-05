import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/features/login/domain/bloc/login_event.dart';
import 'package:lmc/features/login/domain/bloc/login_state.dart';
import 'package:lmc/features/login/domain/model/login_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  LoginBloc() : super(LoginStateInit()){
    on<LoginLoadingEvent>(pageLoader);
    on<LoginEmailEvent>(_setEmailId);
    on<LoginPasswordEvent>(_setPassword);
    on<LoginHideShowPasswordEvent>(_setHideShow);
  //  on<LoginSubmitEvent>(_submitLoginData);

  }

  bool _isLoader = false;
  bool get isLoader => _isLoader;

  bool _isPassword = false;
  bool get isPassword => _isPassword;

  String emailId = "";
  String password = "";

  LoginModel _loginModel = LoginModel();
  LoginModel get loginModel => _loginModel;


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
  _submitData(LoginSubmitEvent event, emit){

  }

  _eventComplete(Emitter<LoginState> emit){
    emit(LoginFetchDataState(isLoader:isLoader,isPassword: isPassword ));

  }

}
