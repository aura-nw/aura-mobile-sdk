import 'package:aura_wallet/src/domain/entities/aura_transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aura_transaction_dto.g.dart';

extension AuraTxAmountMapper on AuraTxAmountDto {
  AuraTxAmount get toEntities => AuraTxAmount(
        amount: amount,
        deNom: deNom,
      );
}

extension AuraTxAuthInfoMapper on AuraTxAuthInfoDto {
  AuraTxAuthInfo get toEntities => AuraTxAuthInfo(
        fee: fee.toEntities,
      );
}

extension AuraTxAuthInfoFeeMapper on AuraTxAuthInfoFeeDto {
  AuraTxAuthInfoFee get toEntities => AuraTxAuthInfoFee(
        amounts: amounts.map((e) => e.toEntities).toList(),
      );
}

extension AuraTxMessageMapper on AuraTxMessageDto {
  AuraTxMessage get toEntities => AuraTxMessage(
        type: type,
        grantee: grantee,
        amount: amount?.map((e) => e.toEntities).toList(),
      );
}

extension AuraTxBodyMapper on AuraTxBodyDto {
  AuraTxBody get toEntities => AuraTxBody(
        messages: messages.map((e) => e.toEntities).toList(),
        memo: memo,
      );
}

extension AuraTxMapper on AuraTxDto {
  AuraTx get toEntities => AuraTx(
        body: body.toEntities,
        authInfo: authInfo.toEntities,
      );
}

extension AuraTxDataMapper on AuraTxDataDto {
  AuraTxData get toEntities => AuraTxData(
        height: height,
        timeStamp: timeStamp,
        code: code,
        txHash: txHash,
        tx: tx.toEntities,
      );
}

extension AuraTransactionMapper on AuraTransactionDto {
  AuraTransaction get toEntities => AuraTransaction(
        id: id,
        txData: txData.toEntities,
      );
}

@JsonSerializable()
class AuraTransactionDto {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'tx_response')
  final AuraTxDataDto txData;

  const AuraTransactionDto({required this.id, required this.txData});

  factory AuraTransactionDto.fromJson(Map<String, dynamic> json) =>
      _$AuraTransactionDtoFromJson(json);
}

@JsonSerializable()
class AuraTxDataDto {
  @JsonKey(name: 'height')
  final double height;
  @JsonKey(name: 'txhash')
  final String txHash;
  @JsonKey(name: 'code')
  final String code;
  @JsonKey(name: 'timestamp')
  final String timeStamp;
  @JsonKey(name: 'tx')
  final AuraTxDto tx;

  const AuraTxDataDto({
    required this.height,
    required this.timeStamp,
    required this.code,
    required this.txHash,
    required this.tx,
  });

  factory AuraTxDataDto.fromJson(Map<String, dynamic> json) =>
      _$AuraTxDataDtoFromJson(json);
}

@JsonSerializable()
class AuraTxDto {
  @JsonKey(name: 'body')
  final AuraTxBodyDto body;
  @JsonKey(name: 'auth_info')
  final AuraTxAuthInfoDto authInfo;

  const AuraTxDto({
    required this.body,
    required this.authInfo,
  });

  factory AuraTxDto.fromJson(Map<String, dynamic> json) =>
      _$AuraTxDtoFromJson(json);
}

@JsonSerializable()
class AuraTxBodyDto {
  @JsonKey(name: 'memo')
  final String memo;
  @JsonKey(name: 'messages')
  final List<AuraTxMessageDto> messages;

  const AuraTxBodyDto({required this.messages, required this.memo});

  factory AuraTxBodyDto.fromJson(Map<String, dynamic> json) =>
      _$AuraTxBodyDtoFromJson(json);
}

@JsonSerializable()
class AuraTxMessageDto {
  @JsonKey(name: '@type')
  final String type;
  @JsonKey(name: 'grantee')
  final String? grantee;
  @JsonKey(name: 'amount')
  final List<AuraTxAmountDto>? amount;

  const AuraTxMessageDto({
    required this.type,
    this.grantee,
    this.amount,
  });

  factory AuraTxMessageDto.fromJson(Map<String, dynamic> json) =>
      _$AuraTxMessageDtoFromJson(json);
}

@JsonSerializable()
class AuraTxAmountDto {
  @JsonKey(name: 'denom')
  final String deNom;
  @JsonKey(name: 'amount')
  final String amount;

  const AuraTxAmountDto({
    required this.amount,
    required this.deNom,
  });

  factory AuraTxAmountDto.fromJson(Map<String, dynamic> json) =>
      _$AuraTxAmountDtoFromJson(json);
}

@JsonSerializable()
class AuraTxAuthInfoDto {
  @JsonKey(name: 'fee')
  final AuraTxAuthInfoFeeDto fee;

  const AuraTxAuthInfoDto({required this.fee});

  factory AuraTxAuthInfoDto.fromJson(Map<String, dynamic> json) =>
      _$AuraTxAuthInfoDtoFromJson(json);
}

@JsonSerializable()
class AuraTxAuthInfoFeeDto {
  @JsonKey(name: 'amount')
  final List<AuraTxAmountDto> amounts;

  const AuraTxAuthInfoFeeDto({
    required this.amounts,
  });

  factory AuraTxAuthInfoFeeDto.fromJson(Map<String, dynamic> json) =>
      _$AuraTxAuthInfoFeeDtoFromJson(json);
}
