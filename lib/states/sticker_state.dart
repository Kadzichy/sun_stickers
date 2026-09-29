import 'package:equatable/equatable.dart';
import '../data/_data.dart';

class StickerState extends Equatable {
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

  factory StickerState.initial() => StickerState(
    categories: AppData.categories,
    stickers: AppData.stickers,
    stickersByCategory: AppData.stickers,
    cart: const <Sticker>[],
    favorite: const <Sticker>[],
    light: true,
  );

  @override
  List<Object?> get props =>
      [categories, stickers, stickersByCategory, cart, favorite, light];

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

  String stickerPrice(Sticker sticker) =>
      (sticker.quantity * sticker.price).toString();

  double get subtotal {
    double amount = 0.0;
    for (var e in cart) {
      amount += e.price * e.quantity;
    }
    return amount;
  }

  int getIndex(int stickerId) => stickers.indexWhere((e) => e.id == stickerId);

  Sticker getStickerById(int stickerId) => stickers[getIndex(stickerId)];
}
