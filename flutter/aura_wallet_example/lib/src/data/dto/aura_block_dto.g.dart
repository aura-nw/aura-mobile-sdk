// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aura_block_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuraBlockDataDto _$AuraBlockDataDtoFromJson(Map<String, dynamic> json) =>
    AuraBlockDataDto(
      id: json['_id'] as String,
      block: AuraBlockDto.fromJson(json['block'] as Map<String, dynamic>),
      validatorName: json['validator_name'] as String,
      operatorAddress: json['operator_address'] as String,
    );

Map<String, dynamic> _$AuraBlockDataDtoToJson(AuraBlockDataDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'validator_name': instance.validatorName,
      'operator_address': instance.operatorAddress,
      'block': instance.block,
    };

AuraBlockDto _$AuraBlockDtoFromJson(Map<String, dynamic> json) => AuraBlockDto(
      header:
          AuraBlockHeaderDto.fromJson(json['header'] as Map<String, dynamic>),
      data: AuraBlockBodyDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuraBlockDtoToJson(AuraBlockDto instance) =>
    <String, dynamic>{
      'data': instance.data,
      'header': instance.header,
    };

AuraBlockHeaderDto _$AuraBlockHeaderDtoFromJson(Map<String, dynamic> json) =>
    AuraBlockHeaderDto(
      chainId: json['chain_id'] as String,
      height: json['height'] as int,
      time: json['time'] as String,
    );

Map<String, dynamic> _$AuraBlockHeaderDtoToJson(AuraBlockHeaderDto instance) =>
    <String, dynamic>{
      'chain_id': instance.chainId,
      'height': instance.height,
      'time': instance.time,
    };

AuraBlockBodyDto _$AuraBlockBodyDtoFromJson(Map<String, dynamic> json) =>
    AuraBlockBodyDto();

Map<String, dynamic> _$AuraBlockBodyDtoToJson(AuraBlockBodyDto instance) =>
    <String, dynamic>{};
