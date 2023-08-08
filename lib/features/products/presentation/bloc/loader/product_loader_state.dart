part of 'product_loader_bloc.dart';

@freezed
class ProductLoaderState with _$ProductLoaderState {
  const factory ProductLoaderState.initial() = _Initial;
  const factory ProductLoaderState.loadFailure(Failure failure) = _LoadFailure;
  const factory ProductLoaderState.loadInProgress() = _LoadInProgress;
  const factory ProductLoaderState.loadSuccess(KtList<Product> products) =
      _LoadSuccess;
}
