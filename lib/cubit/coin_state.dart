import 'package:coinmerce/models/coin_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'coin_state.freezed.dart';

@freezed
class CoinState with _$CoinState {
  const CoinState._();

  const factory CoinState.initial() = Init;

  const factory CoinState.loading() = Loading;

  const factory CoinState.loaded(List<CoinModel> coins) = Loaded;

  const factory CoinState.error(String message) = Error;
}
