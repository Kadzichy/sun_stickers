import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states/sticker_bloc.dart';
import 'states/sticker_state.dart';
import 'ui/_ui.dart';
import 'ui_kit/_ui_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StickerBloc(),
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StickerBloc, StickerState>(
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
