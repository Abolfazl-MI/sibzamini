
import 'package:json_annotation/json_annotation.dart';

part 'add_banner_model.g.dart';

@JsonSerializable()
class SalonAddBanner{
  int ? id;
  int ? salon;
  String ? image;
  SalonAddBanner({this.id,this.salon,this.image});
  
  factory SalonAddBanner.fromJson(Map<String,dynamic>json)=>_$SalonAddBannerFromJson(json);
  
  Map<String,dynamic>toJson()=>_$SalonAddBannerToJson(this);
}