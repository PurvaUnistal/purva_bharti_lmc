import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextEmailField extends StatelessWidget {
  CustomTextEmailField({
    this.controller,
    this.hintText,
    this.labelText,
    this.helpText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword,
    this.enabled,
    this.readOnly,
    this.borderColor,
    this.onChanged,
    this.validate,
    this.errortxt,
    this.onTap,
    this.filledColor,
    this.prefixWidget,
    this.initialValue,
    this.horizontalPadding = 15,
    this.verticalPadding = 0,
    this.maxLines ,
    this.keyboardType ,
    this.textInputAction
  });

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool validate;
  final String errortxt;
  final Function onChanged;
  final String helpText;
  final IconData prefixIcon;
  final IconButton suffixIcon;
  final bool isPassword;
  final bool enabled;
  final bool readOnly;
  final Color borderColor;
  final Function onTap;
  final Color filledColor;
  final Widget prefixWidget;
  final String initialValue;
  final double horizontalPadding;
  final double verticalPadding;
  final int maxLines;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  // final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: TextFormField(
        readOnly: false,
        inputFormatters: [FilteringTextInputFormatter.deny(' ')],
        initialValue: initialValue,
        maxLines: maxLines,
        keyboardType: keyboardType,
        textInputAction :textInputAction,
        controller: controller,
        obscureText: null == isPassword ? false : true,
        onChanged: onChanged,
        toolbarOptions: ToolbarOptions(
          cut: true,
          copy: false,
          selectAll: true,
          paste: false,
        ),
        enableInteractiveSelection: validate,
        onTap: onTap,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
            alignLabelWithHint: true,
            labelText: labelText,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            errorText: validate ? null : errortxt,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey,width: 1.0,),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey, width: 1.0,),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: null == borderColor ? Colors.teal : borderColor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            fillColor: filledColor,
            filled: true,
            hintText: null == hintText ? '' : hintText,
            helperText: null == helpText ? '' : helpText,
            prefixIcon: null == prefixIcon ? null : Icon(prefixIcon),
            suffixIcon: suffixIcon ,
            enabled: enabled,
            prefix: prefixWidget),
      ),
    );
  }
}
