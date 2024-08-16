import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:substring_highlight/substring_highlight.dart';

class AutoCompleteTextFieldWidget extends StatelessWidget {
  final List<String> suggestions;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? enabled;
  final String? star;
  final String? label;
  final String? hintText;
  final TextInputType? keyboardType;
  final Function(String)? onSelected;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  TextEditingController? controller;
  InputBorder? errorBorder;

  AutoCompleteTextFieldWidget({
    super.key,
    required this.suggestions,
    this.suffixIcon,
    this.prefixIcon,
    this.star,
    this.enabled,
    this.label,
    this.hintText,
    this.keyboardType,
    this.onSelected,
    this.onChanged,
    this.validator,
    this.controller,
    this.errorBorder
  });

  @override
  Widget build(BuildContext context) {
    return  Autocomplete(
      initialValue: TextEditingValue(text: controller?.text ?? ""),
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        } else {
          return suggestions.where((word) {
            String startsFilter = word.toLowerCase().toString();
            return startsFilter.startsWith(textEditingValue.text.toLowerCase());
          });
        }
      },
      optionsViewBuilder:
          (context, Function(String) onSelectedOption, options) {
        return Material(
          elevation: 4,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final option = options.elementAt(index);
              return ListTile(
                // title: Text(option.toString()),
                title: SubstringHighlight(
                  text: option.toString(),
                  term: controller!.text,
                  textStyleHighlight: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize:18 ),
                ),
                onTap: () {
                 onSelectedOption(option.toString());
                 this.onSelected!(option.toString());
                },
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: options.length,
          ),
        );
      },
      onSelected: (selectedString) {
        print(selectedString);
      },
      fieldViewBuilder:
          (context, controller, focusNode, onEditingComplete) {
        return TextFormField(
          cursorColor: AppColor.primer,
          controller: controller,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          validator: validator,
          style: Styles.texts,
          onChanged: onChanged,
          decoration: InputDecoration(
            counterText: "",
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorStyle: Styles.subStar,
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
            fillColor: AppColor.white,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: prefixIcon != null || suffixIcon != null ? 10 : 10),
            border: enabled == false ? borderGrey : border,
            focusedBorder: enabled == false ? borderGrey : border,
            disabledBorder: enabled == false ? borderGrey : border,
            enabledBorder: enabled == false ? borderGrey : border,
            errorBorder: errorBorder,
            hintText: hintText,
            hintStyle: enabled == false ? Styles.labelGrey : Styles.labels,
            label: Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(flex: 1, child: Text(star ?? "", style: Styles.stars)),
                  Flexible(
                    flex: 6,
                    child: Text(label ?? "", style: enabled == false ? Styles.labelGrey : Styles.labels),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: AppColor.primer, style: BorderStyle.solid, width: 0.80),
  );
  OutlineInputBorder borderGrey = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: AppColor.grey, style: BorderStyle.solid, width: 0.80),
  );
  OutlineInputBorder borderRed = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: AppColor.red, style: BorderStyle.solid, width: 0.80),
  );
}
