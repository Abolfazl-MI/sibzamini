// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'salon_model.g.dart';

@JsonSerializable()
class Salon extends Equatable {
  final int? id;
  final String? name;
  final String? mobile;
  final String? email;
  final String? phone;
  final String? city;
  final String? address;
  final double? lat;
  final double? lng;
  final String? site;
  final String? about;
  final String? pic;
  final int? rate;
  const Salon({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.phone,
    this.city,
    this.address,
    this.lat,
    this.lng,
    this.site,
    this.about,
    this.pic,
    this.rate,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        mobile,
        email,
        phone,
        city,
        address,
        lat,
        lng,
        site,
        about,
        pic,
        rate
      ];

  factory Salon.fromJson(Map<String, dynamic> json) => _$SalonFromJson(json);

  Map<String, dynamic> toMap() => _$SalonToJson(this);
}
