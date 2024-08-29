import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/WidgetStyles/common_style.dart';
import 'package:lmc/Utils/common_widgets/button_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/row_widget.dart';
import 'package:lmc/features/Login/presentation/login_view.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height /4.9,
      margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      child: ListView(
        children: [
          Text(AppString.logout+"?",style: Styles.stars,textAlign: TextAlign.center,),
          CommonStyle.vertical(context: context),
          Text(AppString.logoutMsg,textAlign: TextAlign.center, style: Styles.text,),
          CommonStyle.vertical(context: context),
          CommonStyle.vertical(context: context),
          RowWidget(
            widget1: ButtonWidget(
                text: AppString.logout,
                onPressed: () async {
                  await SharedPref.clearAll();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginView()),
                          (route) => false
                  );
                }
            ),
            widget2: ButtonWidget(
                text: AppString.no,
                onPressed: () {
                  Navigator.of(context).pop();
                }
            ),)

        ],
      ),
    );
  }
}
