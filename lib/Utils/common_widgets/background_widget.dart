import 'package:flutter/cupertino.dart';
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

    String toTitleCase(String input) {
      if (input.trim().isEmpty) return input;

      return input
          .trim()
          .split(RegExp(r'\s+'))
          .map((word) =>
      word[0].toUpperCase() + word.substring(1).toLowerCase())
          .join(' ');
    }

    final themeColor =
        EnvironmentConfig.of(context)?.primaryTheme ??
            Theme.of(context).primaryColor;

    final rawName = AppConfig.instanceInit()?.loginData.user?.name ?? '';
    final loginUserName = toTitleCase(rawName);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// Top Header
          SafeArea(
            bottom: false,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[ EnvironmentConfig.of(context)!.secondaryTheme,
                      EnvironmentConfig.of(context)!.primaryTheme,]),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              child: Text(
                loginUserName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),

          /// Main Content
          Expanded(child: child),

          /// Footer
          SafeArea(
            top: false,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[ EnvironmentConfig.of(context)!.secondaryTheme,
                      EnvironmentConfig.of(context)!.primaryTheme,]),
              ),

              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      AppString.companyName,
                      style: Styles.rel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(AppString.version, style: Styles.rel),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
