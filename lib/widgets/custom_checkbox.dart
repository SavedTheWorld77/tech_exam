import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: true,
      onChanged: (value) {},
      activeColor: const Color.fromARGB(255, 177, 230, 4),
    );
  }
}
