// GENERATED CODE - DO NOT MODIFY BY HAND
 
part of 'sticker_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StickerState on _StickerState, Store {
  Computed<List<Sticker>>? _$stickersByCategoryComputed;

  @override
  List<Sticker> get stickersByCategory =>
      (_$stickersByCategoryComputed ??= Computed<List<Sticker>>(
        () => super.stickersByCategory,
        name: '_StickerState.stickersByCategory',
      )).value;
  Computed<double>? _$subtotalComputed;

  @override
  double get subtotal => (_$subtotalComputed ??= Computed<double>(
    () => super.subtotal,
    name: '_StickerState.subtotal',
  )).value;

  late final _$categoriesAtom = Atom(
    name: '_StickerState.categories',
    context: context,
  );

  @override
  List<StickerCategory> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(List<StickerCategory> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  late final _$stickersAtom = Atom(
    name: '_StickerState.stickers',
    context: context,
  );

  @override
  List<Sticker> get stickers {
    _$stickersAtom.reportRead();
    return super.stickers;
  }

  @override
  set stickers(List<Sticker> value) {
    _$stickersAtom.reportWrite(value, super.stickers, () {
      super.stickers = value;
    });
  }

  late final _$cartAtom = Atom(name: '_StickerState.cart', context: context);

  @override
  List<Sticker> get cart {
    _$cartAtom.reportRead();
    return super.cart;
  }

  @override
  set cart(List<Sticker> value) {
    _$cartAtom.reportWrite(value, super.cart, () {
      super.cart = value;
    });
  }

  late final _$favoriteAtom = Atom(
    name: '_StickerState.favorite',
    context: context,
  );

  @override
  List<Sticker> get favorite {
    _$favoriteAtom.reportRead();
    return super.favorite;
  }

  @override
  set favorite(List<Sticker> value) {
    _$favoriteAtom.reportWrite(value, super.favorite, () {
      super.favorite = value;
    });
  }

  late final _$lightAtom = Atom(name: '_StickerState.light', context: context);

  @override
  bool get light {
    _$lightAtom.reportRead();
    return super.light;
  }

  @override
  set light(bool value) {
    _$lightAtom.reportWrite(value, super.light, () {
      super.light = value;
    });
  }

  late final _$selectedCategoryAtom = Atom(
    name: '_StickerState.selectedCategory',
    context: context,
  );

  @override
  StickerCategory? get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(StickerCategory? value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  late final _$_StickerStateActionController = ActionController(
    name: '_StickerState',
    context: context,
  );

  @override
  void onCategoryTap(StickerCategory category) {
    final _$actionInfo = _$_StickerStateActionController.startAction(
      name: '_StickerState.onCategoryTap',
    );
    try {
      return super.onCategoryTap(category);
    } finally {
      _$_StickerStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onIncreaseQuantityTap(Sticker sticker) {
    final _$actionInfo = _$_StickerStateActionController.startAction(
      name: '_StickerState.onIncreaseQuantityTap',
    );
    try {
      return super.onIncreaseQuantityTap(sticker);
    } finally {
      _$_StickerStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onDecreaseQuantityTap(Sticker sticker) {
    final _$actionInfo = _$_StickerStateActionController.startAction(
      name: '_StickerState.onDecreaseQuantityTap',
    );
    try {
      return super.onDecreaseQuantityTap(sticker);
    } finally {
      _$_StickerStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onAddToCartTap(Sticker sticker) {
    final _$actionInfo = _$_StickerStateActionController.startAction(
      name: '_StickerState.onAddToCartTap',
    );
    try {
      return super.onAddToCartTap(sticker);
    } finally {
      _$_StickerStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onRemoveFromCartTap(Sticker sticker) {
    final _$actionInfo = _$_StickerStateActionController.startAction(
      name: '_StickerState.onRemoveFromCartTap',
    );
    try {
      return super.onRemoveFromCartTap(sticker);
    } finally {
      _$_StickerStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onCheckOutTap() {
    final _$actionInfo = _$_StickerStateActionController.startAction(
      name: '_StickerState.onCheckOutTap',
    );
    try {
      return super.onCheckOutTap();
    } finally {
      _$_StickerStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onAddRemoveFavoriteTap(Sticker sticker) {
    final _$actionInfo = _$_StickerStateActionController.startAction(
      name: '_StickerState.onAddRemoveFavoriteTap',
    );
    try {
      return super.onAddRemoveFavoriteTap(sticker);
    } finally {
      _$_StickerStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleTheme() {
    final _$actionInfo = _$_StickerStateActionController.startAction(
      name: '_StickerState.toggleTheme',
    );
    try {
      return super.toggleTheme();
    } finally {
      _$_StickerStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categories: ${categories},
stickers: ${stickers},
cart: ${cart},
favorite: ${favorite},
light: ${light},
selectedCategory: ${selectedCategory},
stickersByCategory: ${stickersByCategory},
subtotal: ${subtotal}
    ''';
  }
}
