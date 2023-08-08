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
  ) : super(const ProductLoaderState.initial()) {
    on<_Fetched>(_onFetched);
    on<_FavoriteFetched>(_onFavoriteFetched);
  }

  Future<ProductLoaderState> _onFetchToState(ProductLoaderEvent event) async {
    late Either<Failure, KtList<Product>> failureOrSuccess;
    if (event is _FavoriteFetched) {
      failureOrSuccess = await _getFavoriteProducts(const NoParams());
    } else {
      failureOrSuccess = await _getProducts(const NoParams());
    }

    return failureOrSuccess.fold(
      (failure) => ProductLoaderState.loadFailure(failure),
      (products) => ProductLoaderState.loadSuccess(products),
    );
  }

  void _onFetched(
    _Fetched event,
    Emitter<ProductLoaderState> emit,
  ) async {
    emit(const ProductLoaderState.loadInProgress());

    emit(await _onFetchToState(event));
  }

  void _onFavoriteFetched(
    _FavoriteFetched event,
    Emitter<ProductLoaderState> emit,
  ) async {
    emit(const ProductLoaderState.loadInProgress());

    emit(await _onFetchToState(event));
  }
}
