import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/service/Apis.dart';

import 'res/UserContext.dart';
import 'res/environment_config.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctx = UserContext.getUserContext();
    final env = EnvironmentConfig.of(context)!;
    final url = env.imageBaseURL;

    // Same gradient as AppBarWidget
    final appBarGradient = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          env.secondaryTheme,
          env.primaryTheme,
        ],
      ),
    );

    return Column(
      children: [
        ctx.user.name != null && ctx.user.name!.isNotEmpty
            ? Container(
          width: double.infinity,
          decoration: appBarGradient, // gradient instead of flat color
          child: Text(
            "${ctx.user.name!.toUpperCase()}, (${ctx.user.schema!.toUpperCase()}) ${url == Apis.basePath ? "(UAT APP)" : ""}",
            style: Styles.rel,
            overflow: TextOverflow.ellipsis,
          ),
        )
            : Container(),
        Expanded(child: child),
        Container(
          width: double.infinity,
          decoration: appBarGradient, // gradient instead of flat color
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "${AppString.companyName}",
                  textAlign: TextAlign.start,
                  style: Styles.rel,
                ),
              ),
              Flexible(
                child: Text(
                  AppString.version,
                  textAlign: TextAlign.start,
                  style: Styles.rel,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}