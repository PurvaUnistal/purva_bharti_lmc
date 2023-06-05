import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/features/ChangePassword/domain/bloc/change_password_bloc.dart';
import 'package:lmc/features/ChangePassword/domain/bloc/change_password_event.dart';
import 'package:lmc/utils/RoundedButton.dart';

import '../../domain/bloc/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ChangePasswordBloc changePasswordBloc;
  @override
  void initState() {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    BlocProvider.of<ChangePasswordBloc>(context).add(ChangePasswordPageLoaderEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Change Password"),
        ),
        body: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
          builder: (context, state){
             if(state is ChangePasswordInitial){
               print("_buildLayout");
              return buildLoading();
            } else if(state is ChangePasswordLoading){
               return buildLoading();
             } else if(state is ChangePasswordSuccess){
               return _buildLayout(state);
             }else{
               print("notShowingBuildLayout");
              return const SizedBox.shrink();
            }
          },

        )
    );
  }
  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _newPasswordWidget(ChangePasswordSuccess dataState){
    return  AppTextFormField.kTextFieldDecoration(
      "Password",
      "Password", (value)=> BlocProvider.of<ChangePasswordBloc>(context).add(NewPasswordEvent(newPassword: value)),
    );
  }

  Widget _confirmPasswordWidget(ChangePasswordSuccess dataState){
    return  AppTextFormField.kTextFieldDecoration(
      "Confirm Password",
      "Confirm Password",
          (value)=> BlocProvider.of<ChangePasswordBloc>(context).add(ConfirmPasswordEvent(confirmPassword: value)),

    );
  }

  Widget _loginButton(ChangePasswordSuccess dataState){
    return ElevatedButton(
        child: Text("Change Password"),
        onPressed: (){
      BlocProvider.of<ChangePasswordBloc>(context).add(ChangePasswordSubmitEvent(context: context));
    });
  }
  Widget _buildLayout(ChangePasswordSuccess dataState){
    ChangePasswordBloc changePasswordBloc = ChangePasswordBloc();
    return  Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/icons/ic_launcher.png"),
          AppTextFormField.horizontal(),
          AppTextFormField.horizontal(),
          _newPasswordWidget(dataState),
          AppTextFormField.horizontal(),
          _confirmPasswordWidget(dataState),
          AppTextFormField.horizontal(),
          AppTextFormField.horizontal(),
          _loginButton(dataState)
        ],

      ),
    );
  }
}
