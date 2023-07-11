import 'package:aura_wallet_example/src/application/wrappers/app_theme/app_theme.dart';
import 'package:aura_wallet_example/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:aura_wallet_example/src/application/wrappers/localization/app_localization_provider.dart';
import 'package:aura_wallet_example/src/application/wrappers/localization/localization_manager.dart';
import 'package:aura_wallet_example/src/core/constants/language_key.dart';
import 'package:aura_wallet_example/src/core/typography.dart';
import 'package:aura_wallet_example/src/presentation/widgets/slider_base/slider_base_widget.dart';
import 'package:flutter/material.dart';

class FeeSliderWidget extends SliderBaseWidget<double> {
  const FeeSliderWidget({
    double max = 200,
    double min = 0,
    double current = 100,
    OnSliderChange? onChange,
    Key? key,
  }) : super(
          key: key,
          maxValue: max,
          minValue: min,
          onChange: onChange,
          value: current,
        );

  @override
  State<StatefulWidget> createState() => _FeeSliderWidgetState();
}

class _FeeSliderWidgetState
    extends SliderBaseWidgetState<FeeSliderWidget, double> {
  @override
  void initState() {
    super.initState();
    startValue = widget.value ?? 0.0;
  }

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return AppThemeBuilder(
      builder: (theme) {
        return SliderTheme(
          data: SliderThemeData(
            overlayShape: SliderComponentShape.noThumb,
            trackShape: const FeeTrackShape(),
          ),
          child: Slider(
            value: getCurrent,
            onChanged: sliderChange,
            onChangeEnd: sliderChangeEnd,
            onChangeStart: sliderChangeStart,
            activeColor: theme.primaryColor6,
            max: widget.maxValue,
            min: widget.minValue,
            inactiveColor: theme.primaryColor1,
          ),
        );
      },
    );
  }

  @override
  Widget titleBuilder(BuildContext context, AppTheme theme) {
    return Column(
      children: [
        AppLocalizationProvider(
          builder: (language, _) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getPriority(language),
                  style: AppTypoGraPhy.caption12.copyWith(
                    color: theme.lightColor,
                  ),
                ),
                Text(
                  '${language.translate(
                    LanguageKey.sendTransactionFee,
                  )} : ${getCurrent.toInt()} UAURA',
                  style: AppTypoGraPhy.caption12.copyWith(
                    color: theme.lightColor,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }

  String getPriority(AppLocalizationManager language) {
    if (getCurrent >= 0 && getCurrent <= 70) {
      return language.translate(LanguageKey.sendTransactionFeeLow);
    } else if (getCurrent > 70 && getCurrent <= 140) {
      return language.translate(LanguageKey.sendTransactionFeeMedium);
    } else {
      return language.translate(LanguageKey.sendTransactionFeeHigh);
    }
  }
}

class FeeTrackShape extends RoundedRectSliderTrackShape {
  const FeeTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
