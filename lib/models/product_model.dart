class ProductModel {
  final String productName;
  final String productImage;
  final String productCategory;
  final bool isSale;
  final double price;
  final String measureUnit;
  final String productId;
  final int quantity;

  ProductModel({
    this.quantity = 1,
    required this.productName,
    required this.productImage,
    required this.productCategory,
    required this.isSale,
    required this.price,
    required this.measureUnit,
    required this.productId,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      productName: json['productName'],
      productImage: json['productImage'],
      productCategory: json['productCategory'],
      isSale: json['isSale'],
      price: json['price'].toDouble(),
      measureUnit: json['measureUnit'],
      productId: json['productId']);
  Map<String, dynamic> toJson() {
    return {
      'quantity': 1,
      'productName': productName,
      'productImage': productImage,
      'productCategory': productCategory,
      'isSale': isSale,
      'price': price,
      'measureUnit': measureUnit,
      'productId': productId,
    };
  }
}
