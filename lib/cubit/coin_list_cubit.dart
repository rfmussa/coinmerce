import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/api_service.dart';
import 'coin_list_state.dart';

class CoinListCubit extends Cubit<CoinListState> {
  final ApiService _apiService;

  CoinListCubit(this._apiService) : super(const CoinListState.initial());

  Future<void> getCoins() async {
    try {
      emit(const CoinListState.loading());
      final coins = await _apiService.getTopCoins();
      emit(CoinListState.loaded(coins));
    } catch (e) {
      emit(CoinListState.error(e.toString()));
    }
  }
} 