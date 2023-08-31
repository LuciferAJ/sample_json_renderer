import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  const CustomTextWidget({required this.text, this.style, super.key});

  factory CustomTextWidget.headline(String? text) => CustomTextWidget(
      text: text,
      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 32));

  factory CustomTextWidget.subHeading(String? text) => CustomTextWidget(
      text: text,
      style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18));

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: text != null,
      replacement: const SizedBox(),
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Text(
          text ?? "",
          style: style,
        ),
      ),
    );
  }
}
