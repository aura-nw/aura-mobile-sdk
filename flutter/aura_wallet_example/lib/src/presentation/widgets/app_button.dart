import 'package:aura_wallet_example/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:aura_wallet_example/src/core/typography.dart';
import 'package:flutter/material.dart';

extension RadiusX on Radius {
  Radius subtract(double value) => Radius.elliptical(x - value, y - value);
}

extension BorderRadiusX on BorderRadius {
  BorderRadius subtractBy(double value) => copyWith(
        topLeft: topLeft.subtract(1),
        topRight: topRight.subtract(1),
        bottomLeft: bottomLeft.subtract(1),
        bottomRight: bottomRight.subtract(1),
      );
}

class AppButton extends StatelessWidget {
  final String text;
  final Widget? leading;
  final TextStyle textStyle;

  final Color? color;
  final Gradient? gradient;

  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final double? minWidth;

  final bool disabled;
  final bool loading;

  final void Function()? onPress;

  AppButton({
    Key? key,
    required this.text,
    this.onPress,
    this.color,
    this.gradient,
    this.minWidth,
    this.leading,
    bool? loading,
    bool? disabled,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
  })  : assert(color == null || gradient == null),
        loading = loading ?? false,
        disabled = (disabled ?? false) || (loading ?? false),
        padding = padding ?? const EdgeInsets.all(16),
        borderRadius = borderRadius ?? BorderRadius.circular(16),
        textStyle = textStyle ?? AppTypoGraPhy.button16,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: AppThemeBuilder(
        builder: (theme) => Ink(
          decoration: BoxDecoration(
            color: disabled ? theme.neutralColor5 : color,
            gradient: disabled ? null : gradient,
          ),
          child: InkWell(
            splashColor: Colors.white10,
            highlightColor: Colors.white10,
            onTap: disabled ? null : onPress,
            child: Container(
              constraints:
                  minWidth != null ? BoxConstraints(minWidth: minWidth!) : null,
              padding: padding,
              alignment: Alignment.center,
              child: loading
                  ? SizedBox.square(
                      dimension: 19.2,
                      child: CircularProgressIndicator(color: textStyle.color))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        leading ?? const SizedBox.shrink(),
                        if (leading != null)
                          const SizedBox(
                            width: 7,
                          ),
                        Text(text, style: textStyle),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final bool? disabled;
  final bool? loading;
  final void Function() onPress;

  const GradientButton({
    Key? key,
    required this.text,
    required this.onPress,
    required this.gradient,
    this.borderRadius,
    this.textStyle,
    this.padding,
    this.disabled,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: text,
      borderRadius: borderRadius,
      gradient: gradient,
      disabled: disabled,
      loading: loading,
      padding: padding,
      textStyle: textStyle,
      onPress: onPress,
    );
  }
}

class PrimaryGradientButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final bool disabled;
  final bool loading;
  final void Function() onPress;

  PrimaryGradientButton({
    Key? key,
    required this.text,
    required this.onPress,
    bool? disabled,
    bool? loading,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
  })  : padding = padding ?? const EdgeInsets.all(16),
        borderRadius = borderRadius ?? BorderRadius.circular(16),
        textStyle = textStyle ?? AppTypoGraPhy.button16,
        disabled = disabled ?? false,
        loading = loading ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) => GradientButton(
        gradient: theme.gradient2,
        onPress: onPress,
        text: text,
        textStyle: textStyle.copyWith(color: theme.lightColor),
        loading: loading,
        disabled: disabled,
        borderRadius: borderRadius,
        padding: padding,
      ),
    );
  }
}

class InactiveGradientButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final bool disabled;
  final bool loading;
  final void Function() onPress;

  InactiveGradientButton({
    Key? key,
    required this.text,
    required this.onPress,
    bool? disabled,
    bool? loading,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
  })  : padding = padding ?? const EdgeInsets.all(16),
        borderRadius = borderRadius ?? BorderRadius.circular(10),
        textStyle = textStyle ?? AppTypoGraPhy.button16,
        disabled = disabled ?? false,
        loading = loading ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) => GradientButton(
        gradient: theme.gradient5,
        onPress: onPress,
        text: text,
        textStyle: textStyle.copyWith(color: theme.lightColor),
        loading: loading,
        disabled: disabled,
        borderRadius: borderRadius,
        padding: padding,
      ),
    );
  }
}

class GradientBorderButton extends StatelessWidget {
  /// Can be String or Widget
  final dynamic text;
  final TextStyle textStyle;

  final Color contentBackgroundColor;
  final Gradient gradient;

  final EdgeInsets padding;
  final double borderWidth;
  final BorderRadius borderRadius;
  final double? minWidth;
  final Widget? leading;

  final bool disabled;
  final bool loading;

  final void Function()? onPress;

  GradientBorderButton({
    super.key,
    required this.text,
    required this.gradient,
    this.onPress,
    this.borderWidth = 2,
    this.contentBackgroundColor = Colors.white,
    this.minWidth,
    this.leading,
    bool? loading,
    bool? disabled,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
  })  : loading = loading ?? false,
        disabled = disabled ?? false,
        padding = padding ?? const EdgeInsets.all(16),
        borderRadius = borderRadius ?? BorderRadius.circular(16),
        textStyle = textStyle ?? AppTypoGraPhy.button16;

  BorderRadius get innerBorderRadius => borderRadius.subtractBy(1);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          gradient: disabled ? null : gradient,
        ),
        child: InkWell(
          splashColor: Colors.white10,
          highlightColor: Colors.white10,
          onTap: disabled ? null : onPress,
          child: Container(
            padding: EdgeInsets.all(borderWidth),
            child: Container(
              constraints:
                  minWidth != null ? BoxConstraints(minWidth: minWidth!) : null,
              padding: padding,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: contentBackgroundColor,
                  borderRadius: innerBorderRadius),
              child: loading
                  ? const SizedBox.square(
                      dimension: 19.2,
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        leading ?? const SizedBox.shrink(),
                        if (text is String) Text(text, style: textStyle),
                        if (text is Widget) text,
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
