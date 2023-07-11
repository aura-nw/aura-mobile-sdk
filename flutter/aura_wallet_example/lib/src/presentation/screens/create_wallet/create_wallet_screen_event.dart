import 'package:freezed_annotation/freezed_annotation.dart';
part 'create_wallet_screen_event.freezed.dart';

@freezed
class CreateWalletScreenEvent with _$CreateWalletScreenEvent{
  const factory CreateWalletScreenEvent.start() = CreateWalletScreenStartEvent;
}