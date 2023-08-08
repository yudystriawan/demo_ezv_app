part of 'product_actor_bloc.dart';

@freezed
class ProductActorState with _$ProductActorState {
  const factory ProductActorState.initial() = _Initial;
  const factory ProductActorState.actionInProgress() = _ActionInProgress;
  const factory ProductActorState.actionFailure(Failure failure) =
      _ActionFailure;
  const factory ProductActorState.successfullyAdded() = _SuccessfullyAdded;
  const factory ProductActorState.successfullyRemoved() = _SuccessfullyRemoved;
}

// @freezed
// class ProductActorState with _$ProductActorState {
//   const factory ProductActorState({
//     required Option<Either<Failure, Unit>> failureOrSuccessOption,
//     @Default(false) bool actionInProgress,
//   }) = _ProductActorState;

//   factory ProductActorState.initial() => ProductActorState(
//         failureOrSuccessOption: none(),
//       );
// }
