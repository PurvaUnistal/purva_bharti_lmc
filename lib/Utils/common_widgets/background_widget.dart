import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          child,
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          EnvironmentConfig.of(context)!.secondaryTheme,
                          EnvironmentConfig.of(context)!.primaryTheme,]),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                            AppString.companyName,
                            textAlign: TextAlign.start,
                            style: Styles.rel,
                          )),
                      Text(
                        "Version-${AppConfig.instanceInit()!.buildNumber}${AppString.date}",
                        textAlign: TextAlign.start,
                        style: Styles.rel,
                      ),
                    ],
                  )))
        ],
      ),
    );

  }
}