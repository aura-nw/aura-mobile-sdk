import 'package:aura_sdk/aura_sdk.dart' hide Duration;
import 'package:aura_wallet_example/app_configs/di.dart';
import 'package:aura_wallet_example/src/application/wrappers/app_global_state/app_global_cubit.dart';
import 'package:aura_wallet_example/src/application/wrappers/app_theme/app_theme_builder.dart';
import 'package:aura_wallet_example/src/application/wrappers/localization/localization_manager.dart';
import 'package:aura_wallet_example/src/aura_navigator.dart';
import 'package:aura_wallet_example/src/core/constants/asset_key.dart';
import 'package:aura_wallet_example/src/core/constants/language_key.dart';
import 'package:aura_wallet_example/src/core/typography.dart';
import 'package:aura_wallet_example/src/core/utils/context_extension.dart';
// import 'package:aura_wallet_example/src/presentation/screens/home/wallet/widgets/wallet_block_widget.dart';
import 'package:aura_wallet_example/src/presentation/screens/home/wallet/widgets/wallet_receive_widget.dart';
import 'package:aura_wallet_example/src/presentation/screens/home/wallet/widgets/wallet_transaction_widget.dart';
import 'package:aura_wallet_example/src/presentation/widgets/combine_list_view.dart';
import 'widgets/wallet_button_execute_widget.dart';
import 'package:aura_wallet_example/src/presentation/widgets/circular_loading_widget.dart';
import 'package:aura_wallet_example/src/presentation/widgets/gradient_text_widget.dart';
import 'package:aura_wallet_example/src/presentation/widgets/retry_execute_widget.dart';
import 'wallet_screen_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'wallet_screen_bloc.dart';
import 'wallet_screen_event.dart';
import 'wallet_screen_state.dart';
import 'package:aura_wallet_example/src/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final AppLocalizationManager _language = AppLocalizationManager.instance;

  final WalletScreenBloc _bloc = getIt.get<WalletScreenBloc>();

  late AuraWallet _auraWallet;

  late AnimationController _receiveWidgetController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _receiveWidgetController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 450,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _auraWallet = AppGlobalCubit.of(context).state.auraWallet!;
    _bloc.add(
      WalletScreenStartingEvent(_auraWallet),
    );

    _animation = Tween<double>(begin: -context.h, end: 0).animate(
      CurvedAnimation(
        parent: _receiveWidgetController,
        curve: Curves.easeOutSine,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppThemeBuilder(
      builder: (theme) {
        return Stack(
          children: [
            BlocProvider.value(
              value: _bloc,
              child: Scaffold(
                appBar: NormalAppBar(
                  title: _language.translate(
                    LanguageKey.homeWalletAppbar,
                  ),
                ),
                backgroundColor: theme.darkColor,
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 40,
                  ),
                  child: WalletScreenStatusSelector(
                    builder: (status) {
                      switch (status) {
                        case WalletScreenStatus.loading:
                          return const CircularLoadingWidget();
                        case WalletScreenStatus.loaded:
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: context.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    WalletScreenBalanceSelector(
                                      builder: (balance) {
                                        return GradientTextWidget(
                                          gradient: theme.gradient5,
                                          text: balance.toAura,
                                          style: AppTypoGraPhy.h4,
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    WalletScreenTokenInfoSelector(
                                      builder: (token) {
                                        if (token == null) {
                                          return const SizedBox();
                                        }
                                        return RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '\$${token.currentPrice}',
                                                style: AppTypoGraPhy.title2
                                                    .copyWith(
                                                  color: theme.lightColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const TextSpan(text: '  '),
                                              TextSpan(
                                                text:
                                                    '${token.priceChangePercentage24h < 0 ? '' : '+'}${token.priceChangePercentage24h.toStringAsFixed(2)}%',
                                                style: AppTypoGraPhy.title2
                                                    .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      token.priceChangePercentage24h <
                                                              0
                                                          ? theme.basicColorRed5
                                                          : theme
                                                              .basicColorGreen1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        WalletButtonExecuteWidget(
                                          theme: theme,
                                          title: _language.translate(
                                              LanguageKey.homeWalletButtonSent),
                                          icon: IconKey.iconSend,
                                          onTap: () async {
                                            final result =
                                                await AppNavigator.push(
                                              AppRoutes.sentTransaction,
                                            );
                                            if (result == true) {
                                              _bloc.add(
                                                WalletScreenRefreshBalanceEvent(
                                                  _auraWallet,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        WalletButtonExecuteWidget(
                                          theme: theme,
                                          title: _language.translate(LanguageKey
                                              .homeWalletButtonReceived),
                                          icon: IconKey.iconReceive,
                                          onTap: () {
                                            _receiveWidgetController.forward();
                                          },
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        WalletButtonExecuteWidget(
                                          theme: theme,
                                          title: _language.translate(
                                              LanguageKey.homeWalletTabContact),
                                          icon: IconKey.iconContract,
                                          onTap: () async {
                                            await AppNavigator.push(
                                                AppRoutes.contract);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _language.translate(
                                          LanguageKey.homeWalletTabTransaction),
                                      style: AppTypoGraPhy.title2.copyWith(
                                        color: theme.lightColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Expanded(
                                      child: WalletScreenTransactionsSelector(
                                        builder: (transactions) {
                                          if (transactions.isEmpty) {
                                            return Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'No data',
                                                style:
                                                    AppTypoGraPhy.body.copyWith(
                                                  color: theme.lightColor,
                                                ),
                                              ),
                                            );
                                          }
                                          return CombinedListView(
                                            onRefresh: (_) async => _bloc.add(
                                              WalletScreenRefreshTransactionEvent(
                                                _auraWallet
                                                    .wallet.bech32Address,
                                              ),
                                            ),
                                            onLoadMore: (_) {},
                                            data: transactions,
                                            builder: (transaction) {
                                              return WalletTransactionWidget(
                                                theme: theme,
                                                transaction: transaction,
                                              );
                                            },
                                            canLoadMore: false,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Expanded(
                              //   child: DefaultTabController(
                              //     length: 2,
                              //     child: Column(
                              //       children: [
                              //         TabBar(
                              //           indicatorColor: theme.lightColor,
                              //           labelStyle: AppTypoGraPhy.title2,
                              //           unselectedLabelColor:
                              //               theme.neutralColor12,
                              //           tabs: [
                              //             Tab(
                              //               text: _language.translate(
                              //                   LanguageKey
                              //                       .homeWalletTabTransaction),
                              //             ),
                              //             Tab(
                              //               text: _language.translate(
                              //                   LanguageKey.homeWalletTabBlock),
                              //             ),
                              //           ],
                              //         ),
                              //         const SizedBox(
                              //           height: 12,
                              //         ),
                              //         Expanded(
                              //           child: TabBarView(
                              //             children: [
                              //
                              //               WalletScreenBlocksSelector(
                              //                 builder: (blocks) {
                              //                   if (blocks.isEmpty) {
                              //                     return Align(
                              //                       alignment: Alignment.center,
                              //                       child: Text(
                              //                         'No data',
                              //                         style: AppTypoGraPhy.body
                              //                             .copyWith(
                              //                           color: theme.lightColor,
                              //                         ),
                              //                       ),
                              //                     );
                              //                   }
                              //                   return CombinedListView(
                              //                     onRefresh: (_) async =>
                              //                         _bloc.add(
                              //                       const WalletScreenRefreshBlockEvent(),
                              //                     ),
                              //                     onLoadMore: (_) {},
                              //                     data: blocks,
                              //                     builder: (block) {
                              //                       return WalletBlockWidget(
                              //                         theme: theme,
                              //                         blockData: block,
                              //                       );
                              //                     },
                              //                     canLoadMore: false,
                              //                   );
                              //                 },
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          );
                        case WalletScreenStatus.error:
                          return RetryExecuteWidget(
                            onRetry: () => _bloc.add(
                              WalletScreenStartingEvent(_auraWallet),
                            ),
                          );
                      }
                    },
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _receiveWidgetController,
              child: WalletReceiveWidget(
                address: _auraWallet.wallet.bech32Address,
                theme: theme,
                onSwipeUp: () async {
                  if (_receiveWidgetController.isCompleted) {
                    await _receiveWidgetController.reverse();

                    _receiveWidgetController.reset();
                  }
                },
              ),
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value),
                  child: child ?? const SizedBox(),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
