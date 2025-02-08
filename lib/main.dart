import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme.dart';
import 'cubit/coin_list_cubit.dart';
import 'cubit/coin_list_state.dart';
import 'cubit/theme_cubit.dart';
import 'services/api_service.dart';
import 'widgets/coin_list_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: isDarkMode ? AppTheme.dark : AppTheme.light,
            home: BlocProvider(
              create: (_) => CoinListCubit(ApiService())..getCoins(),
              child: const HomePage(),
            ),
          );
        },
      ),
    );
  }
}

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
                tooltip: 'Toggle theme',
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
              CoinListInitial() => const Center(
                  child: Text('Pull to refresh'),
                ),
              CoinListLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              CoinListLoaded(:final coins) => ListView.builder(
                  itemCount: coins.length,
                  itemBuilder: (context, index) => CoinListItem(
                    coin: coins[index],
                  ),
                ),
              CoinListError(:final message) => Center(
                  child: Text(
                    'Error: $message',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}
