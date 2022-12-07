import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class ServiceCategory extends Equatable {
  final int? id;
  final String? name;
  final String? slug;

  const ServiceCategory({
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

  factory ServiceCategory.fromJson(Map<String,dynamic>json)=>_$SalonCategoryFromJson(json);

  Map<String,dynamic> toJson()=>_$SalonCategoryToJson(this);
}
