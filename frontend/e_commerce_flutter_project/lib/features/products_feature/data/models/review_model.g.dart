// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
  id: json['_id'] as String,
  userId: json['user_id'] as String,
  comment: json['comment'] as String,
  rating: (json['rating'] as num).toInt(),
);

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
  '_id': instance.id,
  'user_id': instance.userId,
  'comment': instance.comment,
  'rating': instance.rating,
};
