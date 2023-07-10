import 'package:flutter/material.dart';

class GradientTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;

  const GradientTextWidget(
      {required this.gradient, this.style, required this.text, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTRB(0, 0, bounds.width, bounds.height),
        );
      },
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
