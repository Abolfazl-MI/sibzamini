// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalonService _$SalonServiceFromJson(Map<String, dynamic> json) => SalonService(
      photo:
          (json['photo'] as List<dynamic>?)?.map((e) => e as String).toList(),
      content: json['content'] as String?,
      cat: json['cat'] as int?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      amount: json['amount'] as num?,
      samount: json['samount'] as num?,
    );

Map<String, dynamic> _$SalonServiceToJson(SalonService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'samount': instance.samount,
      'photo': instance.photo,
      'content': instance.content,
      'cat': instance.cat,
    };
