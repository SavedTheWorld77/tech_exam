import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function()? onPress;
  final String text;
  const Button({Key? key, required this.onPress, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 177, 230, 4),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextButton(
          onPressed: onPress,
          child: Text(text, style: const TextStyle(color: Colors.white))),
    );
  }
}
