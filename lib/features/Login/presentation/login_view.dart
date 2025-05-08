import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:lmc/Utils/common_widgets/WidgetStyles/common_style.dart';
import 'package:lmc/Utils/common_widgets/background_widget.dart';
import 'package:lmc/Utils/common_widgets/button_widget.dart';
import 'package:lmc/Utils/common_widgets/icon_button.dart';
import 'package:lmc/Utils/common_widgets/res/app_asset.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/enums.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/Login/domain/bloc/login_bloc.dart';
import 'package:lmc/features/Login/domain/bloc/login_event.dart';
import 'package:lmc/features/Login/domain/bloc/login_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    BlocProvider.of<LoginBloc>(context).add(LoginPageLoadingEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.green50,
      appBar: AppBarWidget(
        title: AppString.lmcMobilityH,
        boolLeading: false,
      ),
      body: SafeArea(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginFetchDataState) {
              return BackgroundWidget(
                child: Center(
                  child: _buildLayout(dataState: state),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _buildLayout({required LoginFetchDataState dataState}) {
    var h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: h * 0.6,
                child: Card(
                  elevation: 8,
                  shadowColor: AppColor.primer1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _emailWidget(dataState: dataState),
                        CommonStyle.vertical(context: context),
                        _passwordWidget(dataState: dataState),
                        CommonStyle.vertical(context: context),
                        CommonStyle.vertical(context: context),
                        _loginBtnWidget(dataState: dataState),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -80,
            left: .0,
            right: .0,
            child: _logoWidget(),
          ),
        ],
      ),
    );
  }

  Widget _logoWidget() {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(23.0),
      child: Image.asset(
        AppConfig.instanceInit()!.client == Client.purvaBharti
            ? AppIcon.pbgplLogo
            :AppConfig.instanceInit()!.client == Client.mahaNagar
            ? AppIcon.mglLogo
            : AppIcon.pbgplLogo,
        width: w * 0.4,
        height: h * 0.16,
      ),
    );
  }

  Widget _emailWidget({required LoginFetchDataState dataState}) {
    return TextFieldWidget(
      label: AppString.emailLabel,
      hintText: AppString.emailLabel,
      autofillHints: [AutofillHints.email, AutofillHints.password],
      keyboardType: TextInputType.emailAddress,
      prefixIcon: IconButtonWidget(iconData: Icons.email, onPressed: () {}),
      onChanged: (val) {
        BlocProvider.of<LoginBloc>(context).add(LoginSetEmailIdEvent(emailId: val.toString().replaceAll(" ", "")));
      },
    );
  }

  Widget _passwordWidget({required LoginFetchDataState dataState}) {
    return TextFieldWidget(
      label: AppString.passwordLabel,
      hintText: AppString.passwordLabel,
      autofillHints: const [AutofillHints.password, AutofillHints.email],
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: IconButtonWidget(iconData: Icons.password, onPressed: () {}),
      suffixIcon: IconButtonWidget(
          iconData: dataState.isPassword ? Icons.visibility_off : Icons.visibility,
          onPressed: () {
            BlocProvider.of<LoginBloc>(context).add(LoginHideShowPasswordEvent(isHideShow: dataState.isPassword == true ? false : true));
          }),
      obscureText: dataState.isPassword,
      onChanged: (val) {
        BlocProvider.of<LoginBloc>(context).add(LoginSetPasswordEvent(password: val.toString().replaceAll(" ", "")));
      },
    );
  }

  Widget _loginBtnWidget({required LoginFetchDataState dataState}) {
    return dataState.isPageLoader == false
        ? ButtonWidget(
            text: AppString.login,
            onPressed: () {
              FocusScope.of(context).unfocus();
              TextInput.finishAutofillContext();
              BlocProvider.of<LoginBloc>(context).add(LoginSubmitDataEvent(context: context, isLoginLoading: true));
            })
        : DottedLoaderWidget();
  }
}
