class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final String category;
  final String subCategory;
  final double rating;
  final int reviewCount;
  final String description;
  final List<String> features;
  final bool isBestseller;
  final bool isNewArrival;


  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
    required this.subCategory,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.features,
    this.isBestseller = false,
    this.isNewArrival = false,
  });

}
