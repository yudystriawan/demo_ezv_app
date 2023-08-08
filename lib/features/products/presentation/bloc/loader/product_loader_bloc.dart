import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:demo_ezv_app/core/usecases/usecase.dart';
import 'package:demo_ezv_app/features/products/domain/usecases/get_favorite_products.dart';
import 'package:demo_ezv_app/features/products/domain/usecases/get_products.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/product/product.dart';

part 'product_loader_bloc.freezed.dart';
part 'product_loader_event.dart';
part 'product_loader_state.dart';

@injectable
class ProductLoaderBloc extends Bloc<ProductLoaderEvent, ProductLoaderState> {
  final GetProducts _getProducts;
  final GetFavoriteProducts _getFavoriteProducts;

  ProductLoaderBloc(
    this._getProducts,
    this._getFavoriteProducts,
  ) : super(ProductLoaderState.initial()) {
    on<_Fetched>(_onFetched);
    on<_FavoriteFetched>(_onFavoriteFetched);
  }

  void _onFetched(
    _Fetched event,
    Emitter<ProductLoaderState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      failureOption: none(),
      favoriteProducts: const KtList.empty(),
    ));

    final failureOrSuccess = await _getProducts(const NoParams());

    ProductLoaderState newState = state.copyWith(isLoading: false);

    emit(await failureOrSuccess.fold(
      (f) async => newState.copyWith(failureOption: optionOf(f)),
      (products) async {
        newState = newState.copyWith(products: products);

        // get favoriteProducts
        final failureOrSuccess = await _getFavoriteProducts(const NoParams());

        return failureOrSuccess.fold(
          (f) => newState.copyWith(failureOption: optionOf(f)),
          (favoriteProducts) =>
              newState.copyWith(favoriteProducts: favoriteProducts),
        );
      },
    ));
  }

  void _onFavoriteFetched(
    _FavoriteFetched event,
    Emitter<ProductLoaderState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      failureOption: none(),
      favoriteProducts: const KtList.empty(),
    ));

    final failureOrSuccess = await _getFavoriteProducts(const NoParams());

    emit(failureOrSuccess.fold(
      (f) => state.copyWith(failureOption: optionOf(f), isLoading: false),
      (favoriteProducts) => state.copyWith(
        favoriteProducts: favoriteProducts,
        isLoading: false,
      ),
    ));
  }
}
