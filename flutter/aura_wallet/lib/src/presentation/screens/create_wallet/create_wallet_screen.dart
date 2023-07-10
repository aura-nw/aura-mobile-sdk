import 'package:aura_wallet/app_configs/di.dart';
import 'package:aura_wallet/src/application/wrappers/app_global_state/app_global_cubit.dart';
import 'package:aura_wallet/src/application/wrappers/app_global_state/app_global_state.dart';
import 'package:aura_wallet/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:aura_wallet/src/application/wrappers/localization/localization_manager.dart';
import 'package:aura_wallet/src/core/constants/language_key.dart';
import 'create_wallet_screen_bloc.dart';
import 'create_wallet_screen_event.dart';
import 'create_wallet_screen_selector.dart';
import 'create_wallet_screen_state.dart';
import 'package:aura_wallet/src/presentation/widgets/app_bar_widget.dart';
import 'package:aura_wallet/src/presentation/widgets/app_button.dart';
import 'package:aura_wallet/src/presentation/widgets/circular_loading_widget.dart';
import 'package:aura_wallet/src/presentation/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateWalletScreen extends StatefulWidget {
  const CreateWalletScreen({Key? key}) : super(key: key);

  @override
  State<CreateWalletScreen> createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {
  final AppLocalizationManager _language = AppLocalizationManager.instance;

  final TextEditingController _passPhraseController = TextEditingController();
  final TextEditingController _privateKeyPhraseController =
      TextEditingController();
  final TextEditingController _addressPhraseController =
      TextEditingController();

  final CreateWalletScreenBloc _bloc = getIt.get<CreateWalletScreenBloc>();

  late AppGlobalCubit _appGlobalCubit;

  @override
  void initState() {
    super.initState();
    _bloc.add(const CreateWalletScreenStartEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appGlobalCubit = AppGlobalCubit.of(context);
  }

  @override
  void dispose() {
    _passPhraseController.dispose();
    _privateKeyPhraseController.dispose();
    _addressPhraseController.dispose();
    super.dispose();
  }

  void copy(String text) async {
    await Clipboard.setData(
      ClipboardData(text: text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return BlocProvider.value(
          value: _bloc,
          child: BlocListener<CreateWalletScreenBloc, CreateWalletScreenState>(
            listenWhen: (previous, current) =>
                current.status != previous.status,
            listener: (_, state) {
              _passPhraseController.text =
                  state.auraFullInfoWallet?.mnemonic ?? '';
              _privateKeyPhraseController.text =
                  state.auraFullInfoWallet?.privateKey ?? '';
              _addressPhraseController.text =
                  state.auraFullInfoWallet?.auraWallet.wallet.bech32Address ??
                      '';
            },
            child: Scaffold(
              backgroundColor: theme.darkColor,
              appBar: PrimaryAppBar(
                title: _language.translate(
                  LanguageKey.createWalletAppbarTitle,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 40,
                ),
                child: CreateWalletScreenStatusSelector(builder: (status) {
                  switch (status) {
                    case CreateWalletScreenStatus.loading:
                      return const Center(
                        child: CircularLoadingWidget(),
                      );
                    case CreateWalletScreenStatus.loaded:
                      return Column(
                        children: [
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                SuffixTextInputWidget(
                                  label: _language.translate(
                                      LanguageKey.createWalletSeedPhrase),
                                  suffix: Icon(
                                    Icons.copy,
                                    color: theme.primaryColor5,
                                  ),
                                  controller: _passPhraseController,
                                  enable: false,
                                  onIconTap: () {
                                    copy(_passPhraseController.text);
                                  },
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SuffixTextInputWidget(
                                  label: _language.translate(
                                      LanguageKey.createWalletAddress),
                                  suffix: Icon(
                                    Icons.copy,
                                    color: theme.primaryColor5,
                                  ),
                                  controller: _addressPhraseController,
                                  enable: false,
                                  onIconTap: () {
                                    copy(_addressPhraseController.text);
                                  },
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SuffixTextInputWidget(
                                  label: _language.translate(
                                      LanguageKey.createWalletPrivateKey),
                                  suffix: Icon(
                                    Icons.copy,
                                    color: theme.primaryColor5,
                                  ),
                                  controller: _privateKeyPhraseController,
                                  enable: false,
                                  onIconTap: () {
                                    copy(_privateKeyPhraseController.text);
                                  },
                                ),
                              ],
                            ),
                          ),
                          CreateWalletScreenWalletSelector(
                            builder: (walletFullInfo) {
                              return InactiveGradientButton(
                                text: _language
                                    .translate(LanguageKey.createWalletButtonStart),
                                disabled: walletFullInfo == null,
                                onPress: () {
                                  _appGlobalCubit.changeState(
                                    AppGlobalState(
                                      status: AppGlobalStatus.authorized,
                                      auraWallet: walletFullInfo!.auraWallet,
                                    ),
                                  );
                                },
                              );
                            }
                          ),
                        ],
                      );
                  }
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
