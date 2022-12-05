import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class SalonCategory extends Equatable {
  final int? id;
  final String? name;
  final String? slug;

  const SalonCategory({
    this.id,
    this.name,
    this.slug,
  });
  @override
  List<Object?> get props => [
        id,
        name,
        slug,
      ];

  factory SalonCategory.fromJson(Map<String,dynamic>json)=>_$SalonCategoryFromJson(json);

  Map<String,dynamic> toJson()=>_$SalonCategoryToJson(this);
}
