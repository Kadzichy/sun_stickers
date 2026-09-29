import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/_data.dart';
import 'sticker_state.dart';

final stickerProvider =
NotifierProvider<StickerNotifier, StickerState>(StickerNotifier.new);

class StickerNotifier extends Notifier<StickerState> {
  @override
  StickerState build() => StickerState.initial();

  Future<void> onCategoryTap(StickerCategory category) async {
    final categories = state.categories.map((e) {
      if (e.type == category.type) {
        return e.copyWith(isSelected: true);
      } else {
        return e.copyWith(isSelected: false);
      }
    }).toList();

    final stickersByCategory = category.type == StickerType.all
        ? state.stickers
        : state.stickers.where((e) => e.type == category.type).toList();

    state = state.copyWith(
      categories: categories,
      stickersByCategory: stickersByCategory,
    );
  }

  Future<void> onIncreaseQuantityTap(int stickerId) async {
    final stickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(quantity: e.quantity + 1);
      }
      return e;
    }).toList();

    state = state.copyWith(
      stickers: stickers,
      stickersByCategory: _filterBySelectedCategory(stickers),
      cart: _buildCart(stickers),
    );
  }

  Future<void> onDecreaseQuantityTap(int stickerId) async {
    final stickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.quantity == 1 ? e : e.copyWith(quantity: e.quantity - 1);
      }
      return e;
    }).toList();

    state = state.copyWith(
      stickers: stickers,
      stickersByCategory: _filterBySelectedCategory(stickers),
      cart: _buildCart(stickers),
    );
  }

  Future<void> onAddToCartTap(int stickerId) async {
    final stickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(cart: true);
      }
      return e;
    }).toList();

    state = state.copyWith(
      stickers: stickers,
      stickersByCategory: _filterBySelectedCategory(stickers),
      cart: _buildCart(stickers),
    );
  }

  Future<void> onRemoveFromCartTap(int stickerId) async {
    final stickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(cart: false, quantity: 1);
      }
      return e;
    }).toList();

    state = state.copyWith(
      stickers: stickers,
      stickersByCategory: _filterBySelectedCategory(stickers),
      cart: _buildCart(stickers),
    );
  }

  Future<void> onCheckOutTap() async {
    final cartIds = state.cart.map((e) => e.id).toSet();
    final stickers = state.stickers.map((e) {
      if (cartIds.contains(e.id)) {
        return e.copyWith(cart: false, quantity: 1);
      }
      return e;
    }).toList();

    state = state.copyWith(
      stickers: stickers,
      stickersByCategory: _filterBySelectedCategory(stickers),
      cart: _buildCart(stickers),
    );
  }

  Future<void> onAddRemoveFavoriteTap(int stickerId) async {
    final stickers = state.stickers.map((e) {
      if (e.id == stickerId) {
        return e.copyWith(favorite: !e.favorite);
      }
      return e;
    }).toList();

    state = state.copyWith(
      stickers: stickers,
      stickersByCategory: _filterBySelectedCategory(stickers),
      favorite: stickers.where((e) => e.favorite).toList(),
    );
  }

  void toggleTheme() {
    state = state.copyWith(light: !state.light);
  }

  List<Sticker> _buildCart(List<Sticker> stickers) =>
      stickers.where((e) => e.cart).toList();

  List<Sticker> _filterBySelectedCategory(List<Sticker> stickers) {
    final selected = state.categories.firstWhere(
          (c) => c.isSelected,
      orElse: () => StickerCategory(
          type: StickerType.all, isSelected: true),
    );
    if (selected.type == StickerType.all) return stickers;
    return stickers.where((e) => e.type == selected.type).toList();
  }
}
