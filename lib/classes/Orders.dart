class ImageData {
  String data;
  String contentType;

  ImageData({required this.data, required this.contentType});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      data: json['data'],
      contentType: json['contentType'],
    );
  }
}

class OrderProductObj {
  String id;
  String name;
  String description;
  double price;
  String category;
  int stockQuantity;
  ImageData image;

  OrderProductObj({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.stockQuantity,
    required this.image,
  });

  factory OrderProductObj.fromJson(Map<String, dynamic> json) {
    return OrderProductObj(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      category: json['category'],
      stockQuantity: json['stockQuantity'],
      image: ImageData.fromJson(json['image']),
    );
  }
}

class OrderProduct {
  OrderProductObj product;
  int quantity;

  OrderProduct({
    required this.product,
    required this.quantity,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      product: OrderProductObj.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}

class Order {
  String id;
  String user;
  List<OrderProduct> products;
  double totalPrice;
  String paymentStatus;
  DateTime createdAt;
  DateTime updatedAt;

  Order({
    required this.id,
    required this.user,
    required this.products,
    required this.totalPrice,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var productList = (json['products'] as List)
        .map((item) => OrderProduct.fromJson(item))
        .toList();

    return Order(
      id: json['_id'],
      user: json['user'],
      products: productList,
      totalPrice: json['totalPrice'].toDouble(),
      paymentStatus: json['paymentStatus'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
