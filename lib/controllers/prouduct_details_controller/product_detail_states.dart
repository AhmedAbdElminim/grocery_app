abstract class ProductDetailsStates {}

class ProductDetailInitialState extends ProductDetailsStates {}

class AddToCartLoadingInProductDetailScreenState extends ProductDetailsStates {}

class AddToCartSuccessInProductDetailScreenState extends ProductDetailsStates {}

class AddToCartErrorInProductDetailScreenState extends ProductDetailsStates {
  final String error;
  AddToCartErrorInProductDetailScreenState(this.error);
}

class AddToWishListLoadingInProductDetailScreenState
    extends ProductDetailsStates {}

class AddWishListSuccessInProductDetailScreenState
    extends ProductDetailsStates {}

class AddWishListErrorInProductDetailScreenState extends ProductDetailsStates {
  final String error;
  AddWishListErrorInProductDetailScreenState(this.error);
}

class ChangeQuantityInProductDetailScreenState extends ProductDetailsStates {}

class ChangeTotalPriceInProductDetailScreenState extends ProductDetailsStates {}
