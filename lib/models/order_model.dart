class OrderModel {
  final int quantity;
  final String orderImage;
  final double totalPrice;
  final String orderDate;
  final String productName;

  final String orderOwnerName;
  final String addressShipping;
  final String orderOwnerUid;

  OrderModel(
      {required this.orderOwnerUid,
      required this.productName,
      required this.quantity,
      required this.orderImage,
      required this.totalPrice,
      required this.orderDate,
      required this.orderOwnerName,
      required this.addressShipping});
  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
      quantity: json['quantity'],
      orderImage: json['orderImage'],
      totalPrice: json['totalPrice'],
      orderDate: json['orderDate'],
      orderOwnerName: json['orderOwnerName'],
      addressShipping: json['addressShipping'],
      productName: json['productName'],
      orderOwnerUid: json['orderOwnerUid']);
  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'orderImage': orderImage,
      'totalPrice': totalPrice,
      'orderDate': orderDate,
      'orderOwnerName': orderOwnerName,
      'addressShipping': addressShipping,
      'productName': productName,
      'orderOwnerUid': orderOwnerUid,
    };
  }
}
