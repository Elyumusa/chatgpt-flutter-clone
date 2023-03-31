import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.label,
      this.fontWeight,
      this.fontsize = 18,
      this.color});
  final String label;
  final double fontsize;
  final Color? color;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
          color: color ?? Colors.white,
          fontSize: fontsize,
          fontWeight: fontWeight ?? FontWeight.w500),
    );
  }
}
