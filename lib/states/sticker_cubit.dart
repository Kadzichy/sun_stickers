import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/_data.dart';
import 'sticker_state.dart';

class StickerCubit extends Cubit<StickerState> {
  StickerCubit() : super(StickerState.initial());

  // 1. Подсветка выбранной категории + 2. Продукты по категории
  void onCategoryTap(StickerCategory category) {
    final updatedCategories = state.categories.map((e) {
      if (e.type == category.type) {
        return e.copyWith(isSelected: true);
      } else {
        return e.copyWith(isSelected: false);
      }
    }).toList();

    List<Sticker> filteredStickers;
    if (category.type == StickerType.all) {
      filteredStickers = state.stickers;
    } else {
      filteredStickers = state.stickers.where((e) => e.type == category.type).toList();
    }

    emit(state.copyWith(
      categories: updatedCategories,
      stickersByCategory: filteredStickers,
    ));
  }

  // 4. Детали: количество (Увеличить)
  void onIncreaseQuantityTap(int stickerId) {
    final updatedStickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(quantity: e.quantity + 1);
      }
      return e;
    }).toList();

    // Обновляем также отфильтрованный список, если он используется
    final updatedFiltered = _updateFilteredList(updatedStickers, state.stickersByCategory);
    
    emit(state.copyWith(
      stickers: updatedStickers,
      stickersByCategory: updatedFiltered,
      cart: updatedStickers.where((e) => e.cart).toList(),
    ));
  }

  // 4. Детали: количество (Уменьшить)
  void onDecreaseQuantityTap(int stickerId) {
    final updatedStickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.quantity == 1 ? e : e.copyWith(quantity: e.quantity - 1);
      }
      return e;
    }).toList();

    final updatedFiltered = _updateFilteredList(updatedStickers, state.stickersByCategory);

    emit(state.copyWith(
      stickers: updatedStickers,
      stickersByCategory: updatedFiltered,
      cart: updatedStickers.where((e) => e.cart).toList(),
    ));
  }

  // 6. Детали: добавление в корзину
  void onAddToCartTap(int stickerId) {
    final updatedStickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(cart: true);
      }
      return e;
    }).toList();

    final updatedFiltered = _updateFilteredList(updatedStickers, state.stickersByCategory);

    emit(state.copyWith(
      stickers: updatedStickers,
      stickersByCategory: updatedFiltered,
      cart: updatedStickers.where((e) => e.cart).toList(),
    ));
  }

  // 10. Корзина: удаление
  void onRemoveFromCartTap(int stickerId) {
    final updatedStickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(cart: false, quantity: 1);
      }
      return e;
    }).toList();

    final updatedFiltered = _updateFilteredList(updatedStickers, state.stickersByCategory);

    emit(state.copyWith(
      stickers: updatedStickers,
      stickersByCategory: updatedFiltered,
      cart: updatedStickers.where((e) => e.cart).toList(),
    ));
  }

  // 11. Корзина: чистка корзины на checkout
  void onCheckOutTap() {
    final cartIds = state.cart.map((e) => e.id).toSet();
    final updatedStickers = state.stickers.map((e) {
      if (cartIds.contains(e.id)) {
        return e.copyWith(cart: false, quantity: 1);
      }
      return e;
    }).toList();

    final updatedFiltered = _updateFilteredList(updatedStickers, state.stickersByCategory);

    emit(state.copyWith(
      stickers: updatedStickers,
      stickersByCategory: updatedFiltered,
      cart: [], // Корзина пуста
    ));
  }

  // 13. Детали: Добавление/удаление любимые
  void onAddRemoveFavoriteTap(int stickerId) {
    final updatedStickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(favorite: !e.favorite);
      }
      return e;
    }).toList();

    final updatedFiltered = _updateFilteredList(updatedStickers, state.stickersByCategory);

    emit(state.copyWith(
      stickers: updatedStickers,
      stickersByCategory: updatedFiltered,
      favorite: updatedStickers.where((e) => e.favorite).toList(),
    ));
  }

  // 14. Смена темы
  void toggleTheme() {
    emit(state.copyWith(light: !state.light));
  }

  // --- Вспомогательные методы ---

  // Обновляет список отфильтрованных стикеров на основе новых данных
  List<Sticker> _updateFilteredList(List<Sticker> newStickers, List<Sticker> currentFiltered) {
    // Если фильтр "Все", возвращаем все стикеры
    if (state.categories.firstWhere((c) => c.isSelected).type == StickerType.all) {
      return newStickers;
    }
    // Иначе фильтруем по текущей выбранной категории
    final selectedCategory = state.categories.firstWhere((c) => c.isSelected);
    return newStickers.where((e) => e.type == selectedCategory.type).toList();
  }

  // 8. Корзина: стоимость корзины
  double get subtotal {
    double amount = 0.0;
    for (var e in state.cart) {
      amount = amount + e.price * e.quantity;
    }
    return amount;
  }

  // Вспомогательный метод для цены (если нужен)
  String stickerPrice(Sticker sticker) {
    return (sticker.quantity * sticker.price).toString();
  }

  Sticker getStickerById(int stickerId) {
    return state.stickers.firstWhere((e) => e.id == stickerId);
  }
}
