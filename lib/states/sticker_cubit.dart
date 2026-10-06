import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/app_data.dart';
import '../models/sticker.dart';
import '../models/sticker_category.dart';
import 'sticker_state.dart';

class StickerCubit extends Cubit<StickerState> {
  StickerCubit()
      : super(
          StickerState(
            categories: AppData.categories,
            stickers: AppData.stickers,
            stickersByCategory: AppData.stickers,
          ),
        );

  // 1. Подсветка выбранной категории + 2. Продукты по категории
  Future<void> onCategoryTap(StickerCategory category) async {
    final updatedCategories = state.categories.map((e) {
      e.isSelected = e.type == category.type;
      return e;
    }).toList();

    final stickersByCategory = category.type == StickerType.all
        ? state.stickers
        : state.stickers.where((e) => e.type == category.type).toList();

    emit(state.copyWith(
      categories: updatedCategories,
      stickersByCategory: stickersByCategory,
    ));
  }

  // 4. Детали: количество (увеличение)
  Future<void> onIncreaseQuantityTap(Sticker sticker) async {
    sticker.quantity++;
    emit(state.copyWith(stickers: [...state.stickers]));
  }

  // 4. Детали: количество (уменьшение)
  Future<void> onDecreaseQuantityTap(Sticker sticker) async {
    if (sticker.quantity == 1) return;
    sticker.quantity--;
    emit(state.copyWith(stickers: [...state.stickers]));
  }

  // 6. Детали: добавление в корзину
  Future<void> onAddToCartTap(Sticker sticker) async {
    sticker.cart = true;
    final cart = state.stickers.where((e) => e.cart).toList();
    emit(state.copyWith(cart: cart));
  }

  // 10. Корзина: удаление
  Future<void> onRemoveFromCartTap(Sticker sticker) async {
    sticker.cart = false;
    sticker.quantity = 1;
    final cart = state.stickers.where((e) => e.cart).toList();
    emit(state.copyWith(cart: cart));
  }

  // 11. Корзина: чистка корзины на checkout
  Future<void> onCheckOutTap() async {
    for (var e in state.cart) {
      e.cart = false;
      e.quantity = 1;
    }
    final cart = state.stickers.where((e) => e.cart).toList();
    emit(state.copyWith(cart: cart));
  }

  // 13. Детали: добавление/удаление из любимых
  Future<void> onAddRemoveFavoriteTap(Sticker sticker) async {
    sticker.favorite = !sticker.favorite;
    final favorite = state.stickers.where((e) => e.favorite).toList();
    emit(state.copyWith(favorite: favorite));
  }

  // 14. Смена темы
  void toggleTheme() {
    emit(state.copyWith(light: !state.light));
  }

  // Вспомогательный метод: цена позиции
  String stickerPrice(Sticker sticker) {
    return (sticker.quantity * sticker.price).toString();
  }

  // 8. Корзина: стоимость корзины
  double get subtotal {
    double amount = 0.0;
    for (var e in state.cart) {
      amount += e.price * e.quantity;
    }
    return amount;
  }
}
