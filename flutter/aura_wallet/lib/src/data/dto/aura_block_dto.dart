import 'package:aura_wallet/src/domain/entities/aura_block.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aura_block_dto.g.dart';

extension AuraBlockBodyMapper on AuraBlockBodyDto {
  AuraBlockBody get toEntities => AuraBlockBody();
}

extension AuraBlockHeaderMapper on AuraBlockHeaderDto {
  AuraBlockHeader get toEntities => AuraBlockHeader(
        chainId: chainId,
        height: height,
        time: time,
      );
}

extension AuraBlockMapper on AuraBlockDto {
  AuraBlock get toEntities => AuraBlock(
        header: header.toEntities,
        data: data.toEntities,
      );
}

extension AuraBlockDataMapper on AuraBlockDataDto {
  AuraBlockData get toEntities => AuraBlockData(
        id: id,
        block: block.toEntities,
        validatorName: validatorName,
        operatorAddress: operatorAddress,
      );
}

@JsonSerializable()
class AuraBlockDataDto {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'validator_name')
  final String validatorName;
  @JsonKey(name: 'operator_address')
  final String operatorAddress;
  @JsonKey(name: 'block')
  final AuraBlockDto block;

  const AuraBlockDataDto({
    required this.id,
    required this.block,
    required this.validatorName,
    required this.operatorAddress,
  });

  factory AuraBlockDataDto.fromJson(Map<String, dynamic> json) =>
      _$AuraBlockDataDtoFromJson(json);
}

@JsonSerializable()
class AuraBlockDto {
  @JsonKey(name: 'data')
  final AuraBlockBodyDto data;
  @JsonKey(name: 'header')
  final AuraBlockHeaderDto header;

  const AuraBlockDto({
    required this.header,
    required this.data,
  });

  factory AuraBlockDto.fromJson(Map<String, dynamic> json) =>
      _$AuraBlockDtoFromJson(json);
}

@JsonSerializable()
class AuraBlockHeaderDto {
  @JsonKey(name: 'chain_id')
  final String chainId;
  @JsonKey(name: 'height')
  final int height;
  @JsonKey(name: 'time')
  final String time;

  const AuraBlockHeaderDto({
    required this.chainId,
    required this.height,
    required this.time,
  });

  factory AuraBlockHeaderDto.fromJson(Map<String, dynamic> json) =>
      _$AuraBlockHeaderDtoFromJson(json);
}

@JsonSerializable()
class AuraBlockBodyDto {
  const AuraBlockBodyDto();

  factory AuraBlockBodyDto.fromJson(Map<String, dynamic> json) {
    return _$AuraBlockBodyDtoFromJson(json);
  }
}
