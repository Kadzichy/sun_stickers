import 'package:get/get.dart';
import '../data/_data.dart';
import '../ui/_ui.dart';

class StickerController extends GetxController {
  final categories = AppData.categories.obs;
  final stickers = AppData.stickers.obs;
  final stickersByCategory = AppData.stickers.obs;
  final cart = <Sticker>[].obs;
  final favorite = <Sticker>[].obs;
  final light = true.obs;

  Future<void> onCategoryTap(StickerCategory category) async {
    for (var e in categories) {
      e.isSelected = e.type == category.type;
    }
    categories.refresh();

    if (category.type == StickerType.all) {
      stickersByCategory.value = stickers;
    } else {
      stickersByCategory.value =
          stickers.where((e) => e.type == category.type).toList();
    }
  }

  Future<void> onIncreaseQuantityTap(Sticker sticker) async {
    sticker.quantity++;
    stickers.refresh();
    _syncCartAndFavorite();
  }

  Future<void> onDecreaseQuantityTap(Sticker sticker) async {
    if (sticker.quantity == 1) return;
    sticker.quantity--;
    stickers.refresh();
    _syncCartAndFavorite();
  }

  Future<void> onAddToCartTap(Sticker sticker) async {
    sticker.cart = true;
    stickers.refresh();
    _syncCartAndFavorite();
  }

  Future<void> onRemoveFromCartTap(Sticker sticker) async {
    sticker.cart = false;
    sticker.quantity = 1;
    stickers.refresh();
    _syncCartAndFavorite();
  }

  Future<void> onCheckOutTap() async {
    for (var e in cart) {
      e.cart = false;
      e.quantity = 1;
    }
    stickers.refresh();
    _syncCartAndFavorite();
  }

  Future<void> onAddRemoveFavoriteTap(Sticker sticker) async {
    sticker.favorite = !sticker.favorite;
    stickers.refresh();
    _syncCartAndFavorite();
  }

  void toggleTheme() {
    light.value = !light.value;
  }

  void _syncCartAndFavorite() {
    cart.value = stickers.where((e) => e.cart).toList();
    favorite.value = stickers.where((e) => e.favorite).toList();
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
}
