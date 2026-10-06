import 'package:flutter/material.dart';
// Предполагается, что эти импорты у вас есть в проекте:
// import '../data/app_data.dart'; 
// import '../models/sticker.dart';
// import '../models/sticker_category.dart';

class StickerState extends ChangeNotifier {
  // Убираем Singleton (._internal и factory), так как Provider создает экземпляр сам.
  
  // Переменные
  List<StickerCategory> categories = AppData.categories;
  List<Sticker> stickers = AppData.stickers;
  List<Sticker> stickersByCategory = AppData.stickers;
  List<Sticker> cart = <Sticker>[];
  List<Sticker> favorite = <Sticker>[];
  bool light = true;

  // --- Действия ---

  void selectCategory(StickerCategory category) {
    // Логика подсветки
    for (var e in categories) {
      e.isSelected = (e.type == category.type);
    }
    
    // Фильтрация
    if (category.type == StickerType.all) {
      stickersByCategory = stickers;
    } else {
      stickersByCategory = stickers.where((e) => e.type == category.type).toList();
    }
    notifyListeners(); // Сообщаем UI об изменениях
  }

  void increaseQuantity(Sticker sticker) {
    sticker.quantity++;
    notifyListeners();
  }

  void decreaseQuantity(Sticker sticker) {
    if (sticker.quantity > 1) {
      sticker.quantity--;
      notifyListeners();
    }
  }

  void addToCart(Sticker sticker) {
    sticker.cart = true;
    _updateCartList();
    notifyListeners();
  }

  void removeFromCart(Sticker sticker) {
    sticker.cart = false;
    sticker.quantity = 1;
    _updateCartList();
    notifyListeners();
  }

  void checkOut() {
    for (var e in cart) {
      e.cart = false;
      e.quantity = 1;
    }
    _updateCartList();
    notifyListeners();
  }

  void toggleFavorite(Sticker sticker) {
    sticker.favorite = !sticker.favorite;
    favorite = stickers.where((e) => e.favorite).toList();
    notifyListeners();
  }

  void toggleTheme() {
    light = !light;
    notifyListeners();
  }

  // --- Вспомогательные методы ---

  // Приватный метод для обновления списка корзины, чтобы не дублировать код
  void _updateCartList() {
    cart = stickers.where((e) => e.cart).toList();
  }

  String getStickerPrice(Sticker sticker) {
    return (sticker.quantity * sticker.price).toString();
  }

  double get subtotal {
    double amount = 0.0;
    for (var e in cart) {
      amount += e.price * e.quantity;
    }
    return amount;
  }
}
