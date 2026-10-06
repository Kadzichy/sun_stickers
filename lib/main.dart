import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states/sticker_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => StickerCubit(),
      child: const MyApp(),
    ),
  );
}
