import '../data/_data.dart';

abstract class StickerEvent {}

// 1. Подсветка выбранной категории + 2. Продукты по категории
class CategoryTapped extends StickerEvent {
  final StickerCategory category;
  CategoryTapped(this.category);
}

// 4. Детали: количество (увеличить)
class QuantityIncreased extends StickerEvent {
  final int stickerId;
  QuantityIncreased(this.stickerId);
}

// 4. Детали: количество (уменьшить)
class QuantityDecreased extends StickerEvent {
  final int stickerId;
  QuantityDecreased(this.stickerId);
}

// 6. Детали: добавление в корзину
class AddedToCart extends StickerEvent {
  final int stickerId;
  AddedToCart(this.stickerId);
}

// 10. Корзина: удаление
class RemovedFromCart extends StickerEvent {
  final int stickerId;
  RemovedFromCart(this.stickerId);
}

// 11. Корзина: чистка на checkout
class CheckedOut extends StickerEvent {}

// 13. Детали: добавление/удаление из любимых
class FavoriteToggled extends StickerEvent {
  final int stickerId;
  FavoriteToggled(this.stickerId);
}

// 14. Смена темы
class ThemeToggled extends StickerEvent {}
