import 'package:flutter/widgets.dart' hide Title;
import 'package:flutter_riverpod/legacy.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';
import 'package:teslo_shop/features/shared/infraestructure/inputs/inputs.dart';

final productFormProvider = StateNotifierProvider.autoDispose
    .family<ProductFormNotifier, ProductFormState, Product>((ref, product) {
  // final createUpdateCallback =
  // ref.watch(productsRepositoryProvider).createUpdateProduct;

  final createUpdateCallback =
      ref.read(productsProvider.notifier).createOrUpdateProduct;

  return ProductFormNotifier(
      product: product, onSubmitCallback: createUpdateCallback);
});

class ProductFormNotifier extends StateNotifier<ProductFormState> {
  final void Function(Map<String, dynamic> productLike)? onSubmitCallback;

  ProductFormNotifier({this.onSubmitCallback, required Product product})
      : super(ProductFormState(
          id: (product.id == 'new') ? null : product.id,
          title: Title.dirty(product.title),
          slug: Slug.dirty(product.slug),
          price: Price.dirty(product.price),
          sizes: product.sizes,
          gender: product.gender,
          inStock: Stock.dirty(product.stock.toDouble()),
          description: product.description,
          tags: product.tags.join(', '),
          images: product.images,
        ));

  Future<bool> onFormSubmit() async {
    _touchedEverything();
    if (!state.isFormValid) return false;

    if (onSubmitCallback == null) return false;

    final productLike = {
      'id': state.id,
      'title': state.title.value,
      'slug': state.slug.value,
      'price': state.price.value,
      'sizes': state.sizes,
      'gender': state.gender,
      'stock': state.inStock.value.toInt(),
      'description': state.description,
      'tags': state.tags.split(','),
      'images': state.images
          .map((image) =>
              image.replaceAll('${Environment.apiUrl}/files/product/', ''))
          .toList(),
    };

    if (onSubmitCallback != null) {
      onSubmitCallback!(productLike);
    }
    return true;
  }

  void _touchedEverything() {
    state = state.copyWith(
      title: Title.dirty(state.title.value),
      slug: Slug.dirty(state.slug.value),
      price: Price.dirty(state.price.value),
      inStock: Stock.dirty(state.inStock.value),
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  void onTitleChanged(String value) {
    state = state.copyWith(
      title: Title.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  void onSlugChanged(String value) {
    state = state.copyWith(
      slug: Slug.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  void onPriceChanged(double value) {
    state = state.copyWith(
      price: Price.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  void onStockChanged(double value) {
    state = state.copyWith(
      inStock: Stock.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(value),
      ]),
    );
  }

  void onSizesChanged(List<String> sizes) {
    state = state.copyWith(sizes: sizes);
  }

  void onGenderChanged(String gender) {
    state = state.copyWith(gender: gender);
  }

  void onDescriptionChanged(String description) {
    state = state.copyWith(description: description);
  }

  void onTagsChanged(String tags) {
    state = state.copyWith(tags: tags);
  }
}

class ProductFormState {
  final bool isFormValid;
  final String? id;
  final Title title;
  final Slug slug;
  final Price price;
  final List<String> sizes;
  final String gender;
  final Stock inStock;
  final String description;
  final String tags;
  final List<String> images;

  ProductFormState({
    this.isFormValid = false,
    this.id,
    this.title = const Title.dirty(''),
    this.slug = const Slug.dirty(''),
    this.price = const Price.dirty(0),
    this.sizes = const [],
    this.gender = 'men',
    this.inStock = const Stock.dirty(0),
    this.description = '',
    this.tags = '',
    this.images = const [],
  });

  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    Title? title,
    Slug? slug,
    Price? price,
    List<String>? sizes,
    String? gender,
    Stock? inStock,
    String? description,
    String? tags,
    List<String>? images,
  }) {
    return ProductFormState(
      isFormValid: isFormValid ?? this.isFormValid,
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      price: price ?? this.price,
      sizes: sizes ?? this.sizes,
      gender: gender ?? this.gender,
      inStock: inStock ?? this.inStock,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      images: images ?? this.images,
    );
  }
}
