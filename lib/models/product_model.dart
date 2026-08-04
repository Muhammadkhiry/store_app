class ProductModel {
  final int id;
  final int? stock;
  final double price;
  final double? weight, discountPercentage, width, height, depth, rating;
  final String title, description, image;
  final String? category, brand, availabilityStatus;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    this.category,
    this.discountPercentage,
    this.stock,
    this.brand,
    this.weight,
    this.width,
    this.height,
    this.depth,
    this.availabilityStatus,
    this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      price: (json["price"] as num).toDouble(),
      description: json["description"],
      image: (json["images"] as List).isNotEmpty ? json["images"][0] : "",
      category: json["category"],
      stock: json["stock"],
      brand: json["brand"],
      discountPercentage: (json["discountPercentage"] as num?)?.toDouble(),

      rating: (json["rating"] as num?)?.toDouble(),

      weight: (json["weight"] as num?)?.toDouble(),

      width: (json["dimensions"]["width"] as num?)?.toDouble(),

      height: (json["dimensions"]["height"] as num?)?.toDouble(),

      depth: (json["dimensions"]["depth"] as num?)?.toDouble(),
      availabilityStatus: json["availabilityStatus"],
    );
  }
}
