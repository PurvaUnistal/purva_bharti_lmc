import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'input_decoration_style.dart';
import 'res/environment_config.dart';

class DropDownSearchWidget<T> extends StatelessWidget {
  final List<T> items;
  final ValueChanged<dynamic>? onChanged;
  final DropdownSearchItemAsString<dynamic>? itemAsString;
  final String hint;
  final T? dropdownValue;
  final bool isRequired;
  final bool enabled;

  const DropDownSearchWidget({
    super.key,
    required this.items,
    this.onChanged,
    required this.itemAsString,
    required this.hint,
    this.dropdownValue,
    this.isRequired = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      items: items,
      selectedItem: dropdownValue,
      enabled: enabled,
      itemAsString: itemAsString,
      onChanged: onChanged,

      /// ✅ FIXED: REMOVE unsafe compareFn
      compareFn: (item, selected) => item == selected,

      /// ✅ USE COMMON DECORATION
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecorationStyle.inputDecoration(
          context,
          labelText: hint,
          isRequired: isRequired,
        ).copyWith(
          fillColor: enabled ? Colors.white : Colors.grey.shade100,
        ),
      ),

      /// ✅ CLEAN POPUP
      popupProps: PopupProps.dialog(
        showSearchBox: true,

        searchFieldProps: TextFieldProps(
          decoration: InputDecorationStyle.inputDecoration(
            context,
            labelText: "Search",
          ),
        ),
        containerBuilder: (context, popupWidget) {
          return Column(
            children: [
              Expanded(child: popupWidget),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,          // ✅ White background
                        foregroundColor: Colors.black,          // ✅ Black text
                        side: BorderSide(color: EnvironmentConfig.of(context)!.primaryTheme),  // ✅ Grey border
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}