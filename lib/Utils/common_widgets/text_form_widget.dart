import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';

//ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? star;
  final String? label;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final String? hintText;
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final bool? obscureText;
  final TextInputType? inputType;
  final int? maxLength;
  final int? maxLine;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final bool? enabled;
  final bool? autofocus;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  TextFieldWidget({
    Key? key,
    this.focusNode,
    this.initialValue,
    this.star,
    this.label,
    this.hintText,
    this.labelText,
    this.autofillHints,
    this.controller,
    this.obscureText,
    this.onChanged,
    this.inputType,
    this.maxLength,
    this.maxLine,
    this.onTap,
    this.onFieldSubmitted,
    this.enabled,
    this.autofocus,
    this.textCapitalization,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColor.primer,
      focusNode: focusNode,
      autofillHints: autofillHints,
      onTap: onTap,
      autofocus: autofocus?? false ,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled ?? true,
      maxLength: maxLength,
      maxLines: maxLine ?? 1,
      onChanged: onChanged,
      keyboardType: keyboardType ?? TextInputType.text,
      controller: controller,
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      validator: validator == null ? null : validator,
      textCapitalization: textCapitalization ?? TextCapitalization.words,
      textInputAction: textInputAction ?? TextInputAction.done,
      inputFormatters: inputFormatters,
      style: Styles.texts,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(
          maxWidth: 25,
          maxHeight: 25,
        ),
        hintText: hintText,
        counterText: "",
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(flex : 1,child: Text(star??"",  style:Styles.stars)),
              Flexible(flex : 6,child: Text(label  ?? "", style:Styles.labels),
              ),
            ],
          ),
        ),
        hintStyle: Styles.labels,
        filled: true,
        fillColor: enabled == false ? AppColor.white05 : AppColor.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: suffixIcon!= null ?  8 : 5),
        isDense: true,
        border: enabled == false ? border1 : border,
        focusedBorder: enabled == false ? border1 : border,
        disabledBorder:enabled == false ? border1 : border,
        enabledBorder: enabled == false ? border1 : border,
      ),
    );
  }

  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: AppColor.primer, style: BorderStyle.solid, width: 0.80),
  );
  OutlineInputBorder border1 = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: AppColor.grey, style: BorderStyle.solid, width: 0.80),
  );
}
