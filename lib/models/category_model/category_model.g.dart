// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCategory _$SalonCategoryFromJson(Map<String, dynamic> json) =>
    ServiceCategory(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$SalonCategoryToJson(ServiceCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };
