import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widget/app_color.dart';
import 'package:lmc/Utils/common_widget/styles_widget.dart';


class DropdownWidget<T> extends StatelessWidget {
  final T? dropdownValue;
  final String hint;
  final String? label;
  final String? star;
//  final ValueChanged<T?> onChanged;
  final void Function(T?)? onChanged;
  final List<T> items;

   DropdownWidget({
    Key? key,
    required this.dropdownValue,
    required this.onChanged,
    required this.items,
    required this.hint,
    this.star,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
        borderRadius: BorderRadius.circular(5),
        decoration: InputDecoration(
          isDense: false,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
          enabledBorder: border,
          disabledBorder:  border,
          border:  border,
          focusedBorder: border,
          label: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: Text(star??"", style:Styles.stars)),
                Flexible(flex : 6,child: Text(label  ?? "", style:Styles.labels)),
              ],
            ),
          ),
        ),
        hint: Text(hint, style:Styles.labels),
        style: Styles.labels,
        isExpanded: true,
        value: dropdownValue != null ? dropdownValue : null,
        items: items.map<DropdownMenuItem<T>>((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(
              value.toString(),
              style: Styles.labels,
            ),
          );
        }).toList(),
        onChanged: onChanged
        );
  }

  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: AppColor.primer, style: BorderStyle.solid, width: 0.80),
  );
}
