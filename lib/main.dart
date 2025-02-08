import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/coin_list_cubit.dart';
import 'cubit/coin_list_state.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => CoinListCubit(ApiService()),
        child: const HomePage(),
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
        title: const Text('Coin List Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.read<CoinListCubit>().getCoins(),
              child: const Text('Load Coins'),
            ),
            const SizedBox(height: 20),
            BlocBuilder<CoinListCubit, CoinListState>(
              builder: (context, state) {
                return switch (state) {
                  CoinListInitial() => const Text('Load coins'),
                  CoinListLoading() => const CircularProgressIndicator(),
                  CoinListLoaded(:final coins) =>
                    Text('Loaded ${coins.length} coins'),
                  CoinListError(:final message) => Text(
                      'Error: $message'
                    ),
                  _ => throw UnimplementedError(),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
