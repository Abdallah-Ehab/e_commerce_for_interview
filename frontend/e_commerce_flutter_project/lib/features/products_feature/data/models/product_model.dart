import 'package:e_commerce_flutter_project/features/products_feature/data/models/category.dart';
import 'package:e_commerce_flutter_project/features/products_feature/data/models/dimension_model.dart';
import 'package:e_commerce_flutter_project/features/products_feature/data/models/review_model.dart';
import 'package:json_annotation/json_annotation.dart';



part 'product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  @JsonKey(name:"_id")
  final String id;
  final String title;
  final double price;
  
  @JsonKey(includeIfNull: false) 
  final double? rating; 
  
  @JsonKey(includeIfNull: false)
  final String? description;
  
  final Category category; 
  final String thumbnail;
  final List<String> images;
  final List<Review> reviews;
  final Dimensions dimensions;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.rating,
    this.description,
    required this.category,
    required this.thumbnail,
    required this.images,
    required this.reviews,
    required this.dimensions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String,dynamic> json)=>_$ProductFromJson(json);
  Map<String,dynamic> toJson()=>_$ProductToJson(this);
}
