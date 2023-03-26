import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'services_model.g.dart';

@JsonSerializable()
class SalonService extends Equatable {
  final int? id;
  final String? name;
  final num? amount;
  final num?samount;
  final List<String>? photo;
  final String? content;
  final int? cat;

  const SalonService(
    {
    this.photo, 
    this.content, 
    this.cat, 
    this.id,
    this.name,
    this.amount,
    this.samount, 
  });
  String get imgUrl => 'https://sunict.ir$photo';

  factory SalonService.fromJson(Map<String, dynamic> json) =>
      _$SalonServiceFromJson(json);

  Map<String, dynamic> toJson() => _$SalonServiceToJson(this);


  @override
  List<Object?> get props => [id, name, amount, photo, content, cat];
}
