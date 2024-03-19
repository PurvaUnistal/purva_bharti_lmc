import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widget/app_color.dart';


class IconBtnWidget extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  const IconBtnWidget({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 32, color: AppColor.primer),
      onPressed: onPressed,
    );
  }
}
