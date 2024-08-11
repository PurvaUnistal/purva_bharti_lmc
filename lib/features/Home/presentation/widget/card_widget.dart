import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        child: SizedBox(
          width: MediaQuery.of(context).size.height * 0.22,
          height: MediaQuery.of(context).size.height * 0.091,
          child: Card(
            color: Colors.white,
            shadowColor: AppColor.primer1,
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: AppColor.primer1,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
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
