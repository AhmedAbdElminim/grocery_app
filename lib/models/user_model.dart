class UserModel {
  final String uId;
  final String name;
  final String email;
  final String shippingAddress;

  UserModel(
      {required this.uId,
      required this.name,
      required this.email,
      required this.shippingAddress});
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      uId: json['uId'],
      name: json['name'],
      email: json['email'],
      shippingAddress: json['shippingAddress']);
  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'shippingAddress': shippingAddress
    };
  }
}
