part of 'product_actor_bloc.dart';

@freezed
class ProductActorEvent with _$ProductActorEvent {
  const factory ProductActorEvent.productAdded(Product product) = _ProductAdded;
  const factory ProductActorEvent.productRemoved(String productId) =
      _ProductRemoved;
}
