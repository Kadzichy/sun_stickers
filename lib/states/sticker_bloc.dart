import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/_data.dart';
import 'sticker_event.dart';
import 'sticker_state.dart';

class StickerBloc extends Bloc<StickerEvent, StickerState> {
  StickerBloc() : super(StickerState.initial()) {
    on<CategoryTapped>(_onCategoryTapped);
    on<QuantityIncreased>(_onQuantityIncreased);
    on<QuantityDecreased>(_onQuantityDecreased);
    on<AddedToCart>(_onAddedToCart);
    on<RemovedFromCart>(_onRemovedFromCart);
    on<CheckedOut>(_onCheckedOut);
    on<FavoriteToggled>(_onFavoriteToggled);
    on<ThemeToggled>(_onThemeToggled);
  }

  // 1 + 2. Подсветка категории + продукты по категории
  void _onCategoryTapped(CategoryTapped event, Emitter<StickerState> emit) {
    final updatedCategories = state.categories.map((e) {
      if (e.type == event.category.type) {
        return e.copyWith(isSelected: true);
      } else {
        return e.copyWith(isSelected: false);
      }
    }).toList();

    final List<Sticker> filtered;
    if (event.category.type == StickerType.all) {
      filtered = state.stickers;
    } else {
      filtered = state.stickers
          .where((e) => e.type == event.category.type)
          .toList();
    }

    emit(state.copyWith(
      categories: updatedCategories,
      stickersByCategory: filtered,
    ));
  }

  // 4. Увеличить количество
  void _onQuantityIncreased(
      QuantityIncreased event, Emitter<StickerState> emit) {
    final updated = state.stickers.map((e) {
      if (e.id == event.stickerId) {
        return e.copyWith(quantity: e.quantity + 1);
      }
      return e;
    }).toList();

    emit(state.copyWith(
      stickers: updated,
      stickersByCategory: _refilter(updated),
      cart: updated.where((e) => e.cart).toList(),
    ));
  }

  // 4. Уменьшить количество
  void _onQuantityDecreased(
      QuantityDecreased event, Emitter<StickerState> emit) {
    final updated = state.stickers.map((e) {
      if (e.id == event.stickerId) {
        return e.quantity == 1 ? e : e.copyWith(quantity: e.quantity - 1);
      }
      return e;
    }).toList();

    emit(state.copyWith(
      stickers: updated,
      stickersByCategory: _refilter(updated),
      cart: updated.where((e) => e.cart).toList(),
    ));
  }

  // 6. Добавить в корзину
  void _onAddedToCart(AddedToCart event, Emitter<StickerState> emit) {
    final updated = state.stickers.map((e) {
      if (e.id == event.stickerId) {
        return e.copyWith(cart: true);
      }
      return e;
    }).toList();

    emit(state.copyWith(
      stickers: updated,
      stickersByCategory: _refilter(updated),
      cart: updated.where((e) => e.cart).toList(),
    ));
  }

  // 10. Удалить из корзины
  void _onRemovedFromCart(RemovedFromCart event, Emitter<StickerState> emit) {
    final updated = state.stickers.map((e) {
      if (e.id == event.stickerId) {
        return e.copyWith(cart: false, quantity: 1);
      }
      return e;
    }).toList();

    emit(state.copyWith(
      stickers: updated,
      stickersByCategory: _refilter(updated),
      cart: updated.where((e) => e.cart).toList(),
    ));
  }

  // 11. Checkout — чистка корзины
  void _onCheckedOut(CheckedOut event, Emitter<StickerState> emit) {
    Set<int> cartIds = <int>{};
    for (var item in state.cart) {
      cartIds.add(item.id);
    }

    final updated = state.stickers.map((e) {
      if (cartIds.contains(e.id)) {
        return e.copyWith(cart: false, quantity: 1);
      }
      return e;
    }).toList();

    emit(state.copyWith(
      stickers: updated,
      stickersByCategory: _refilter(updated),
      cart: updated.where((e) => e.cart).toList(),
    ));
  }

  // 13. Добавить/удалить из любимых
  void _onFavoriteToggled(FavoriteToggled event, Emitter<StickerState> emit) {
    final updated = state.stickers.map((e) {
      if (e.id == event.stickerId) {
        return e.copyWith(favorite: !e.favorite);
      }
      return e;
    }).toList();

    emit(state.copyWith(
      stickers: updated,
      stickersByCategory: _refilter(updated),
      favorite: updated.where((e) => e.favorite).toList(),
    ));
  }

  // 14. Смена темы
  void _onThemeToggled(ThemeToggled event, Emitter<StickerState> emit) {
    emit(state.copyWith(light: !state.light));
  }

  // --- Вспомогательные методы (аналоги твоих getIndex, getStickerById) ---

  List<Sticker> _refilter(List<Sticker> source) {
    final selected = state.categories.firstWhere(
      (c) => c.isSelected,
      orElse: () => state.categories.first,
    );
    if (selected.type == StickerType.all) return source;
    return source.where((e) => e.type == selected.type).toList();
  }

  int getIndex(int stickerId) {
    return state.stickers.indexWhere((e) => e.id == stickerId);
  }

  Sticker getStickerById(int stickerId) {
    return state.stickers[getIndex(stickerId)];
  }

  String stickerPrice(Sticker sticker) {
    return (sticker.quantity * sticker.price).toString();
  }

  double get subtotal {
    double amount = 0.0;
    for (var e in state.cart) {
      amount = amount + e.price * e.quantity;
    }
    return amount;
  }
}
