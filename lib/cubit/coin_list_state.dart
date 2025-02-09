import 'package:coinmerce/models/coin_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'coin_list_state.freezed.dart';

@freezed
class CoinListState with _$CoinListState {
  const CoinListState._();

  const factory CoinListState.initial() = CoinListInitial;

  const factory CoinListState.loading() = CoinListLoading;

  const factory CoinListState.loaded(List<CoinModel> coins) = CoinListLoaded;

  const factory CoinListState.error(String message) = CoinListError;
}
