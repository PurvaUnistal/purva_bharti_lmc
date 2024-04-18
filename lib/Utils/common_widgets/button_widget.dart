import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/styles_widget.dart';

class ButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const ButtonWidget({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Text(
          text, style: Styles.login,
        ),
      ),
    );
  }
}
