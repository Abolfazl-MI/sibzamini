// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_modle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      city: json['city'] as String?,
      id: json['id'] as int?,
      mobile: json['mobile'] as String?,
      name: json['name'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'city': instance.city,
      'mobile': instance.mobile,
      'id': instance.id,
      'token': instance.token,
    };
