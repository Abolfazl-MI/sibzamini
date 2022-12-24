// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ffi';

import 'package:flutter/cupertino.dart';

import 'package:equatable/equatable.dart';
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
  String  get imgurl =>'https://sunict.ir$pic';
  double  get rateToDouble=>rate!=null?rate!.toDouble():0.0;
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

extension SalonExtension on Salon{
  bool isBookMarked(List<Salon>bookdMarkedSalon)=>bookdMarkedSalon.contains(this);

}

