part of 'product_loader_bloc.dart';

@freezed
class ProductLoaderEvent with _$ProductLoaderEvent {
  const factory ProductLoaderEvent.fetched() = _Fetched;
  const factory ProductLoaderEvent.favoriteFetched() = _FavoriteFetched;
}
