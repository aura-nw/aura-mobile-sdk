import 'package:aura_sdk/aura_sdk.dart';
import 'package:aura_wallet_example/src/application/wrappers/app_global_state/app_global_cubit.dart';
import 'package:aura_wallet_example/src/application/wrappers/app_global_state/app_global_state.dart';
import 'package:aura_wallet_example/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:aura_wallet_example/src/application/wrappers/localization/localization_manager.dart';
import 'package:aura_wallet_example/src/core/constants/language_key.dart';
import 'package:aura_wallet_example/src/core/screen_loader_mixin.dart';
import 'package:aura_wallet_example/src/core/typography.dart';
import 'package:aura_wallet_example/src/core/utils/context_extension.dart';
import 'package:aura_wallet_example/src/core/utils/dart_core_extension.dart';
import 'package:aura_wallet_example/src/presentation/widgets/app_bar_widget.dart';
import 'package:aura_wallet_example/src/presentation/widgets/app_button.dart';
import 'package:aura_wallet_example/src/presentation/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';

class ImportWalletScreen extends StatefulWidget {
  const ImportWalletScreen({Key? key}) : super(key: key);

  @override
  State<ImportWalletScreen> createState() => _ImportWalletScreenState();
}

class _ImportWalletScreenState extends State<ImportWalletScreen>
    with ScreenLoaderMixin {
  final AppLocalizationManager _language = AppLocalizationManager.instance;

  final TextEditingController _passPhraseController = TextEditingController();

  bool isDisable = true;

  String? error;

  late AppGlobalCubit _appGlobalCubit;

  @override
  void dispose() {
    _passPhraseController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appGlobalCubit = AppGlobalCubit.of(context);
  }

  @override
  Widget builder(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return Scaffold(
          backgroundColor: theme.darkColor,
          appBar: PrimaryAppBar(
            title: _language.translate(LanguageKey.importWalletAppbarTitle),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: context.w,
              height: context.bodyHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    NormalTextInputWidget(
                      label: _language.translate(
                        LanguageKey.importWalletSeedPhrase,
                      ),
                      controller: _passPhraseController,
                      hintText: _language
                          .translate(LanguageKey.importWalletHintSeedPhrase),
                      onChanged: (value, isValid) {
                        isDisable = _passPhraseController.text.isEmpty;
                        setState(() {});
                      },
                      onSubmit: (value, isValid) {
                        if (value.isNotEmpty) {
                          _onSubmit();
                        }
                      },
                    ),
                    if (error.isNotNullOrEmpty) ...[
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        error!,
                        style: AppTypoGraPhy.body1.copyWith(
                          color: theme.basicColorRed5,
                        ),
                      ),
                    ],
                    const Spacer(),
                    InactiveGradientButton(
                      text: _language
                          .translate(LanguageKey.importWalletButtonImport),
                      onPress: _onSubmit,
                      disabled: isDisable,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onSubmit() async {
    showLoading();
    error = null;
    setState(() {});
    try {
      final wallet = await AuraSDK.instance.inAppWallet.restoreHDWallet(
        key: _passPhraseController.text.trim(),
      );

      _appGlobalCubit.changeState(
        AppGlobalState(
          status: AppGlobalStatus.authorized,
          auraWallet: wallet,
        ),
      );
    } catch (e) {
      error = e.toString();
      setState(() {});
    } finally {
      hideLoading();
    }
  }
}
