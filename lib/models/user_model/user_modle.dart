import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_modle.g.dart';

@JsonSerializable()
@immutable
class User extends Equatable {
  final String? name;
  final String? city;
  final String? mobile;
  final int? id;
  User({this.city, this.id, this.mobile, this.name});
  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        city,
        mobile,
        id,
      ];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => $_UserToJson(this);
}
