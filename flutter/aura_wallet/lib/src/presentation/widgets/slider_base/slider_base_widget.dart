import 'package:aura_wallet/src/application/wrappers/app_theme/app_theme.dart';
import 'package:aura_wallet/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:flutter/material.dart';

typedef OnSliderChange<T> = void Function(T value);

abstract class SliderBaseWidget<T> extends StatefulWidget {
  final double maxValue;
  final double minValue;
  final OnSliderChange<T>? onChange;
  final T? value;

  const SliderBaseWidget({
    required this.maxValue,
    required this.minValue,
    this.onChange,
    this.value,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      SliderBaseWidgetState<SliderBaseWidget, T>();
}

class SliderBaseWidgetState<R extends SliderBaseWidget, T> extends State<R> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleBuilder(context,theme),
            builder(context,theme),
          ],
        );
      },
    );
  }

  late T startValue;

  T get getCurrent => startValue;

  OnSliderChange<T> get sliderChange => (value) {
        widget.onChange?.call(value);
        startValue = value;
        set();
      };

  OnSliderChange<T> get sliderChangeStart => (value) {
        startValue = value;
        widget.onChange?.call(getCurrent);
      };

  OnSliderChange<T> get sliderChangeEnd => (value) {
        startValue = value;
        widget.onChange?.call(getCurrent);
      };

  Widget titleBuilder(
    BuildContext context,
    AppTheme appTheme,
  ) =>
      throw UnimplementedError();

  Widget builder(
    BuildContext context,
    AppTheme appTheme,
  ) =>
      throw UnimplementedError();

  void set() => setState(() {});
}

class CustomRangeSlider extends SliderBaseWidget<RangeValues> {
  const CustomRangeSlider({
    double max = 100,
    double min = 0,
    OnSliderChange? onChange,
    RangeValues? current,
    Key? key,
  }) : super(
          key: key,
          maxValue: max,
          minValue: min,
          onChange: onChange,
          value: current,
        );

  @override
  State<StatefulWidget> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState
    extends SliderBaseWidgetState<CustomRangeSlider, RangeValues> {
  @override
  void initState() {
    super.initState();
    startValue = widget.value ?? const RangeValues(0, 100);
  }

  @override
  Widget builder(BuildContext context,AppTheme theme) {
    return RangeSlider(
      values: getCurrent,
      onChanged: sliderChange,
      inactiveColor: theme.primaryColor6,
      activeColor: theme.primaryColor1,
      max: widget.maxValue,
      min: widget.minValue,
      onChangeStart: sliderChangeStart,
      onChangeEnd: sliderChangeEnd,
    );
  }
}
