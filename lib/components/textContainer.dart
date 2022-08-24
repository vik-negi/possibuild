import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  const TextContainer({
    Key? key,
    required this.text,
    this.size,
    this.fontweight,
    this.color,
  }) : super(key: key);
  final String text;
  final double? size;
  final FontWeight? fontweight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: size ?? 18,
          fontWeight: fontweight ?? FontWeight.w400,
          color: color ?? Colors.black,
        ),
      ),
    );
  }
}
