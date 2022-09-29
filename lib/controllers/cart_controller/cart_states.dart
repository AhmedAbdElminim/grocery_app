abstract class CartStates {}

class CartInitialStates extends CartStates {}

class GetCartProductLoadingStates extends CartStates {}

class GetCartProductSuccessStates extends CartStates {}

class GetCartProductErrorStates extends CartStates {
  final String error;
  GetCartProductErrorStates(this.error);
}

class ChangeQuantityStateStates extends CartStates {}

class MakeOrderLoadingStates extends CartStates {}

class MakeOrderSuccessStates extends CartStates {}

class MakeOrderErrorStates extends CartStates {
  final String error;
  MakeOrderErrorStates(this.error);
}

class ClearCartListLoadingStates extends CartStates {}

class ClearCartListStates extends CartStates {}
