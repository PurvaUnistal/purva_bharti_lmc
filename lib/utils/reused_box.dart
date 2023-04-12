import 'package:flutter/material.dart';

class ReusedBox extends StatelessWidget {
  final String text;
  final Color color;
  const ReusedBox({Key key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 100,
      margin: EdgeInsets.symmetric(horizontal:8),
      child: Card(
        elevation: 10,
        color: color,
        child: Align(
          alignment: Alignment.center,
          child: Text(text,
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
