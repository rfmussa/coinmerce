import 'package:bloc_test/bloc_test.dart';
import 'package:coinmerce/cubit/coin_list_cubit.dart';
import 'package:coinmerce/cubit/coin_list_state.dart';
import 'package:coinmerce/models/coin_model.dart';
import 'package:coinmerce/services/api_service.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;
  late Faker faker;

  setUp(() {
    mockApiService = MockApiService();
    faker = Faker();
  });

  CoinModel createTestCoin() => CoinModel(
        id: faker.guid.guid(),
        symbol: faker.lorem.word(),
        name: faker.lorem.word(),
        image: faker.internet.httpsUrl(),
        currentPrice: faker.randomGenerator.decimal(),
        marketCapRank: faker.randomGenerator.integer(100),
        dailyPriceChange: faker.randomGenerator.decimal(),
    sparklinePrices: List.generate(7, (_) => faker.randomGenerator.decimal()),
      );

  group('CoinListCubit', () {
    blocTest<CoinListCubit, CoinListState>(
      'initial state is CoinListInitial',
      build: () => CoinListCubit(mockApiService),
      verify: (cubit) => expect(cubit.state, isA<CoinListInitial>()),
    );

    blocTest<CoinListCubit, CoinListState>(
      'emits [Loading, Loaded] when getCoins succeeds',
      build: () {
        final testCoins = List.generate(3, (_) => createTestCoin());
        when(() => mockApiService.getTopCoins())
            .thenAnswer((_) async => testCoins);
        return CoinListCubit(mockApiService);
      },
      act: (cubit) => cubit.getCoins(),
      expect: () => [
        isA<CoinListLoading>(),
        isA<CoinListLoaded>().having(
          (state) => state.coins.length,
          'has correct number of coins',
          equals(3),
        ),
      ],
      verify: (_) => verify(() => mockApiService.getTopCoins()).called(1),
    );

    blocTest<CoinListCubit, CoinListState>(
      'emits [Loading, Error] when getCoins fails',
      build: () {
        final errorMessage = faker.lorem.sentence();
        when(() => mockApiService.getTopCoins())
            .thenThrow(Exception(errorMessage));
        return CoinListCubit(mockApiService);
      },
      act: (cubit) => cubit.getCoins(),
      expect: () => [
        isA<CoinListLoading>(),
        isA<CoinListError>(),
      ],
      verify: (_) => verify(() => mockApiService.getTopCoins()).called(1),
    );

    blocTest<CoinListCubit, CoinListState>(
      'emits [Loading, Loaded] with empty list when API returns empty',
      build: () {
        when(() => mockApiService.getTopCoins()).thenAnswer((_) async => []);
        return CoinListCubit(mockApiService);
      },
      act: (cubit) => cubit.getCoins(),
      expect: () => [
        isA<CoinListLoading>(),
        isA<CoinListLoaded>().having(
          (state) => state.coins,
          'empty coins list',
          isEmpty,
        ),
      ],
      verify: (_) => verify(() => mockApiService.getTopCoins()).called(1),
    );
  });
}
