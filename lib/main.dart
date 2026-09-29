import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states/sticker_cubit.dart';
import 'ui/_ui.dart';
import 'ui_kit/_ui_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider создает Cubit и делает его доступным для всего дерева виджетов
    return BlocProvider(
      create: (_) => StickerCubit(),
      child: const _AppView(),
    );
  }
}

// Выносим MaterialApp в отдельный виджет, чтобы иметь доступ к context Cubit'а
class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    // BlocBuilder слушает изменения light и перестраивает тему
    return BlocBuilder<StickerCubit, StickerState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Sunny Stickers',
          theme: state.light ? AppTheme.lightTheme : AppTheme.darkTheme,
          home: const HomeScreen(),
        );
      },
    );
  }
}
