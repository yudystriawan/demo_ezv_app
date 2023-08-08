import 'package:bloc/bloc.dart';
import 'package:demo_ezv_app/features/products/domain/usecases/add_favorite.dart';
import 'package:demo_ezv_app/features/products/domain/usecases/remove_favorite.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/product/product.dart';

part 'product_actor_bloc.freezed.dart';
part 'product_actor_event.dart';
part 'product_actor_state.dart';

@injectable
class ProductActorBloc extends Bloc<ProductActorEvent, ProductActorState> {
  final AddFavorite _addFavorite;
  final RemoveFavorite _removeFavorite;

  ProductActorBloc(
    this._addFavorite,
    this._removeFavorite,
  ) : super(const ProductActorState.initial()) {
    on<_ProductAdded>(_onProductAdded);
    on<_ProductRemoved>(_onProductRemoved);
  }

  void _onProductAdded(
    _ProductAdded event,
    Emitter<ProductActorState> emit,
  ) async {
    emit(const ProductActorState.actionInProgress());

    final failureOrSuccess =
        await _addFavorite(AddFavoriteParams(product: event.product));

    emit(failureOrSuccess.fold(
      (f) => ProductActorState.actionFailure(f),
      (_) => const ProductActorState.successfullyAdded(),
    ));
  }

  void _onProductRemoved(
    _ProductRemoved event,
    Emitter<ProductActorState> emit,
  ) async {
    emit(const ProductActorState.actionInProgress());

    final failureOrSuccess =
        await _removeFavorite(RemoveFavoriteParams(productId: event.productId));

    emit(failureOrSuccess.fold(
      (f) => ProductActorState.actionFailure(f),
      (_) => const ProductActorState.successfullyRemoved(),
    ));
  }
}
