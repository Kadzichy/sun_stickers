import 'package:flutter/material.dart'; 
import 'package:mobx/mobx.dart';

import '../data/_data.dart';

part 'sticker_state.g.dart'; 

// ignore: library_private_types_in_public_api
class StickerState = _StickerState with _$StickerState;

abstract class _StickerState with Store {
  // --- Переменные (Observable) ---
  
  @observable
  List<StickerCategory> categories = AppData.categories;

  @observable
  List<Sticker> stickers = AppData.stickers;

  @observable
  List<Sticker> cart = <Sticker>[];

  @observable
  List<Sticker> favorite = <Sticker>[];

  @observable
  bool light = true;

  // Мы храним выбранную категорию, чтобы вычислять список стикеров
  @observable
  StickerCategory? selectedCategory;

  // --- Вычисляемые свойства (Computed) ---

  // Автоматически пересчитывается при изменении selectedCategory или stickers
  @computed
  List<Sticker> get stickersByCategory {
    if (selectedCategory == null || selectedCategory!.type == StickerType.all) {
      return stickers;
    }
    return stickers.where((e) => e.type == selectedCategory!.type).toList();
  }

  // Автоматически пересчитывается при изменении cart
  @computed
  double get subtotal {
    double amount = 0.0;
    for (var e in cart) {
      amount = amount + e.price * e.quantity;
    }
    return amount;
  }

  // --- Действия (Actions) ---

  @action
  void onCategoryTap(StickerCategory category) {
    // Сбрасываем выделение у всех
    for (var e in categories) {
      e.isSelected = (e.type == category.type);
    }
    // Устанавливаем выбранную категорию
    selectedCategory = category;
  }

  @action
  void onIncreaseQuantityTap(Sticker sticker) {
    sticker.quantity++;
  }

  @action
  void onDecreaseQuantityTap(Sticker sticker) {
    if (sticker.quantity == 1) return;
    sticker.quantity--;
  }

  @action
  void onAddToCartTap(Sticker sticker) {
    sticker.cart = true;
    _updateCartList();
  }

  @action
  void onRemoveFromCartTap(Sticker sticker) {
    sticker.cart = false;
    sticker.quantity = 1;
    _updateCartList();
  }

  @action
  void onCheckOutTap() {
    for (var e in cart) {
      e.cart = false;
      e.quantity = 1;
    }
    cart.clear(); // Или _updateCartList() если нужно пересчитать
  }

  @action
  void onAddRemoveFavoriteTap(Sticker sticker) {
    sticker.favorite = !sticker.favorite;
    _updateFavoriteList();
  }

  @action
  void toggleTheme() {
    light = !light;
  }

  // --- Вспомогательные методы ---

  // Обновляем список корзины на основе флагов в стикерах
  void _updateCartList() {
    cart = stickers.where((e) => e.cart).toList();
  }

  // Обновляем список избранного
  void _updateFavoriteList() {
    favorite = stickers.where((e) => e.favorite).toList();
  }

  // Метод для цены (оставил как есть, но лучше вынести в UI или модель)
  String stickerPrice(Sticker sticker) {
    return (sticker.quantity * sticker.price).toString();
  }
}
