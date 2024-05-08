sealed class CartProductState {}

final class CartProductInitial extends CartProductState {}

final class CartProductAddedSuccessfully extends CartProductState {}

final class CartProductChanged extends CartProductState {}

final class CartProductFailure extends CartProductState {}
