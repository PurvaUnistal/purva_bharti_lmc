/*
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

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    BlocProvider.of<ChangePasswordBloc>(context).add(
        ChangePasswordPageLoaderEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChangePasswordBloc changePasswordBloc = context.read<ChangePasswordBloc>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Change Password"),
        ),
        body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
              ));
            }
          },
          child: _buildLayout(),
        )
    );
  }


  Widget _buildLayout() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Center(
        child: SingleChildScrollView(
          reverse: true,
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/icons/ic_launcher.png"),
              horgentental(),
              horgentental(),
              _newPasswordWidget(),
              horgentental(),
              _confirmPasswordWidget(),
              horgentental(),
              horgentental(),
              _loginButton(),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom * 1),
              )
            ],
          ),
        ),
      ),
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

  Widget _newPasswordWidget() {
    ChangePasswordBloc changePasswordBloc = context.read<ChangePasswordBloc>();
    return AppTextFormField(
      hintText:  "New Password",
      labelText: "New Password",
      prefixIcon: Icons.lock_outline_rounded,
      onChanged: (value) =>
          changePasswordBloc.add(NewPasswordEvent(newPassword: value)),
    );
  }

  Widget _confirmPasswordWidget() {
    ChangePasswordBloc changePasswordBloc = context.read<ChangePasswordBloc>();
    return AppTextFormField(
      prefixIcon: Icons.lock_outline_rounded,
      hintText: "Confirm Password",
      labelText:"Confirm Password",
      onChanged: (value) =>
          changePasswordBloc.add(ConfirmPasswordEvent(confirmPassword: value)),

    );
  }

  Widget _loginButton() {
    ChangePasswordBloc changePasswordBloc = context.read<ChangePasswordBloc>();
    return  BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        if (state is ChangePasswordLoading) {
          return buildLoading();
        }
        return ElevatedButton(
            child: Text("Change Password"),
            onPressed: () {
              changePasswordBloc.add(
                  ChangePasswordSubmitEvent(context: context));
            });
      },
    );
  }

  Widget horgentental(){
    return SizedBox(
      height: 15,
    );
  }
}
*/
