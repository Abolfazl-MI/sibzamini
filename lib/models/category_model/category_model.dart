import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class Category extends Equatable {
  final int? id;
  final String? name;
  final String? slug;

  const Category({
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

  factory Category.fromJson(Map<String,dynamic>json)=>_$CategoryFromJson(json);

  Map<String,dynamic> toJson()=>_$CategoryToJson(this);
}
