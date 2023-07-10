import 'package:aura_wallet/src/domain/entities/aura_wallet_balance.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aura_wallet_balance_dto.g.dart';

extension AuraWalletBalanceDataMapper on AuraWalletBalanceDataDto {
  AuraWalletBalanceData get toEntities => AuraWalletBalanceData(
        balances: balances.map((e) => e.toEntities).toList(),
      );
}

extension AuraWalletBalanceMapper on AuraWalletBalanceDto {
  AuraWalletBalance get toEntities => AuraWalletBalance(
        id: id,
        amount: amount,
        deNom: deNom,
      );
}

@JsonSerializable()
class AuraWalletBalanceDataDto {
  @JsonKey(name: 'account_balances')
  final List<AuraWalletBalanceDto> balances;

  const AuraWalletBalanceDataDto({required this.balances});

  factory AuraWalletBalanceDataDto.fromJson(Map<String, dynamic> json) =>
      _$AuraWalletBalanceDataDtoFromJson(json);
}

@JsonSerializable()
class AuraWalletBalanceDto {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'denom')
  final String deNom;
  @JsonKey(name: 'amount')
  final String amount;

  const AuraWalletBalanceDto(
      {required this.id, required this.amount, required this.deNom});

  factory AuraWalletBalanceDto.fromJson(Map<String, dynamic> json) =>
      _$AuraWalletBalanceDtoFromJson(json);
}
