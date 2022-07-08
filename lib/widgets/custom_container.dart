import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final String text;
  final Widget? checkBox;
  const CustomContainer({
    Key? key,
    required this.child,
    required this.text,
    this.checkBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(text,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
              const Spacer(),
              checkBox ?? Container(),
            ],
          ),
          const Divider(),
          child,
        ],
      ),
    );
  }
}
