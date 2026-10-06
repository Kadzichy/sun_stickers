import 'package:equatable/equatable.dart';

import '../models/sticker.dart';
import '../models/sticker_category.dart';

class StickerState extends Equatable {
  const StickerState({
    this.categories = const [],
    this.stickers = const [],
    this.stickersByCategory = const [],
    this.cart = const [],
    this.favorite = const [],
    this.light = true,
  });

  final List<StickerCategory> categories;
  final List<Sticker> stickers;
  final List<Sticker> stickersByCategory;
  final List<Sticker> cart;
  final List<Sticker> favorite;
  final bool light;

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

  @override
  List<Object?> get props => [
        categories,
        stickers,
        stickersByCategory,
        cart,
        favorite,
        light,
      ];
}
