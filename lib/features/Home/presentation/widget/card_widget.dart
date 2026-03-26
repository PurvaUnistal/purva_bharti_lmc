import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/WidgetStyles/common_style.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';

class CardWidget extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  final String text;
  const CardWidget({super.key, required this.onTap, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.22,
          height: MediaQuery.of(context).size.height * 0.091,
          child: Card(
            shadowColor: EnvironmentConfig.of(context)!.secondaryTheme,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // optional rounded corners
              side: BorderSide(
                color: EnvironmentConfig.of(context)!.secondaryTheme, // border color
                width: 0.5, // border thickness
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: EnvironmentConfig.of(context)!.secondaryTheme,
                ),
                CommonStyle.widthSpace(context: context),
                Flexible(
                    child: Text(
                  text,
                  style: Styles.labels,
                  textAlign: TextAlign.center,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
