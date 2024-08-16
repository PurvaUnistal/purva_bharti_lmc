import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;
  final Widget? widget3;
  const RowWidget({super.key, required this.widget1, required this.widget2, this.widget3});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(flex:1,child: widget1),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.009,
        ),
        Flexible(flex: 1,child: widget2),
        widget3 == null  ? Container()  : SizedBox(
          width: MediaQuery.of(context).size.width * 0.009,
        ),
        widget3 == null  ? Container()  : Flexible(flex: 1,child: widget3!),
      ],
    );
  }
}
