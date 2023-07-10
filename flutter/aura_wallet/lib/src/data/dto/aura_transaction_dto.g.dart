// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aura_transaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuraTransactionDto _$AuraTransactionDtoFromJson(Map<String, dynamic> json) =>
    AuraTransactionDto(
      id: json['_id'] as String,
      txData:
          AuraTxDataDto.fromJson(json['tx_response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuraTransactionDtoToJson(AuraTransactionDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'tx_response': instance.txData,
    };

AuraTxDataDto _$AuraTxDataDtoFromJson(Map<String, dynamic> json) =>
    AuraTxDataDto(
      height: (json['height'] as num).toDouble(),
      timeStamp: json['timestamp'] as String,
      code: json['code'] as String,
      txHash: json['txhash'] as String,
      tx: AuraTxDto.fromJson(json['tx'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuraTxDataDtoToJson(AuraTxDataDto instance) =>
    <String, dynamic>{
      'height': instance.height,
      'txhash': instance.txHash,
      'code': instance.code,
      'timestamp': instance.timeStamp,
      'tx': instance.tx,
    };

AuraTxDto _$AuraTxDtoFromJson(Map<String, dynamic> json) => AuraTxDto(
      body: AuraTxBodyDto.fromJson(json['body'] as Map<String, dynamic>),
      authInfo:
          AuraTxAuthInfoDto.fromJson(json['auth_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuraTxDtoToJson(AuraTxDto instance) => <String, dynamic>{
      'body': instance.body,
      'auth_info': instance.authInfo,
    };

AuraTxBodyDto _$AuraTxBodyDtoFromJson(Map<String, dynamic> json) =>
    AuraTxBodyDto(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => AuraTxMessageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      memo: json['memo'] as String,
    );

Map<String, dynamic> _$AuraTxBodyDtoToJson(AuraTxBodyDto instance) =>
    <String, dynamic>{
      'memo': instance.memo,
      'messages': instance.messages,
    };

AuraTxMessageDto _$AuraTxMessageDtoFromJson(Map<String, dynamic> json) =>
    AuraTxMessageDto(
      type: json['@type'] as String,
      grantee: json['grantee'] as String?,
      amount: (json['amount'] as List<dynamic>?)
          ?.map((e) => AuraTxAmountDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuraTxMessageDtoToJson(AuraTxMessageDto instance) =>
    <String, dynamic>{
      '@type': instance.type,
      'grantee': instance.grantee,
      'amount': instance.amount,
    };

AuraTxAmountDto _$AuraTxAmountDtoFromJson(Map<String, dynamic> json) =>
    AuraTxAmountDto(
      amount: json['amount'] as String,
      deNom: json['denom'] as String,
    );

Map<String, dynamic> _$AuraTxAmountDtoToJson(AuraTxAmountDto instance) =>
    <String, dynamic>{
      'denom': instance.deNom,
      'amount': instance.amount,
    };

AuraTxAuthInfoDto _$AuraTxAuthInfoDtoFromJson(Map<String, dynamic> json) =>
    AuraTxAuthInfoDto(
      fee: AuraTxAuthInfoFeeDto.fromJson(json['fee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuraTxAuthInfoDtoToJson(AuraTxAuthInfoDto instance) =>
    <String, dynamic>{
      'fee': instance.fee,
    };

AuraTxAuthInfoFeeDto _$AuraTxAuthInfoFeeDtoFromJson(
        Map<String, dynamic> json) =>
    AuraTxAuthInfoFeeDto(
      amounts: (json['amount'] as List<dynamic>)
          .map((e) => AuraTxAmountDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuraTxAuthInfoFeeDtoToJson(
        AuraTxAuthInfoFeeDto instance) =>
    <String, dynamic>{
      'amount': instance.amounts,
    };
