part of 'product_loader_bloc.dart';

@freezed
class ProductLoaderState with _$ProductLoaderState {
  const factory ProductLoaderState({
    required KtList<Product> products,
    required KtList<Product> favoriteProducts,
    required Option<Failure> failureOption,
    @Default(false) bool isLoading,
  }) = _ProductLoaderState;

  factory ProductLoaderState.initial() => ProductLoaderState(
        products: const KtList.empty(),
        favoriteProducts: const KtList.empty(),
        failureOption: none(),
      );
}
