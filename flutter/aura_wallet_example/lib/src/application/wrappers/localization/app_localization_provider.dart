import 'localization_manager.dart';
import 'package:flutter/material.dart';

class AppLocalizationProvider extends StatelessWidget {
  final Widget Function(AppLocalizationManager,BuildContext) builder;
  const AppLocalizationProvider({required this.builder,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(AppLocalizationManager.of(context),context);
  }
}
