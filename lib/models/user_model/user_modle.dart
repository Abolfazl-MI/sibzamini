import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_modle.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String? name;
  final String? city;
  final String? mobile;
  final int? id;
  final String ? token;
  const User({this.city, this.id, this.mobile, this.name,this.token});
  @override
 
  List<Object?> get props => [
        name,
        city,
        mobile,
        id,
      ];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
