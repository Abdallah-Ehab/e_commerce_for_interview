import 'package:json_annotation/json_annotation.dart';


part 'category.g.dart';

enum CategoryName {
  beauty('Beauty'),
  fragrances('Fragrances'),
  furniture('Furniture'),
  groceries('Groceries'),
  homeDecoration('Home Decoration'),
  kitchenAccessories('Kitchen Accessories'),
  laptops('Laptops'),
  mensShirts('Mens Shirts'),
  mensShoes('Mens Shoes'),
  mensWatches('Mens Watches'),
  mobileAccessories('Mobile Accessories'),
  motorcycle('Motorcycle'),
  skinCare('Skin Care'),
  smartphones('Smartphones'),
  sportsAccessories('Sports Accessories'),
  sunglasses('Sunglasses'),
  tablets('Tablets'),
  tops('Tops'),
  vehicle('Vehicle'),
  womensBags('Womens Bags'),
  womensDresses('Womens Dresses'),
  womensJewellery('Womens Jewellery'),
  womensShoes('Womens Shoes'),
  womensWatches('Womens Watches');

  final String value;
  const CategoryName(this.value);

  static CategoryName fromString(String value) {
    return CategoryName.values.firstWhere(
      (category) => category.value == value,
      orElse: () => throw Exception('Unknown category name: $value'),
    );
  }
  
}



@JsonSerializable()
class Category {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(
    fromJson: CategoryName.fromString,
    toJson: _categoryNameToString,
  )
  final CategoryName name;

  @JsonKey(includeIfNull: false)
  final String? url;

  Category({
    required this.id,
    required this.name,
    this.url,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  static String _categoryNameToString(CategoryName name) => name.value;
}