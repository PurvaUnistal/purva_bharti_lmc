import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';
import 'package:lmc/Utils/common_widgets/styles_widget.dart';

class AutoSuggestionTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? star;
  final String? label;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final String? hintText;
  final ValueChanged<String>? textSubmitted;
  final ValueChanged<String>? textChanged;
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
  final GlobalKey<AutoCompleteTextFieldState<String>>? globalKey;
  final List<String>? suggestions;
   AutoSuggestionTextFieldWidget({
    super.key,
    this.focusNode,
    this.star,
    this.label,
    this.hintText,
    this.autofillHints,
    this.controller,
    this.obscureText,
    this.textSubmitted,
    this.textChanged,
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
    this.globalKey,
    this.suggestions,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleAutoCompleteTextField(
      key: globalKey!,
      suggestions: suggestions ?? [],
      cursorColor: AppColor.primer,
      focusNode: focusNode,
      autofocus: autofocus?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      controller: controller,
      textSubmitted: textSubmitted,
      textChanged: textChanged,
      clearOnSubmit: false,
      textCapitalization: textCapitalization ?? TextCapitalization.words,
      textInputAction: textInputAction ?? TextInputAction.done,
      style: Styles.texts,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        label: Padding(
          padding: const EdgeInsets.only(left: 2.0),
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
        fillColor: Colors.white,
        contentPadding:  EdgeInsets.symmetric(horizontal: 5.0, vertical: maxLine != null ? 8 : 0),
        border: border,
        focusedBorder: border,
        disabledBorder: border,
        enabledBorder: border,

      ),
    );
  }
  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: AppColor.primer, style: BorderStyle.solid, width: 0.80),
  );
}
