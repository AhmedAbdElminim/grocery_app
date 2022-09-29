abstract class OrderStates{}
class OrderInitialStates extends OrderStates{}
class GetOrdersLoadingStates extends OrderStates{}
class GetOrdersSuccessStates extends OrderStates{}
class GetOrdersErrorStates extends OrderStates{
  final String error;
  GetOrdersErrorStates(this.error);
}