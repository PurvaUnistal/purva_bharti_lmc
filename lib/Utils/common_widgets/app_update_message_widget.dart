import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'res/app_color.dart';

class AppUpdateMessage {
  static showAlertDialog(
      {required BuildContext context, required VoidCallback onPressed, bool? isLater}) {
    Widget cancelButton = TextButton(
      child: isLater == null
          ? Text(
              "Update Later",style: TextStyle(fontSize: 14),

            )
          : isLater == true
              ? const SizedBox.shrink()
              : Text(
                  "Update Later",style: TextStyle(fontSize: 14),
                ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Update Now",style: TextStyle(fontSize: 14,color: AppColor.primer, fontWeight: FontWeight.w700),
      ),
      onPressed:onPressed
    );
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Builder(builder: (context) {
        return Text(
          "Update Available",style: TextStyle(fontSize: 16,color: AppColor.primer, fontWeight: FontWeight.w700),
        );
      }),
      content: Text(
        "Please update the app to continue",style: TextStyle(fontSize: 14),
      ),
      actions: [
       // cancelButton,
        continueButton,
      ],
    );
    showDialog(
      barrierDismissible: isLater ?? false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
