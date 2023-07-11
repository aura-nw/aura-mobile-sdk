import 'package:aura_wallet_example/src/application/wrappers/app_theme/app_theme.dart';
import 'package:aura_wallet_example/src/core/typography.dart';
import 'package:flutter/material.dart';

import 'text_input_base/text_input_base.dart';

class SuffixTextInputWidget extends TextInputWidgetBase {
  final String label;
  final Widget suffix;
  final VoidCallback? onIconTap;

  const SuffixTextInputWidget({
    required this.label,
    required this.suffix,
    super.key,
    super.controller,
    super.autoFocus,
    super.constraintManager,
    super.enable,
    super.focusNode,
    super.hintText,
    super.inputFormatter,
    super.maxLength,
    super.maxLine,
    super.minLine,
    super.onChanged,
    super.scrollController,
    super.onSubmit,
    super.physics,
    super.scrollPadding,
    super.keyBoardType,
    this.onIconTap,
  });

  @override
  State<StatefulWidget> createState() => SuffixTextInputWidgetState();
}

class SuffixTextInputWidgetState
    extends TextInputWidgetBaseState<SuffixTextInputWidget> {
  @override
  Widget buildLabel(AppTheme theme) {
    return Text(
      widget.label,
      style: AppTypoGraPhy.body.copyWith(color: theme.neutralColor6),
    );
  }

  @override
  Widget inputFormBuilder(BuildContext context, Widget child, AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel(theme),
        const SizedBox(
          height: 12,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.neutralColor22,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: child,
              ),
              const SizedBox(
                width: 12,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: widget.onIconTap,
                child: widget.suffix,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NormalTextInputWidget extends TextInputWidgetBase {
  final String label;

  const NormalTextInputWidget({
    required this.label,
    super.key,
    super.controller,
    super.autoFocus,
    super.constraintManager,
    super.enable,
    super.focusNode,
    super.hintText,
    super.inputFormatter,
    super.maxLength,
    super.maxLine,
    super.minLine,
    super.onChanged,
    super.scrollController,
    super.onSubmit,
    super.physics,
    super.scrollPadding,
    super.keyBoardType,
  });

  @override
  State<StatefulWidget> createState() => NormalTextInputWidgetState();
}

class NormalTextInputWidgetState
    extends TextInputWidgetBaseState<NormalTextInputWidget> {
  @override
  Widget buildLabel(AppTheme theme) {
    return Text(
      widget.label,
      style: AppTypoGraPhy.body.copyWith(color: theme.neutralColor6),
    );
  }
}
