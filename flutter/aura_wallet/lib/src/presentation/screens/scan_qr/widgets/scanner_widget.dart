import 'package:aura_wallet/src/application/wrappers/app_theme/app_theme.dart';
import 'package:aura_wallet/src/core/utils/context_extension.dart';
import 'package:flutter/material.dart';

class ScannerWidget extends StatefulWidget {
  final Widget child;
  final AppTheme theme;

  const ScannerWidget({
    Key? key,
    required this.child,
    required this.theme,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ScannerWidgetState();
  }
}

class ScannerWidgetState extends State<ScannerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animateScanAnimation(true);
      } else if (status == AnimationStatus.dismissed) {
        animateScanAnimation(false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            child: SizedBox(
              width: context.w * 5 / 7,
              height: context.h * 2 / 5,
              child: widget.child,
            ),
          ),
        ),
        ScannerAnimation(
          widget.theme,
          false,
          context.w * 5 / 7,
          animation: _animationController,
        )
      ],
    );
  }

  void animateScanAnimation(bool reverse) {
    if (reverse) {
      _animationController.reverse(from: 1.0);
    } else {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class ScannerAnimation extends AnimatedWidget {
  final bool stopped;
  final double width;
  final AppTheme theme;

  const ScannerAnimation(
    this.theme,
    this.stopped,
    this.width, {
    Key? key,
    required Animation<double> animation,
  }) : super(
          key: key,
          listenable: animation,
        );

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final scorePosition = (animation.value * context.h * 2 / 5);

    Color color1 = theme.primaryColor6.withOpacity(0.21);
    Color color2 = theme.primaryColor8.withOpacity(0.0);

    if (animation.status == AnimationStatus.reverse) {
      color1 = theme.primaryColor8.withOpacity(0.0);
      color2 = theme.primaryColor6.withOpacity(0.21);
    }

    return Positioned(
      bottom: scorePosition,
      child: Opacity(
        opacity: (stopped) ? 0.0 : 1.0,
        child: Container(
          height: 80.0,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.1, 0.9],
              colors: [color1, color2],
            ),
          ),
        ),
      ),
    );
  }
}
