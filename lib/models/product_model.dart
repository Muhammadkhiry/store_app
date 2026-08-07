class ProductModel {
  final int id;
  final int? stock;
  final double price;
  final double? weight, discountPercentage, width, height, depth, rating;
  final String title, description, thumbnail;
  final String? category, brand, availabilityStatus;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.thumbnail,
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
      thumbnail: json["thumbnail"],
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
  factory ProductModel.fromFirestore(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      price: (json["price"] as num).toDouble(),
      description: json["description"],
      thumbnail: json["thumbnail"],
      category: json["category"],
      stock: json["stock"],
      brand: json["brand"],
      discountPercentage: (json["discountPercentage"] as num?)?.toDouble(),
      rating: (json["rating"] as num?)?.toDouble(),
      weight: (json["weight"] as num?)?.toDouble(),
      width: (json["width"] as num?)?.toDouble(),
      height: (json["height"] as num?)?.toDouble(),
      depth: (json["depth"] as num?)?.toDouble(),
      availabilityStatus: json["availabilityStatus"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "description": description,
      "thumbnail": thumbnail,
      "category": category,
      "stock": stock,
      "brand": brand,
      "discountPercentage": discountPercentage,
      "rating": rating,
      "weight": weight,
      "dimensions": {"width": 10, "height": 20, "depth": 5},
      "availabilityStatus": availabilityStatus,
    };
  }
}
