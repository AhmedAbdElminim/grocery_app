abstract class CategoryStates{}
class CategoryInitialStates extends CategoryStates{}
class GetCategoryProductsLoadingStates extends CategoryStates{}
class GetCategoryProductsSuccessStates extends CategoryStates{}
class GetCategoryProductsErrorStates extends CategoryStates{
  final String error;
  GetCategoryProductsErrorStates(this.error);
}