// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aura_wallet_balance_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuraWalletBalanceDataDto _$AuraWalletBalanceDataDtoFromJson(
        Map<String, dynamic> json) =>
    AuraWalletBalanceDataDto(
      balances: (json['account_balances'] as List<dynamic>)
          .map((e) => AuraWalletBalanceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuraWalletBalanceDataDtoToJson(
        AuraWalletBalanceDataDto instance) =>
    <String, dynamic>{
      'account_balances': instance.balances,
    };

AuraWalletBalanceDto _$AuraWalletBalanceDtoFromJson(
        Map<String, dynamic> json) =>
    AuraWalletBalanceDto(
      id: json['_id'] as String,
      amount: json['amount'] as String,
      deNom: json['denom'] as String,
    );

Map<String, dynamic> _$AuraWalletBalanceDtoToJson(
        AuraWalletBalanceDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'denom': instance.deNom,
      'amount': instance.amount,
    };
