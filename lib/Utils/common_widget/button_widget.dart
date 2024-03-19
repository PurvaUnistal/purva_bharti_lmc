import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widget/app_color.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final double? fontSize;
  final BoxDecoration? gradientDecorationColor;

  const ButtonWidget(
      {Key? key,
      this.text,
      this.onPressed,
      this.fontSize,
      this.gradientDecorationColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[AppColor.primer, AppColor.primer1]
            ),
            borderRadius: BorderRadius.all(Radius.circular(12.0))
        ),
        margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
        padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 12),
        child: Text(
          text!,textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.white
          ),
        ),
      ),
    );
  }
}
