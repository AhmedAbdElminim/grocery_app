abstract class AuthStates{}
class AuthInitialStates extends AuthStates{}
class RegisterNewUserLoadingStates extends AuthStates{}
class RegisterNewUserSuccessStates extends AuthStates{}
class RegisterNewUserErrorStates extends AuthStates{
  final String error;
  RegisterNewUserErrorStates(this.error);
}
class CreateNewUserErrorStates extends AuthStates{
  final String error;
  CreateNewUserErrorStates(this.error);
}
class LoginUserLoadingStates extends AuthStates{}
class LoginUserSuccessStates extends AuthStates{}
class LoginUserErrorStates extends AuthStates{
  final String error;
  LoginUserErrorStates(this.error);
}
class GetUserDataLoadingStates extends AuthStates{}
class GetUserDataSuccessStates extends AuthStates{}
class GetUserDataErrorStates extends AuthStates{
  final String error;
  GetUserDataErrorStates(this.error);
}