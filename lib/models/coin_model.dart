import 'package:freezed_annotation/freezed_annotation.dart';

part 'coin_model.freezed.dart';
part 'coin_model.g.dart';

@freezed
class CoinModel with _$CoinModel {
  const factory CoinModel({
    required String id,
    required String symbol,
    required String name,
    required String image,
    @JsonKey(name: 'current_price', defaultValue: 0.0)
    required double currentPrice,
    @JsonKey(name: 'market_cap_rank', defaultValue: 0)
    required int marketCapRank,
    @JsonKey(name: 'price_change_percentage_24h', defaultValue: 0.0)
    required double dailyPriceChange,
  }) = _CoinModel;

  factory CoinModel.fromJson(Map<String, dynamic> json) =>
      _$CoinModelFromJson(json);
}
