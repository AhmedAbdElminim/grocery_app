abstract class WishListStates{}
class WishListInitialStates extends WishListStates{}
class GetWishListProductsLoadingStates extends WishListStates{}
class GetWishListProductsSuccessStates extends WishListStates{}
class GetWishListProductsErrorStates extends WishListStates{
  final String error;
  GetWishListProductsErrorStates(this.error);
}
class ClearWishListLoadingStates extends WishListStates{}
class ClearWishListStates extends WishListStates{}
