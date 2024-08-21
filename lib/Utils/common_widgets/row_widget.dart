import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;
  const RowWidget({super.key, required this.widget1, required this.widget2,});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(flex:1,child: widget1),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        ),
        Flexible(flex: 1,child: widget2),
      ],
    );
  }
}
