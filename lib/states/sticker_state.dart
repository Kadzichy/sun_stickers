import '../data/_data.dart';

class StickerState {
  final List<StickerCategory> categories;
  final List<Sticker> stickers;
  final List<Sticker> stickersByCategory;
  final List<Sticker> cart;
  final List<Sticker> favorite;
  final bool light;

  const StickerState({
    required this.categories,
    required this.stickers,
    required this.stickersByCategory,
    required this.cart,
    required this.favorite,
    required this.light,
  });

  // Начальное состояние
  factory StickerState.initial() {
    return StickerState(
      categories: AppData.categories,
      stickers: AppData.stickers,
      stickersByCategory: AppData.stickers,
      cart: <Sticker>[],
      favorite: <Sticker>[],
      light: true,
    );
  }

  StickerState copyWith({
    List<StickerCategory>? categories,
    List<Sticker>? stickers,
    List<Sticker>? stickersByCategory,
    List<Sticker>? cart,
    List<Sticker>? favorite,
    bool? light,
  }) {
    return StickerState(
      categories: categories ?? this.categories,
      stickers: stickers ?? this.stickers,
      stickersByCategory: stickersByCategory ?? this.stickersByCategory,
      cart: cart ?? this.cart,
      favorite: favorite ?? this.favorite,
      light: light ?? this.light,
    );
  }
}
