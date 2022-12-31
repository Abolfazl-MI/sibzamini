import 'package:json_annotation/json_annotation.dart';
part 'cities_model.g.dart';
@JsonSerializable()

class City {
  String? name;
  String? slug;
  City({this.name, this.slug});

  factory City.fromJson(Map<String,dynamic>json)=>_$CityFromJson(json);

  Map<String,dynamic>toJson()=>_$CityToJson(this);
}
