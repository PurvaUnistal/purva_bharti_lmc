import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({ this.colour, this.title, this.onPressed});
  final Color colour;
  final String title;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(25.0),
        child: MaterialButton(
          onPressed: onPressed,
          //Go to login screen.
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class AppTextFormField {
  static Widget kTextFieldDecoration(String hintText,String label,ValueChanged onChanged) {
    return TextFormField(
      onChanged:onChanged ,
      obscureText: false,
      decoration:  InputDecoration(
          hintText: hintText,
          label: Text(label),
          hintStyle: TextStyle(color: Colors.black),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          )),
    );
  }

  static horizontal(){
    return SizedBox(
      height: 15,
    );
  }
}