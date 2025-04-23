// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dimension_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dimensions _$DimensionsFromJson(Map<String, dynamic> json) => Dimensions(
  width: (json['width'] as num?)?.toDouble(),
  height: (json['height'] as num?)?.toDouble(),
  depth: (json['depth'] as num?)?.toDouble(),
);

Map<String, dynamic> _$DimensionsToJson(Dimensions instance) =>
    <String, dynamic>{
      if (instance.width case final value?) 'width': value,
      if (instance.height case final value?) 'height': value,
      if (instance.depth case final value?) 'depth': value,
    };
