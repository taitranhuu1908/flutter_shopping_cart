class Product {
  int? id;
  String? title;
  String? price;
  String? description;
  String? image;
  String? category;
  int? quantity;
  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.image,
    this.quantity,
    this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      price: json['price'].toString(),
      description: json['description'],
      image: json['image'],
    );
  }
}
