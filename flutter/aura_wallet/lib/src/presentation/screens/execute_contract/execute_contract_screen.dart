import 'dart:convert';

import 'package:aura_wallet/src/application/wrappers/app_global_state/app_global_cubit.dart';
import 'package:aura_wallet/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:aura_wallet/src/application/wrappers/localization/localization_manager.dart';
import 'package:aura_wallet/src/core/constants/language_key.dart';
import 'package:aura_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:aura_wallet/src/presentation/widgets/app_button.dart';
import 'package:aura_wallet/src/presentation/widgets/app_dialog_provider/app_dialog_base_widget.dart';
import 'package:aura_wallet/src/presentation/widgets/text_input_base/text_input_manager.dart';
import 'package:aura_wallet/src/presentation/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';

class ExecuteContractScreen extends StatefulWidget {
  const ExecuteContractScreen({Key? key}) : super(key: key);

  @override
  State<ExecuteContractScreen> createState() => _ExecuteContractScreenState();
}

class _ExecuteContractScreenState extends State<ExecuteContractScreen> {
  final AppLocalizationManager _language = AppLocalizationManager.instance;

  final TextEditingController _contractAddressController =
      TextEditingController();
  final TextEditingController _executeMessageController =
      TextEditingController();
  final GlobalKey<NormalTextInputWidgetState> _addressKey = GlobalKey();
  final GlobalKey<NormalTextInputWidgetState> _executeMessageKey = GlobalKey();

  bool isValidAddress = false;
  bool isValidMessage = false;

  @override
  void dispose() {
    _contractAddressController.dispose();
    _executeMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: theme.darkColor,
            appBar: PrimaryAppBar(
              title: _language.translate(
                LanguageKey.executeContractAppBarTitle,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 40,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        NormalTextInputWidget(
                          key: _addressKey,
                          label: _language.translate(
                            LanguageKey.executeContractContractAddress,
                          ),
                          controller: _contractAddressController,
                          onChanged: (value, isValid) {
                            isValidAddress = isValid;
                            setState(() {});
                          },
                          constraintManager: ConstraintManager().notEmpty(
                            errorMessage: _language.translateWithParam(
                              LanguageKey.executeContractEmptyErrorMessage,
                              {
                                'title': _language.translate(
                                  LanguageKey.executeContractContractAddress,
                                ),
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        NormalTextInputWidget(
                          key: _executeMessageKey,
                          label: _language.translate(
                            LanguageKey.executeContractExecuteMessage,
                          ),
                          controller: _executeMessageController,
                          onChanged: (value, isValid) {
                            isValidMessage = isValid;
                            setState(() {});
                          },
                          constraintManager: ConstraintManager()
                            ..notEmpty(
                              errorMessage: _language.translateWithParam(
                                LanguageKey.executeContractEmptyErrorMessage,
                                {
                                  'title': _language.translate(
                                    LanguageKey.executeContractExecuteMessage,
                                  ),
                                },
                              ),
                            )
                            ..custom(
                              errorMessage: _language.translate(
                                LanguageKey.executeContractExecuteValidMessage,
                              ),
                              customValid: (source) {
                                try {
                                  jsonDecode(source);
                                  return true;
                                } catch (e) {
                                  return false;
                                }
                              },
                            ),
                        ),
                      ],
                    ),
                  ),
                  InactiveGradientButton(
                    text: _language
                        .translate(LanguageKey.executeContractButtonExecute),
                    disabled: !isValidAddress || !isValidMessage,
                    onPress: () async {
                      final isValid =
                          (_addressKey.currentState?.validate() ?? false) ||
                              (_executeMessageKey.currentState?.validate() ??
                                  false);

                      if (!isValid) return;

                      AppGlobalCubit.of(context)
                          .state
                          .auraWallet!
                          .makeInteractiveWriteSmartContract(
                            contractAddress:
                                _contractAddressController.text.trim(),
                            executeMessage: jsonDecode(
                              _executeMessageController.text.trim(),
                            ),
                          );
                      isValidMessage = false;
                      isValidAddress = false;

                      setState(() {});

                      _contractAddressController.text = '';
                      _executeMessageController.text = '';

                      DialogProvider.shared.showMessageDialog(
                        context: context,
                        message: _language.translate(
                          LanguageKey.executeContractMessage,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
