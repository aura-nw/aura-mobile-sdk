import 'package:aura_wallet/app_configs/di.dart';
import 'package:aura_wallet/src/application/wrappers/app_global_state/app_global_cubit.dart';
import 'package:aura_wallet/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:aura_wallet/src/application/wrappers/localization/localization_manager.dart';
import 'package:aura_wallet/src/aura_navigator.dart';
import 'package:aura_wallet/src/core/constants/language_key.dart';
import 'package:aura_wallet/src/core/screen_loader_mixin.dart';
import 'package:aura_wallet/src/core/typography.dart';
import 'package:aura_wallet/src/presentation/screens/send_transaction/widgets/fee_slider_widget.dart';
import 'package:aura_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:aura_wallet/src/presentation/widgets/app_button.dart';
import 'package:aura_wallet/src/presentation/widgets/app_dialog_provider/app_dialog_base_widget.dart';
import 'package:aura_wallet/src/presentation/widgets/text_input_base/text_input_manager.dart';
import 'package:aura_wallet/src/presentation/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'send_transaction_bloc.dart';
import 'send_transaction_state.dart';
import 'send_transaction_event.dart';
import 'send_transaction_selector.dart';

class SendTransactionScreen extends StatefulWidget {
  const SendTransactionScreen({Key? key}) : super(key: key);

  @override
  State<SendTransactionScreen> createState() => _SendTransactionScreenState();
}

class _SendTransactionScreenState extends State<SendTransactionScreen>
    with ScreenLoaderMixin {
  bool isSuccess = false;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _receiveAddressController =
      TextEditingController();
  final TextEditingController _memoController = TextEditingController();

  final AppLocalizationManager _language = AppLocalizationManager.instance;

  final SendTransactionBloc _bloc = getIt.get<SendTransactionBloc>();

  @override
  void dispose() {
    _amountController.dispose();
    _receiveAddressController.dispose();
    _memoController.dispose();
    super.dispose();
  }


  @override
  Widget builder(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return BlocProvider.value(
          value: _bloc,
          child: BlocListener<SendTransactionBloc, SendTransactionState>(
            bloc: _bloc,
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              switch (state.status) {
                case SendTransactionStatus.none:
                  break;
                case SendTransactionStatus.starting:
                  showLoading();
                  break;
                case SendTransactionStatus.success:
                  isSuccess = true;
                  hideLoading();
                  DialogProvider.shared.showMessageDialog(
                    context: context,
                    message: _language.translate(
                      LanguageKey.sendTransactionSuccessDefault,
                    ),
                    title: _language.translate(
                      LanguageKey.sendTransactionSuccessTitle,
                    ),
                  );
                  break;
                case SendTransactionStatus.error:
                  hideLoading();
                  DialogProvider.shared.showMessageDialog(
                    context: context,
                    message: state.error ?? _language.translate(
                      LanguageKey.sendTransactionErrorDefault,
                    ),
                    title: _language.translate(
                      LanguageKey.sendTransactionErrorTitle,
                    ),
                  );
                  break;
              }
            },
            child: WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                backgroundColor: theme.darkColor,
                appBar: PrimaryAppBar(
                  title: _language.translate(
                    LanguageKey.sendTransactionAppBarTitle,
                  ),
                  onBack: () => AppNavigator.pop(isSuccess),
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
                          padding: EdgeInsets.zero,
                          children: [
                            SuffixTextInputWidget(
                              controller: _amountController,
                              label: _language.translate(
                                LanguageKey.sendTransactionAmount,
                              ),
                              constraintManager: ConstraintManager()
                                ..notEmpty(
                                  errorMessage: _language.translateWithParam(
                                    LanguageKey.sendTransactionEmptyErrorMessage,
                                    {
                                      'title': _language.translate(
                                        LanguageKey.sendTransactionAmount,
                                      ),
                                    },
                                  ),
                                )
                                ..isNumber(
                                  errorMessage: _language.translate(
                                    LanguageKey.sendTransactionAmountValidMessage,
                                  ),
                                ),
                              onChanged: (value, isValid) {
                                if (isValid) {
                                  _bloc.add(
                                    SendTransactionOnAmountChangeEvent(
                                      amount: int.tryParse(value) ?? 0,
                                    ),
                                  );
                                }
                              },
                              keyBoardType: TextInputType.number,
                              hintText: _language.translate('100'),
                              suffix: Text(
                                _language.translate('UAURA'),
                                style: AppTypoGraPhy.caption14.copyWith(
                                  color: theme.lightColor,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SuffixTextInputWidget(
                              constraintManager: ConstraintManager().notEmpty(
                                errorMessage: _language.translateWithParam(
                                  LanguageKey.sendTransactionEmptyErrorMessage,
                                  {
                                    'title': _language.translate(
                                      LanguageKey.sendTransactionReceiveAddress,
                                    ),
                                  },
                                ),
                              ),
                              controller: _receiveAddressController,
                              label: _language.translate(
                                  LanguageKey.sendTransactionReceiveAddress),
                              suffix: Icon(
                                Icons.qr_code,
                                color: theme.primaryColor6,
                              ),
                              onChanged: (value, isValid) {
                                if (isValid) {
                                  _bloc.add(
                                    SendTransactionOnAddressChangeEvent(
                                      address: value,
                                    ),
                                  );
                                }
                              },
                              onIconTap: () async {
                                final address =
                                    await AppNavigator.push(AppRoutes.scanQR);

                                if (address is String) {
                                  _bloc.add(
                                    SendTransactionOnAddressChangeEvent(
                                      address: address,
                                    ),
                                  );

                                  _receiveAddressController.text = address;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            NormalTextInputWidget(
                              label: _language.translate(
                                LanguageKey.sendTransactionMemo,
                              ),
                              controller: _memoController,
                              onChanged: (value, isValid) {
                                _bloc.add(
                                  SendTransactionOnMemoChangeEvent(
                                    memo: value,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            FeeSliderWidget(
                              onChange: (fee) {
                                _bloc.add(
                                  SendTransactionOnFeeChangeEvent(
                                    fee: fee.toInt(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SendTransactionIsReadySubmitSelector(
                        builder: (isReady) => InactiveGradientButton(
                          text: _language.translate(
                            LanguageKey.sendTransactionButtonSendTransaction,
                          ),
                          disabled: !isReady,
                          onPress: () async {
                            final auraWallet = AppGlobalCubit.of(context).state.auraWallet!;
                            _bloc.add(
                              SendTransactionSubmitEvent(
                                auraWallet: auraWallet,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
