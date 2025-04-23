// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['_id'] as String,
  title: json['title'] as String,
  price: (json['price'] as num).toDouble(),
  rating: (json['rating'] as num?)?.toDouble(),
  description: json['description'] as String?,
  category: Category.fromJson(json['category'] as Map<String, dynamic>),
  thumbnail: json['thumbnail'] as String,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  reviews:
      (json['reviews'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
  dimensions: Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'price': instance.price,
  if (instance.rating case final value?) 'rating': value,
  if (instance.description case final value?) 'description': value,
  'category': instance.category.toJson(),
  'thumbnail': instance.thumbnail,
  'images': instance.images,
  'reviews': instance.reviews.map((e) => e.toJson()).toList(),
  'dimensions': instance.dimensions.toJson(),
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
