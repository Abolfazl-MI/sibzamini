// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_marked_salon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookMarkedSalon _$BookMarkedSalonFromJson(Map<String, dynamic> json) =>
    BookMarkedSalon(
      id: json['id'] as int?,
      shop: json['shop'] as int?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      pic: json['pic'] as String?,
    );

Map<String, dynamic> _$BookMarkedSalonToJson(BookMarkedSalon instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shop': instance.shop,
      'name': instance.name,
      'address': instance.address,
      'pic': instance.pic,
    };
