// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Salon _$SalonFromJson(Map<String, dynamic> json) => Salon(
      id: json['id'] as int?,
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      city: json['city'] as String?,
      address: json['address'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      site: json['site'] as String?,
      about: json['about'] as String?,
      pic: json['pic'] as String?,
      rate: json['rate'] as int?,
    );

Map<String, dynamic> _$SalonToJson(Salon instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'email': instance.email,
      'phone': instance.phone,
      'city': instance.city,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'site': instance.site,
      'about': instance.about,
      'pic': instance.pic,
      'rate': instance.rate,
    };
