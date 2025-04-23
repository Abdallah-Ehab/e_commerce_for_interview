import 'package:json_annotation/json_annotation.dart';

part 'dimension_model.g.dart';

@JsonSerializable()
class Dimensions {
  @JsonKey(includeIfNull: false)
  final double? width;

  @JsonKey(includeIfNull: false)
  final double? height;

  @JsonKey(includeIfNull: false)
  final double? depth;

  Dimensions({
    this.width,
    this.height,
    this.depth,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) => _$DimensionsFromJson(json);
  Map<String, dynamic> toJson() => _$DimensionsToJson(this);
}