import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          cursorColor: AppColor.primer,
          style: Styles.texts,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            counterText: "",
            label: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(flex : 1,child: Text(star ?? "",  style:Styles.stars)),
                  Flexible(flex : 6,child: Text(label  ?? "", style:Styles.labels),
                  ),
                ],
              ),
            ),
            hintStyle: Styles.labels,
            filled: true,
            fillColor: enabled == false ? AppColor.white05 : AppColor.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
            isDense: true,
            border: enabled == false ? border1 : border,
            focusedBorder: enabled == false ? border1 : border,
            disabledBorder:enabled == false ? border1 : border,
            enabledBorder: enabled == false ? border1 : border,
          ),
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
        );
      },
      optionsBuilder: (TextEditingValue fruitTextEditingValue) {
        if (fruitTextEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return suggestions.where((String option) {
          return option
              .contains(fruitTextEditingValue.text.toLowerCase());
        }

        );
      },
      onSelected: onSelected,
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
