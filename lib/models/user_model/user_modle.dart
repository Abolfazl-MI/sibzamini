import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_modle.g.dart';

@JsonSerializable()
class User extends Equatable {
  String? name;
  String? city;
  String? mobile;
  int? id;
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
