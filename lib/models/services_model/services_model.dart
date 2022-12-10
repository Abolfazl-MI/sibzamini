import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'services_model.g.dart';

@JsonSerializable()
class SalonService extends Equatable {
  final int? id;
  final String? name;
  final double? amount;
  final String? photo;
  final String? content;
  final String? cat;

  const SalonService({
    this.id,
    this.name,
    this.amount,
    this.photo,
    this.content,
    this.cat,
  });
  String get imgUrl => 'https://sunict.ir$photo';

  factory SalonService.fromJson(Map<String, dynamic> json) =>
      _$SalonServiceFromJson(json);

  Map<String, dynamic> toJson() => _$SalonServiceToJson(this);
  @override
  List<Object?> get props => [id, name, amount, photo, content, cat];
}
