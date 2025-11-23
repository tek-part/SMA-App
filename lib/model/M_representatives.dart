import 'dart:convert';

Mrepresentatives mrepresentativesFromJson(dynamic str) => Mrepresentatives.fromJson(str);


class Mrepresentatives {
  String name;
  String username;
  String phone;
  String averageRating;
  int numberOfOrders;
  List<RatingsPerCategory> ratingsPerCategory;

  Mrepresentatives({
    required this.name,
    required this.username,
    required this.phone,
    required this.averageRating,
    required this.numberOfOrders,
    required this.ratingsPerCategory,
  });

  factory Mrepresentatives.fromJson(Map<String, dynamic> json) => Mrepresentatives(
    name: json["name"] ?? '',
    username: json["username"] ?? '',
    phone: json["phone"] ?? '',
    averageRating: json["average_rating"] ?? '',
    numberOfOrders: json["number_of_orders"] ?? 0,
    ratingsPerCategory: List<RatingsPerCategory>.from(json["ratings_per_category"].map((x) => RatingsPerCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "phone": phone,
    "average_rating": averageRating ,
    "number_of_orders": numberOfOrders ,
    "ratings_per_category": List<dynamic>.from(ratingsPerCategory.map((x) => x.toJson())),
  };
}

class RatingsPerCategory {
  String name;
  int rateCategoryId;
  int total;

  RatingsPerCategory({
    required this.name,
    required this.rateCategoryId,
    required this.total,
  });

  factory RatingsPerCategory.fromJson(Map<String, dynamic> json) => RatingsPerCategory(
    name: json["name"],
    rateCategoryId: json["rate_category_id"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "rate_category_id": rateCategoryId,
    "total": total,
  };
}
