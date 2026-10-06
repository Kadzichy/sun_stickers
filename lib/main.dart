import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'states/sticker_state.dart';
import 'ui/app.dart'; // Ваш виджет приложения

void main() {
  runApp(
    // Создаем провайдер на самом верху
    ChangeNotifierProvider(
      create: (context) => StickerState(),
      child: const MyApp(), // Ваш корневой виджет
    ),
  );
}
