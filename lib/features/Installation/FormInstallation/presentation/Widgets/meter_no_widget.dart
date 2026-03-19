import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';

//ignore: must_be_immutable
class MeterNoWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
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

  MeterNoWidget({
    Key? key,
    this.focusNode,
    this.initialValue,
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
    return SizedBox(
      width: enabled == false ? MediaQuery.of(context).size.width * 0.063 : MediaQuery.of(context).size.width * 0.076,
     // height: enabled == false ? MediaQuery.of(context).size.height * 0.05 : MediaQuery.of(context).size.height * 0.07,
      child: TextFormField(
        cursorColor: EnvironmentConfig.of(context)!.primaryTheme,
        focusNode: focusNode,
        autofillHints: autofillHints,
        onTap: onTap,
        autofocus: autofocus ?? false,
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
          counterText: "",
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          suffixIconConstraints: suffixIcon != null
              ? const BoxConstraints(
                  maxWidth: 30,
                  maxHeight: 25,
                )
              : null,
          prefixIconConstraints: prefixIcon != null
              ? const BoxConstraints(
                  maxWidth: 30,
                  maxHeight: 25,
                )
              : null,
          filled: true,
          fillColor: enabled == false ? AppColor.grey50: AppColor.white,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: prefixIcon != null || suffixIcon != null ? 10 : 10),
          border: enabled == false ? borderGrey : borderRed,
          focusedBorder: enabled == false ? borderGrey : borderRed,
          disabledBorder: enabled == false ? borderGrey : borderRed,
          enabledBorder: enabled == false ? borderGrey : borderRed,
          hintStyle: enabled == false ? Styles.labelGrey : Styles.labels,
        ),
      ),
    );
  }

  OutlineInputBorder border({required BuildContext context}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: EnvironmentConfig.of(context)!.primaryTheme,
        style: BorderStyle.solid,
        width: 0.80,
      ),
    );
  }

  OutlineInputBorder borderGrey = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: AppColor.grey, style: BorderStyle.solid, width: 0.80),
  );
  OutlineInputBorder borderRed = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: AppColor.red, style: BorderStyle.solid, width: 0.80),
  );
}
