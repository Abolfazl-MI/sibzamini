// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalonService _$SalonServiceFromJson(Map<String, dynamic> json) => SalonService(
      id: json['id'] as int?,
      name: json['name'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      photo: json['photo'] as String?,
      content: json['content'] as String?,
      cat: json['cat'] as String?,
    );

Map<String, dynamic> _$SalonServiceToJson(SalonService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'photo': instance.photo,
      'content': instance.content,
      'cat': instance.cat,
    };
