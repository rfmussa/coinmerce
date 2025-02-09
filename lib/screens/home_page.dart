import 'package:coinmerce/cubit/coin_list_cubit.dart';
import 'package:coinmerce/cubit/coin_list_state.dart';
import 'package:coinmerce/cubit/theme_cubit.dart';
import 'package:coinmerce/widgets/coin_list_item.dart';
import 'package:coinmerce/widgets/error_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Crypto Tracker'),
        actions: [
          BlocBuilder<ThemeCubit, bool>(
            builder: (context, isDarkMode) {
              return IconButton(
                icon: const Icon(Icons.brightness_6),
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<CoinListCubit>().getCoins(),
        child: BlocBuilder<CoinListCubit, CoinListState>(
          builder: (context, state) {
            return switch (state) {
              CoinListInitial() || CoinListLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              CoinListLoaded(:final coins) => ListView.builder(
                  itemCount: coins.length,
                  itemBuilder: (context, index) => CoinListItem(
                    coin: coins[index],
                  ),
                ),
              CoinListError(:final message) => ErrorStateWidget(
                  message: message,
                  onRetry: () => context.read<CoinListCubit>().getCoins(),
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
