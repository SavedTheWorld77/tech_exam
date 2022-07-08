import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {Key? key,
      required this.values,
      required this.onChanged,
      required this.initialValue})
      : super(key: key);
  final List<String> values;
  final Function(Object?) onChanged;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: DropdownButton(
        isExpanded: true,
        value: initialValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: values.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
