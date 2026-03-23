import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'res/environment_config.dart';

class CheckboxWidget extends StatelessWidget {
  final String title;
  final bool value;
  final bool isRequired;
  final ValueChanged<bool?> onChanged;
  const CheckboxWidget({super.key, required this.value, required this.onChanged, required this.title, this.isRequired = false,});

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: EnvironmentConfig.of(context)!.primaryTheme,
          width: 0.80
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: CheckboxListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
        visualDensity: VisualDensity.compact,
        title: Text.rich(
          TextSpan(
            children: [
              if (isRequired)
                TextSpan(
                  text: "* ",
                 style:Styles.stars
                ),
              TextSpan(
                text: title,
                style: Styles.texts,
              ),
            ],
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: EnvironmentConfig.of(context)!.primaryTheme,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        controlAffinity: ListTileControlAffinity.leading,

      ),
    );
  }
}
