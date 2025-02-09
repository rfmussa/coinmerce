import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme.dart';
import 'cubit/coin_list_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'screens/home_page.dart';
import 'services/api_service.dart';

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
