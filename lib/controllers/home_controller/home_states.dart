abstract class HomeStates {}

class HomeInitialState extends HomeStates {}
class GetDataLoadingState extends HomeStates {}
class GetDataSuccessState extends HomeStates {}
class GetDataErrorState extends HomeStates {
  final String error;
  GetDataErrorState(this.error);
}
class AddToCartLoadingState extends HomeStates {}
class AddToCartSuccessState extends HomeStates {}
class AddToCartErrorState extends HomeStates {
  final String error;
  AddToCartErrorState(this.error);
}
class AddToWishListLoadingState extends HomeStates {}
class AddToWishListSuccessState extends HomeStates {}
class AddToWishListErrorState extends HomeStates {
  final String error;
  AddToWishListErrorState(this.error);
}
