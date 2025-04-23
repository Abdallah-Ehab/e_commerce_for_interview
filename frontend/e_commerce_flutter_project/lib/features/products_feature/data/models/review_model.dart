import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class Review {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'user_id')
  final String userId;

  final String comment;

  final int rating;

  Review({
    required this.id,
    required this.userId,
    required this.comment,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}