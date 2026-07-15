import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/service/Apis.dart';

import 'res/UserContext.dart';
import 'res/app_config.dart';
import 'res/environment_config.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appConfig = AppConfig.instanceInit();
    final user = appConfig?.loginData.user;
    return Stack(
      clipBehavior: Clip.none,
      children: [

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            color: EnvironmentConfig.of(context)!.primaryTheme,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (user != null)
                  Text(user.name ?? "", style: Styles.rel),
              ],
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 8.0), child: child),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: EnvironmentConfig.of(context)!.primaryTheme,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppString.companyName, style: Styles.rel),
                Text(AppString.version, style: Styles.rel),
              ],
            ),
          ),
        ),
      ],
    );
  }
}